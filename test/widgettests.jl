import InteractiveUtils

@testset verbose = true "ordered argumentes creation tests" begin
@testset "Stock Creation" begin
    # Test the stock widget creation
    # Test ordered argumentes when only price given
    a_widget = Stock([1, 2, 3, 4, 5, 4, 3, 2, 1])
    @test isapprox(a_widget.volatility, .471, atol=.001)
    @test a_widget.name == ""
    @test a_widget.prices == [1, 2, 3, 4, 5, 4, 3, 2, 1]

    # Test ordered argumentes when name not given
    a_widget = Stock(prices=[1, 2, 3, 4, 5, 4, 3, 2, 1], volatility=.05)
    @test a_widget.volatility == .05
    @test a_widget.name == ""
    @test a_widget.prices == [1, 2, 3, 4, 5, 4, 3, 2, 1]

    # Test ordered argumentes when all given
    a_widget = Stock(prices=[1, 2, 3, 4, 5, 4, 3, 2, 1], volatility=.05, name="Example")
    @test a_widget.volatility == .05
    @test a_widget.name == "Example"
    @test a_widget.prices == [1, 2, 3, 4, 5, 4, 3, 2, 1]

end

@testset "Commodities Creation" begin
    # Test the Commodity widget creation

    # Test ordered argumentes when only price given
    a_widget = Commodity([1, 2, 3, 4, 5, 4, 3, 2, 1])
    @test isapprox(a_widget.volatility, .471, atol=.001)
    @test a_widget.name == ""
    @test a_widget.prices == [1, 2, 3, 4, 5, 4, 3, 2, 1]

    # Test ordered argumentes when name not given
    a_widget = Commodity(prices=[1, 2, 3, 4, 5, 4, 3, 2, 1], volatility=.05)
    @test a_widget.volatility == .05
    @test a_widget.name == ""
    @test a_widget.prices == [1, 2, 3, 4, 5, 4, 3, 2, 1]

    # Test ordered argumentes when all given
    a_widget = Commodity(prices=[1, 2, 3, 4, 5, 4, 3, 2, 1], volatility=.05, name="Example")
    @test a_widget.volatility == .05
    @test a_widget.name == "Example"
    @test a_widget.prices == [1, 2, 3, 4, 5, 4, 3, 2, 1]

end
end 

@testset "Kwargs creation tests" begin 
    widget_subs = InteractiveUtils.subtypes(Widget)

    for widget in widget_subs
        # Test kwarg creation when only prices is given
        kwargs = Dict(:prices => [1, 2, 3, 4, 5, 4, 3, 2, 1])
        a_widget = widget(;kwargs...)
        fields = [p for p in fieldnames(typeof(a_widget))]  # get the first item from list of widgets as all others will be indeticale
        iter = Dict(fields .=> getfield.(Ref(a_widget), fields))
        @test length(findall(Base.isempty, iter)) == 1  # Test all fields in each widget have been filled in. Name defaults to "" and counts as isempty

        # Test kwarg creation when price and name given
        kwargs = Dict(:prices => [1, 2, 3, 4, 5, 4, 3, 2, 1], :name => "Example")
        a_widget = widget(;kwargs...)
        fields = [p for p in fieldnames(typeof(a_widget))]  # get the first item from list of widgets as all others will be indeticale
        iter = Dict(fields .=> getfield.(Ref(a_widget), fields))
        @test length(findall(Base.isempty, iter)) == 0  # Test all fields in each widget have been filled in

        # Test kwarg creation when obstructing feilds provided
        kwargs = Dict(:prices => [1, 2, 3, 4, 5, 4, 3, 2, 1], :name => "Example", :time_mat => 1, :volatility => .5, :foo => "bar")
        a_widget = widget(;kwargs...)
        fields = [p for p in fieldnames(typeof(a_widget))]  # get the first item from list of widgets as all others will be indeticale
        iter = Dict(fields .=> getfield.(Ref(a_widget), fields))
        @test length(findall(Base.isempty, iter)) == 0  # Test all fields in each widget have been filled in
    end
end 