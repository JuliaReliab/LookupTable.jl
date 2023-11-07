# LookupTable

[![Build Status](https://github.com/JuliaReliab/LookupTable.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/JuliaReliab/LookupTable.jl/actions/workflows/CI.yml?query=branch%3Amain)

A function for lookup table.

## Install

```julia
using Pkg
Pkg.install("https://github.com/JuliaReliab/LookupTable.jl")
```

## Usage

- `lookup(x; breaks=-5:5, y=tanh.(-5:5), interpmethod=:LinearPointSlope, extrapmethod=:LinearEx, indexsearchmethod=:BinarySearch)`
    - A function for lookup table. `breaks` and `y` take arrays for x-axis and y-axis, respectively.
    - `interpmethod`: The option for the method of interploration; :LinearPointSlope and :Flat. The default is :LinearPointSlope.
    - `extrapmethod`: The option for the method of extraploration; :LinearEx and :ClixEx. The default is :LinearEx.
    - `indexsearchmethod`: The option for the method of index search; :BinarySearch and :EvenlySpacedPoints. The default is :BinarySearch.


## Example

```julia
using CSV
using DataFrames

df = CSV.read("example.csv", DataFrame) # CSV file has the columns 'breaks' and 'y'
lookup(1.5, breaks=df.breaks, y=df.y)
```
