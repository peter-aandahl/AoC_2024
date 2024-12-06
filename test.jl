using DataFrames

df = DataFrame(Column1 = String[])
push!(df, ["Hello"])
push!(df, ["World"])
push!(df, ["Line 3"])



println(df[3,1])



