using CSV, DataFrames
df = DataFrame(CSV.File("data/day4_test.txt", header = false))

total = 0

for i in 1:size(df,1)
    for m in eachmatch(r"XMAS", df.Column1[i])
        global total += 1 
    end
    for m in eachmatch(r"XMAS", reverse(df.Column1[i]))
        global total += 1 
    end
end

println(total)