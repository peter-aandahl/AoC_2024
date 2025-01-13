# Function to compute all possible results of an expression given numbers and operators
function evaluate_expressions(nums, ops)
    result = nums[1]
    for (i, op) in enumerate(ops)
        result = op == "+" ? result + nums[i + 1] : result * nums[i + 1]
    end
    return result
end

# Function to generate all combinations of "+" and "*"
function generate_operator_combinations(n)
    # Generate all binary combinations of "+" and "*"
    ops = ["+", "*"]
    combinations = collect(Base.Iterators.product(ntuple(_ -> ops, n)...))
    return [collect(c) for c in combinations]
end

# Function to determine if a test value can be produced
function can_produce_target(target, nums)
    n = length(nums) - 1  # Number of positions for operators
    if n == 0
        return target == nums[1]  # No operators, only one number
    end

    # Generate all combinations of `+` and `*`
    for ops in generate_operator_combinations(n)
        if evaluate_expressions(nums, ops) == target
            return true
        end
    end
    return false
end

# Main function to solve the problem
function total_calibration_result(file_path)
    total_result = 0

    # Read lines from the input file
    input_lines = readlines(file_path)

    for line in input_lines
        target, nums_str = split(line, ": ")
        nums = parse.(Int, split(nums_str, " "))
        target = parse(Int, target)
        if can_produce_target(target, nums)
            total_result += target
        end
    end
    return total_result
end

result = total_calibration_result("data/day7_test.txt")
println(result)
