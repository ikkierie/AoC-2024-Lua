local ops = {
    add    = (function(x, y) return y +  x end),
    mul    = (function(x, y) return y *  x end),
    concat = (function(x, y) return y .. x end),
}

local function explore(input, idx, total)
    if not (total and idx) then
        idx = #input
        return explore(input, idx - 1, input[idx])
    elseif not input[idx] then
        return tonumber(total) == input.ans
    else
        local cur = input[idx]
        for _, op in ipairs(input.ops) do
            if explore(input, idx - 1, ops[op](cur, total)) then
                return true
            end
        end
    end
    return false
end

local a, b = 0, 0
for line in io.lines([[input.txt]]) do
    local ans, operands = line:match("^(%d+):(.+)$")
    ans                 = tonumber(ans)

    local input = { ans = ans, ops = { "add", "mul" } }
    for operand in operands:gmatch("%d+") do
        table.insert(input, 1, tonumber(operand))
    end

    if explore(input) then
        a = a + ans
    end
    
    table.insert(input.ops, "concat")
    if explore(input)  then
        b = b + ans
    end
end

print("Part A:", a)
print("Part B:", b)