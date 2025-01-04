function parse_input(map_lines)
    map = [collect(line) for line in map_lines]
    directions = Dict('^' => (-1, 0), '>' => (0, 1), 'v' => (1, 0), '<' => (0, -1))
    turn_right = Dict('^' => '>', '>' => 'v', 'v' => '<', '<' => '^')
    start_pos = (0, 0)
    start_dir = '^'

 
    for r in 1:length(map)
        for c in 1:length(map[r])
            if map[r][c] in keys(directions)
                start_pos = (r, c)
                start_dir = map[r][c]
                map[r][c] = '.'  
                break
            end
        end
    end

    return map, directions, turn_right, start_pos, start_dir
end

function is_within_bounds(map, pos)
    r, c = pos
    return 1 ≤ r ≤ length(map) && 1 ≤ c ≤ length(map[1])
end

function predict_guard_path(map_lines)
    map, directions, turn_right, pos, direction = parse_input(map_lines)
    visited = Set{Tuple{Int, Int}}()  
    push!(visited, pos)  #

    while is_within_bounds(map, pos)
        
        dr, dc = directions[direction]
        front_pos = (pos[1] + dr, pos[2] + dc)

        if is_within_bounds(map, front_pos) && map[front_pos[1]][front_pos[2]] == '#'
            direction = turn_right[direction]
        else
            pos = front_pos
            if is_within_bounds(map, pos)
                push!(visited, pos)  
            end
        end
    end

    return length(visited)  
end



map_lines = readlines("data/day6.txt")


result = predict_guard_path(map_lines)
println(result)
