# Solution fpr day 5
using DataFrames

function string_to_array(str)
    # Split the string by commas
    values = split(str, ",") 

    # Convert each value to a number (if possible)
    numbers = try
        map(x -> parse(Int64, x), values) 
    catch
        values # If parsing fails, return the original string values
    end

    return numbers
end

df_rules = DataFrame(A=Int[], B=Int[])
df_order = DataFrame(Order=Array[])


open("data/day5_test.txt") do f
   
    while ! eof(f)  
        data =readline(f)
        if length(data) != 0 && match(r"\|", data) !== nothing
            row = (parse(Int64, split(data, "|")[1]), parse(Int64, split(data, "|")[2])) 
            push!(df_rules, row)
        else
            if length(data) != 0
                push!(df_order, (string_to_array(data),))    
            end
        end
    end
        
end

print(df_rules)
print(df_order)