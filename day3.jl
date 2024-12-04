function input_parse(expression, s)

    total = 0
    active = true

    while length(s) > 8 

        x = match(expression, s).match
        y = collect(findfirst(x, s))
        start = length(x)+y[1]
        s = s[start:end]
        if x[1:3] == "mul" && active
            a = parse(Int64,split(x[5:end-1], ",")[1])
            b = parse(Int64, split(x[5:end-1], ",")[2])
            total = total + a * b
        else
            if x[1:4] == "do()"
                active = true
            elseif x[1:7] == "don't()"
                active = false
            end
        end
    
    end
    return total
end

# Start of main program

global data = ""

open("data/day3.txt") do f
   
    while ! eof(f)  
        global data = data * readline(f)          
    end
end

expression1 = r"mul\(\d+,\d+\)"
expression2 = r"do\(\)|don't\(\)|mul\((\d+)\s*,\s*(\d+)\)"

println(input_parse(expression1, data))
println(input_parse(expression2, data))
