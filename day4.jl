using CSV, DataFrames
df = DataFrame(CSV.File("data/day4.txt", header = false))

total = 0

#The horizontals
for x in 1:size(df,1)
    for m in eachmatch(r"XMAS", df.Column1[x])
        global total += 1 
    end
    for m in eachmatch(r"XMAS", reverse(df.Column1[x]))
        global total += 1 
    end
end


# The verticals
for y in 1:length(df.Column1[1])
    local p = ""
    for x in 1:size(df,1)
        p = p * df.Column1[x][y]
    end
    
    for m in eachmatch(r"XMAS", p)
        global total += 1 
    end
    for m in eachmatch(r"XMAS", reverse(p))
        global total += 1 
    end
end


# The diagonals
# Tilt right
df2 = DataFrame(Column1 = String[])
local p = ""

for y in 1:length(df.Column1)
    p = "-"^(length(df.Column1)-y)
    p = p * df[y, 1]
    p = p * "-"^(y-1)
    push!(df2, [p])
end    

for y in 1:length(df2.Column1[1])
    local p = ""
    for x in 1:size(df2,1)
        p = p * df2.Column1[x][y]
    end
    for m in eachmatch(r"XMAS", p)
        global total += 1 
    end
    for m in eachmatch(r"XMAS", reverse(p))
        global total += 1 
    end
end

# Tilt left
df2 = DataFrame(Column1 = String[])
local p = ""

for y in 1:length(df.Column1)
    p = "-"^(y-1) 
    p = p * df[y, 1]
    p = p * "-"^(length(df.Column1)-y)
    push!(df2, [p])
end    

for y in 1:length(df2.Column1[1])
    local p = ""
    for x in 1:size(df2,1)
        p = p * df2.Column1[x][y]
    end
    for m in eachmatch(r"XMAS", p)
        global total += 1 
    end
    for m in eachmatch(r"XMAS", reverse(p))
        global total += 1 
    end
end


println(total)

