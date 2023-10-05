"""
Interpolation methods
"""
abstract type AbstractInterpMethod end
struct LinearPointSlope <: AbstractInterpMethod end
struct Flat <: AbstractInterpMethod end
struct Nearest <: AbstractInterpMethod end
struct LinearLagrange <: AbstractInterpMethod end
struct CubeSpline <: AbstractInterpMethod end
struct AkimaSpline <: AbstractInterpMethod end

"""
Extrapolation methods
"""
abstract type AbstractExtrapMethod end
struct LinearEx <: AbstractExtrapMethod end
struct ClipEx <: AbstractExtrapMethod end
struct CubicExSpline <: AbstractExtrapMethod end
struct AkimaExSpline <: AbstractExtrapMethod end

"""
Index Search methods
"""
abstract type AbstractIndexSearchMethod end
struct BinarySearch <: AbstractIndexSearchMethod end
struct EvenlySpacedPoints <: AbstractIndexSearchMethod end
struct LinearSearch <: AbstractIndexSearchMethod end

"""
Table
"""
struct Table
    x
    y
    interp::AbstractInterpMethod
    extrap::AbstractExtrapMethod
    indexsearch::AbstractIndexSearchMethod
end

"""
searchrange
"""
function binsearch(x::Tv, breaks::AbstractArray{Tv}) where Tv
    @assert breaks[1] <= x && x < breaks[end]
    lower = 1
    upper = length(breaks)
    while upper - lower > 1
        mid = div(upper + lower, 2)
        if breaks[mid] > x
            upper = mid
        elseif breaks[mid] <= x
            lower = mid
        end
    end
    lower
end

function evenlyspaced(x::Tv, breaks::AbstractRange{Tv}) where Tv
    s = step(breaks)
    Int(fld(x - breaks[1], s))+1
end
