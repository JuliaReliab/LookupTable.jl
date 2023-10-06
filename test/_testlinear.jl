module TestLinear

using LookupTable: interplinear
using Test

@testset "test01" begin
    x = 0:0.1:1
    y = sin.(x)
    v = interplinear(0.31, x, y)
    @test v == y[4]
end

# @testset "test02" begin
#     x = 0:0.1:1
#     y = sin.(x)
#     plots(u->interplinear(u, x, y))
# end

end
