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

# Starting part 2. we still have the data in df

println()

global xmas = false
global count = 0 
#Skip edges and look for A
for y in 2:size(df)[1]-1
    for x in 2:length(df.Column1[1])-1
        if cmp(string(df[y, :Column1][x]), "A") == 0 
            global xmas = (string(df[y-1, :Column1][x-1]) * string(df[y-1, :Column1][x+1]) == "MM" && string(df[y+1, :Column1][x-1]) * string(df[y+1, :Column1][x+1]) == "SS") ||
                          (string(df[y-1, :Column1][x-1]) * string(df[y-1, :Column1][x+1]) == "MS" && string(df[y+1, :Column1][x-1]) * string(df[y+1, :Column1][x+1]) == "MS") ||
                          (string(df[y-1, :Column1][x-1]) * string(df[y-1, :Column1][x+1]) == "SS" && string(df[y+1, :Column1][x-1]) * string(df[y+1, :Column1][x+1]) == "MM") ||
                          (string(df[y-1, :Column1][x-1]) * string(df[y-1, :Column1][x+1]) == "SM" && string(df[y+1, :Column1][x-1]) * string(df[y+1, :Column1][x+1]) == "SM") 
                           
            if xmas
                global count += 1                
            end
        end
        global xmas = false                   
    end
    global xmas = false
end

println(count)