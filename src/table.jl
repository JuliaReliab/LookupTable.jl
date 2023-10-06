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

# """
# Index Search methods
# """
# abstract type AbstractIndexSearchMethod end
# struct BinarySearch <: AbstractIndexSearchMethod end
# struct EvenlySpacedPoints <: AbstractIndexSearchMethod end
# struct LinearSearch <: AbstractIndexSearchMethod end

"""
Table
"""
struct Table
    x
    y
    interp::AbstractInterpMethod
    extrap::AbstractExtrapMethod
    indexsearch::Symbol
end

"""
searchrange
"""
function indexsearch(::Val{:BinarySearch}, x::Tx, breaks::AbstractArray{Tb})::Int where {Tx <: Number, Tb <: Number}
    @assert breaks[1] <= x && x < breaks[end]
    n = length(breaks)
    x == breaks[1] && return 1
    lower, upper = 1, n
    while upper - lower > 1
        mid = div(upper + lower, 2)
        if breaks[mid] > x
            upper = mid
        else
            lower = mid
        end
    end
    lower
end

function indexsearch(::Val{:EvenlySpacedPoints}, x::Tx, breaks::AbstractRange{Tb})::Int where {Tx <: Number, Tb <: Number}
    @assert breaks[1] <= x && x < breaks[end]
    n = length(breaks)
    x == breaks[1] && return 1
    s = step(breaks)
    y = x - breaks[1]
    ceil(Int, y/s)
end

"""
Interpolation Flat
"""
function interpflat(x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}; interp=:BinarySearch) where {Tx <: Number, Tb <: Number, Ty <: Number}
    i = indexsearch(Val(interp), x, breaks)
    y[i]
end

"""
Interpolation linear
"""
function interplinear(x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}; interp=:BinarySearch) where {Tx <: Number, Tb <: Number, Ty <: Number}
    i = indexsearch(Val(interp), x, breaks)
    f = (x - breaks[i]) / (breaks[i+1] - breaks[i])
    y[i] + f * (y[i+1] - y[i])
end
