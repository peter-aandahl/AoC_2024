function parse_input_from_csv(file_path)
    rules = []
    updates = []

    open(file_path, "r") do file
        reading_updates = false
        for line in eachline(file)
            line = strip(line)
            if isempty(line)
                reading_updates = true
                continue
            end

            if !reading_updates
                x, y = split(line, "|")
                push!(rules, (parse(Int, x), parse(Int, y)))
            else
                update = split(line, ",")
                push!(updates, [parse(Int, page) for page in update])
            end
        end
    end

    return rules, updates
end

function validate_update(rules, update)
    relevant_rules = filter(x -> x[1] in update && x[2] in update, rules)

    position = Dict(page => idx for (idx, page) in enumerate(update))

    for (x, y) in relevant_rules
        if position[x] >= position[y]
            return false
        end
    end

    return true
end

function find_middle(update)
    return update[Int(cld(length(update), 2))]
end

function sort_update(rules, update)
    relevant_rules = filter(x -> x[1] in update && x[2] in update, rules)

    dependencies = Dict(page => Set{Int}() for page in update)
    for (x, y) in relevant_rules
        push!(dependencies[y], x)
    end

    sorted_update = []
    while !isempty(dependencies)
        independent = [page for (page, deps) in dependencies if isempty(deps)]
        append!(sorted_update, independent)
        for page in independent
            delete!(dependencies, page)
            for deps in values(dependencies)
                delete!(deps, page)
            end
        end
    end

    return sorted_update
end


rules, updates = parse_input_from_csv("data/day5.txt")

correct_total = 0
incorrect_total = 0

for update in updates
    if validate_update(rules, update)
        global correct_total += find_middle(update)
    else
        global sorted_update = sort_update(rules, update)
        global incorrect_total += find_middle(sorted_update)
    end
end

println(correct_total)
println(incorrect_total)
