using CSV, DataFrames

function is_safe_asc(a)
    first = a[1]
    second = a[2]
    inc = second-first <= 3 && second-first > 0
    for x in 2:length(a)
        inc = inc && a[x]-a[x-1] <= 3 && a[x]-a[x-1] > 0
    end        
    return inc 
end

function is_safe_desc(a)
    first = a[1]
    second = a[2]
    desc = second-first >= -3 && second-first < 0
    for x in 2:length(a)
        desc = desc && a[x]-a[x-1] >= -3 && a[x]-a[x-1] < 0
    end      
    return desc   
end

function dampable(a)
    check = false
    for x in length(a)+1:-1:1
        b = append!(a[1:length(a)-x],a[length(a)-x+2:length(a)])
        check = check || (is_safe_asc(b) || is_safe_desc(b))      
    end
    return check
end

function is_safe(a)
    return is_safe_asc(a) || is_safe_desc(a)
end

df = DataFrame(CSV.File("data/day2.txt", header = false, silencewarnings=true))

global no_safe_reports = damp_safe = 0 

for i in 1:nrow(df)
    global no_safe_reports=no_safe_reports+is_safe(collect(skipmissing((df[i,:]))))
    global damp_safe=damp_safe+dampable(collect(skipmissing((df[i,:]))))
end

print(no_safe_reports, " ", damp_safe)


