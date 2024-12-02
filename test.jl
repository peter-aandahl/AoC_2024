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
        println(b, " ", check)      
    end
    return check
end

println(dampable([9,7,6,2,1]))

println(dampable([1,3,2,4,5]))
