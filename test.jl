function validate(data)
    # To be valid data must contain exactly one "," and one ")" that must appear last
    # if it does the ")" is removed and string is split on ","
    # The two substrings must contain digits only, if they do return true otherwise false
    
    if count(")", data) == 1 && data[end:end] == ")" && count(",", data) == 1
        a = split(data[1:end-1], ",")[1]
        b = split(data[1:end-1], ",")[2]
        if all(isdigit, a) && all(isdigit, b)
            return true
        end
    else
        return false
    end
    return false
end

# Start of main program

s = ""

open("data/day3_test.txt") do f
   
    while ! eof(f)  
        global s = s * readline(f)          
    end
end

i = -666 # Why? I have no idea, but if I start at 0 I miss the last part.
sum = 0

while i < length(s)
    global pos = collect(findfirst("mul(", s))
    global next = pos[end]+1
    global s = s[next:end]
    global pos = collect(findfirst(")", s))
    global data = s[1:pos[1]]
    
    if validate(data)
        a = parse(Int64,split(data[1:end-1], ",")[1])
        b = parse(Int64, split(data[1:end-1], ",")[2])
        product = a*b
        global sum = sum + product 
    end
    global i = i + 1    
    
end

println(s)
println("i = ", i, " pos = ", pos, " next =", next)
println("lenght(s) = ", length(s))
println()
println(sum)