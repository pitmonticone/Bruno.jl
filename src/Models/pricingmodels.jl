"""
## Description 
The functions needed to run a binomial tree
https://magnimetrics.com/understanding-the-binomial-option-pricing-model/
"""

function price(fin_obj::EuroCallOption, pricing_model::Type{BinomialTree})
    println("We are working with an Euro call option")
    println(fin_obj)
end

function price(fin_obj::AmericanCallOption,  pricing_model::Type{BinomialTree})
    println("We are workign with an American call option")
    println(fin_obj)
end

function b_tree(tree_depth, r, strike_price, time_to_mature, delta)
    """ 
    EURO OPTION
    tree_depth = the depth of the tree
    r = rate of return
    sigma = volatility
    strike_price = the strike price in dollars
    time_to_mature = time to maturity in years (.5 == 1/2 year) || (1 == 1 year)
    delta = intrest rate
    """
    S0 = 41  # Starting Price  replace me with widget last price
    sigma = .3  # get sigma from widget price history
    dt = time_to_mature / tree_depth

    u = exp((r - delta) * dt + sigma * sqrt(dt))  # up movement 
    d = exp((r - delta) * dt - sigma * sqrt(dt))  # down movement
    p = (exp(r * dt) - d) / (u - d)  # risk neutral probability of an up move
    
    c = 0
    # value of the call is a weighted average of the values at each node multiplied by the corresponding probability value
    for k in tree_depth:-1:0
        p_star = (factorial(tree_depth) / (factorial(tree_depth - k) * factorial(k))) * p ^ k * (1 - p) ^ (tree_depth - k)
        ST = S0 * u ^ k * d ^ (tree_depth - k)
        c += max(ST - strike_price, 0) * p_star
    end

    exp(-r * time_to_mature) * c
end