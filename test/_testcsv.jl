module TestCSV

using CSV
using DataFrames
using LookupTable
using LookupTable: _getinterp
using Test

@testset "test01" begin
    df = CSV.read("test.csv", DataFrame)
    x = df.a
    y = df.b
    v = _getinterp(Val(:LinearPointSlope), 1.5, x, y, :BinarySearch)
    @test isapprox(v, 15)
end

@testset "test02" begin
    df = CSV.read("test.csv", DataFrame)
    v = lookup(1.5, breaks=df.a, y=df.b)
    @test isapprox(v, 15)
end

end
