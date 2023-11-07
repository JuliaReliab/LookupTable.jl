module TestExLinear

using LookupTable: _getextrap1, _getextrap2
using Test

@testset "test01" begin
    x = _getextrap1(Val(:LinearPointSlope), Val(:LinearEx), -1, 0:0.1:1, 0:10.0:100, :BinarySearch)
    @test isapprox(x, -100)
    x = _getextrap2(Val(:LinearPointSlope), Val(:LinearEx), 2, 0:0.1:1, 0:10.0:100, :BinarySearch)
    @test isapprox(x, 200)
end

end
