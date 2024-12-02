local function is_valid(ns)
    local prev_sign
    for i = 2, #ns do
        local x, y = ns[i - 1], ns[i]
        local diff = math.abs(x - y)
        local sign =
            (x > y) and  1 or
            (x < y) and -1 or 0
        if
            (diff < 1 or diff > 3) or
            (prev_sign and prev_sign ~= sign)
        then
            return false
        end
        prev_sign = sign
    end
    return true
end

local count = 0
for line in io.lines([[input.txt]]) do
    local ns = {}
    for n in line:gmatch("%d+") do
        table.insert(ns, tonumber(n))
    end
    for i = 1, (#ns + 1) do
        local ns = table.move(ns, 1, #ns, 1, {})
        table.remove(ns, i)
        if is_valid(ns) then
            count = count + 1
            break
        end
    end
end
print(count)