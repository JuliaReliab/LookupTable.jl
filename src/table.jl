
export lookup

# """
# Interpolation methods
# """
# abstract type AbstractInterpMethod end
# struct LinearPointSlope <: AbstractInterpMethod end
# struct Flat <: AbstractInterpMethod end
# struct Nearest <: AbstractInterpMethod end
# struct LinearLagrange <: AbstractInterpMethod end
# struct CubeSpline <: AbstractInterpMethod end
# struct AkimaSpline <: AbstractInterpMethod end

# """
# Extrapolation methods
# """
# abstract type AbstractExtrapMethod end
# struct LinearEx <: AbstractExtrapMethod end
# struct ClipEx <: AbstractExtrapMethod end
# struct CubicExSpline <: AbstractExtrapMethod end
# struct AkimaExSpline <: AbstractExtrapMethod end

# """
# Index Search methods
# """
# abstract type AbstractIndexSearchMethod end
# struct BinarySearch <: AbstractIndexSearchMethod end
# struct EvenlySpacedPoints <: AbstractIndexSearchMethod end
# struct LinearSearch <: AbstractIndexSearchMethod end

"""
lookup
"""
function lookup(x; breaks=-5:5, y=tanh.(-5:5), interpmethod=:LinearPointSlope, extrapmethod=:LinearEx, indexsearchmethod=:BinarySearch)
    if x < breaks[1]
        getextrap1(x, breaks, y, interpmethod, extrapmethod, indexsearchmethod)
    elseif x >= breaks[end]
        getextrap2(x, breaks, y, interpmethod, extrapmethod, indexsearchmethod)
    else
        getinterp(x, breaks, y, interpmethod, indexsearchmethod)
    end
end

function getinterp(x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, method, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    _getinterp(Val(method), x, breaks, y, interp)
end

function getextrap1(x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interpmethod, extrapmethod, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    _getextrap1(Val(interpmethod), Val(extrapmethod), x, breaks, y, interp)
end

function getextrap2(x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interpmethod, extrapmethod, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    _getextrap2(Val(interpmethod), Val(extrapmethod), x, breaks, y, interp)
end

"""
Interpolation Flat
"""
function _getinterp(::Val{:Flat}, x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    i = indexsearch(Val(interp), x, breaks)
    y[i]
end

"""
Interpolation linear
"""
function _getinterp(::Val{:LinearPointSlope}, x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    i = indexsearch(Val(interp), x, breaks)
    f = (x - breaks[i]) / (breaks[i+1] - breaks[i])
    y[i] + f * (y[i+1] - y[i])
end

"""
Extrapolation Clip
"""
function _getextrap1(::Any, ::Val{:ClipEx}, x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    y[1]
end

function _getextrap2(::Any, ::Val{:ClipEx}, x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    y[end]
end

"""
Extrapolation linear
"""
function _getextrap1(::Val{:LinearPointSlope}, ::Val{:LinearEx}, x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    f = (x - breaks[1]) / (breaks[2] - breaks[1])
    y[1] + f * (y[2] - y[1])
end

function _getextrap2(::Val{:LinearPointSlope}, ::Val{:LinearEx}, x::Tx, breaks::AbstractArray{Tb}, y::AbstractArray{Ty}, interp) where {Tx <: Number, Tb <: Number, Ty <: Number}
    f = (x - breaks[end-1]) / (breaks[end] - breaks[end-1])
    y[end-1] + f * (y[end] - y[end-1])
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

