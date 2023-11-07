module TestExClip

using LookupTable: _getextrap1, _getextrap2
using Test

@testset "test01" begin
    x = _getextrap1(Val(:Flat), Val(:ClipEx), -1, 0:0.1:1, 0:10.0:100, :BinarySearch)
    @test x == 0
    x = _getextrap2(Val(:Flat), Val(:ClipEx), 2, 0:0.1:1, 0:10.0:100, :BinarySearch)
    @test x == 100
end

end
