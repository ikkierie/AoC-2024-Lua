local ops = {
    (function(x, y) return y +  x end),
    (function(x, y) return y *  x end),
    (function(x, y) return y .. x end),
}

local function explore(input, idx, total)
    if not (total and idx) then
        idx = #input
        return explore(input, idx - 1, input[idx])
    elseif not input[idx] then
        return tonumber(total) == input.ans
    else
        local cur = input[idx]
        for _, op in ipairs(ops) do
            if explore(input, idx - 1, op(cur, total)) then
                return true
            end
        end
    end
    return false
end

local sum = 0
for line in io.lines([[input.txt]]) do
    local ans, operands = line:match("^(%d+):(.+)$")
    ans                 = tonumber(ans)

    local input = { ans = ans }
    for operand in operands:gmatch("%d+") do
        table.insert(input, 1, tonumber(operand))
    end

    if explore(input) then
        sum = sum + ans
    end
end

print(sum)