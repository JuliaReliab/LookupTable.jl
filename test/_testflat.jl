module TestFlat

using LookupTable: interpflat
using Test

@testset "test01" begin
    x = interpflat(0.31, 0:0.1:1, 0:10.0:100)
    @test x == 30.0
end

@testset "test02" begin
    x = interpflat(0.31, 0:0.1:1, 0:10.0:100, interp=:EvenlySpacedPoints)
    @test x == 30.0
end

@testset "test03" begin
    x = interpflat(0.3, 0:0.1:1, 0:10.0:100, interp=:BinarySearch)
    @test x == 30.0
end

@testset "test04" begin
    x = interpflat(0.999, 0:0.1:1, 0:10.0:100, interp=:BinarySearch)
    @test x == 90
end

@testset "test05" begin
    x = 0:0.1:1
    y = sin.(x)
    v = interpflat(0.999, x, y, interp=:BinarySearch)
    @test v == y[10]
end

end
