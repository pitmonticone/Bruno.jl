using Statistics: std
# place to put all widgets, or assets that don't need a model for the base value. 
# examples: oil, stocks, etc.

function volatility(prices) 
    returns = [((prices[i+1] - prices[i])/ prices[i]) + 1 for i in 1:(length(prices) - 1)]
    cont_return = log.(returns)
    std(cont_return) 
end

abstract type Widget end

struct Stock <: Widget 
    prices::Array{AbstractFloat}
    name::String
    volatility::AbstractFloat
    
    # constructor for kwargs
    function Stock(; prices, name = "", volatility = volatility(prices))
        @assert size(prices)[1] > 0 "Prices cannot be an empty vector"
        new(prices, name, volatility)
    end

    # constructor for ordered argumentes 
    function Stock(prices, name = "", volatility = volatility(prices))  
        new(prices, name, volatility)
    end
end

# outer constructor to make a stock with a (static) single price
function Stock(price::Real; name = "", volatility)
    prices = [price]
    Stock(;prices = prices, name = name , volatility = volatility)
end

struct Commodity <: Widget
    prices::Array{AbstractFloat}
    name::String
    volatility::AbstractFloat

    # constructor for kwargs
    function Commodity(; prices, name = "", volatility = volatility(prices))
        @assert size(prices)[1] > 0 "Prices cannot be an empty vector"
        new(prices, name, volatility)
    end

    # constructor for ordered argumentes 
    function Commodity(prices, name = "", volatility = volatility(prices))  
        new(prices, name, volatility)
    end
end

# outer constructor to make a stock with a (static) single price
function Commodity(price::AbstractFloat; name = "", volatility)
    prices = [price]
    Commodity(;prices = prices, name = name , volatility = volatility)
end


struct Bond <: Widget
    price::Array{AbstractFloat}
    name::String
    time_mat::AbstractFloat
    coupon_rate::AbstractFloat
end