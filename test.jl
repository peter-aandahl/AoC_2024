using DataFrames

df = DataFrame(Column1 = String[])
push!(df, ["Hello"])

println(df)



