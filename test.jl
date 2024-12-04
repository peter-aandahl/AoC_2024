# Start of main program

global s = ""

open("data/day3.txt") do f
   
    while ! eof(f)  
        global s = s * readline(f)          
    end
end

total = 0

while length(s) > 8 

    x =match(r"mul\(\d+,\d+\)", s).match
    y = collect(findfirst(x, s))
    start = length(x)+y[1]
    global s = s[start:end]
    
    a = parse(Int64,split(x[5:end-1], ",")[1])
    b = parse(Int64, split(x[5:end-1], ",")[2])
    global total = total + a * b

end

println(total)

