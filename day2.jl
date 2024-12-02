using CSV, DataFrames

function is_safe_order(a, asc)
    asc ? order = a[2]-a[1] <= 3 && a[2]-a[1] > 0 : order = a[2]-a[1] >= -3 && a[2]-a[1] < 0
    for x in 2:length(a)
        asc ? order = order && a[x]-a[x-1] <= 3 && a[x]-a[x-1] > 0 : order = order && a[x]-a[x-1] >= -3 && a[x]-a[x-1] < 0
    end        
    return order
end

function is_safe(a)
    return is_safe_order(a, true) || is_safe_order(a, false)
end

function dampable(a)
    check = false
    for x in length(a)+1:-1:1
        check = check || is_safe(append!(a[1:length(a)-x],a[length(a)-x+2:length(a)]))   
    end
    return check
end

df = DataFrame(CSV.File("data/day2.txt", header = false, silencewarnings=true))

global no_safe_reports = damp_safe = 0 

for i in 1:nrow(df)
    global no_safe_reports=no_safe_reports+is_safe(collect(skipmissing((df[i,:]))))
    global damp_safe=damp_safe+dampable(collect(skipmissing((df[i,:]))))
end

print(no_safe_reports, " ", damp_safe)