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

function check_rules(df, x, data)
    for r in 1:nrow(df)
        if df[r, :1] == x
            println("Checking ", x, " for Rule : ", df[r, :1], " ", df[r, :2])
            if df[r, :2] in data
                println("A relevant rule")
                for e in data
                    index = findfirst(isequal(df[r, :2]), data) 
                    println(index)
                end

            else
                println("This rule can be disregarded")
            end
        end
    end
    return true
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

#println(df_rules)
#println()
#println(df_order)
#println()

#Traverse the arrays
for i in 1:length(df_order.Order[1])
    x = df_order.Order[1][i]
    if check_rules(df_rules, x, df_order.Order[1])
        println(x, " is ok")
    else
        println(x, " is NOT ok")
    end
end