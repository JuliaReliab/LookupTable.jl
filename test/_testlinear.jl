module TestLinear

using LookupTable: _getinterp
using Test

@testset "test01" begin
    x = 0:0.1:1
    y = sin.(x)
    v = _getinterp(Val(:LinearPointSlope), 0.3, x, y, :BinarySearch)
    @test v == y[4]
end

# @testset "test02" begin
#     x = 0:0.1:1
#     y = sin.(x)
#     plots(u->interplinear(u, x, y))
# end

end
