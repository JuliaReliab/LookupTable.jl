module TestSearch

using LookupTable: indexsearch
using Test

const BinarySearch = Val{:BinarySearch}()
const EvenlySpacedPoints = Val{:EvenlySpacedPoints}()

@testset "binsearch01" begin
    i = indexsearch(BinarySearch, 0.31, 0:0.1:1)
    @test i == 4
end

@testset "binsearch02" begin
    i = indexsearch(BinarySearch, 0.3, 0:0.1:1)
    @test i == 4
end

@testset "binsearch03" begin
    i = indexsearch(BinarySearch, 0.3, Float64[0.1, 0.2, 0.3, 0.5, 1.5, 10.1, 32.9])
    @test i == 3
end

@testset "binsearch04" begin
    i = indexsearch(BinarySearch, 20.0, Float64[0.1, 0.2, 0.3, 0.5, 1.5, 10.1, 32.9])
    @test i == 6
end

@testset "binsearch05" begin
    i = indexsearch(BinarySearch, 32.8, Float64[0.1, 0.2, 0.3, 0.5, 1.5, 10.1, 32.9])
    @test i == 6
end

@testset "search01" begin
    i = indexsearch(EvenlySpacedPoints,0.31, 0:0.1:1)
    @test i == 4
end

@testset "search02" begin
    i = indexsearch(EvenlySpacedPoints, 0.3, 0:0.1:1)
    @test i == 3
end

end
