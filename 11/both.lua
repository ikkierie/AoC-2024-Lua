local function insert(buf, n, x)
    buf[x] = (buf[x] or 0) + n
end

local function exec(buf, turns)
    for _ = 1, turns do
        local new = {}
        for x, n in pairs(buf) do
            local d = math.ceil(math.log(x + 1, 10))
            if x == 0 then
                insert(new, n, 1)
            elseif d % 2 == 0 then
                insert(new, n, x // math.tointeger(10 ^ (d / 2)))
                insert(new, n, x %  math.tointeger(10 ^ (d / 2)))
            else
                insert(new, n, x * 2024)
            end
        end
        buf = new
    end
    return buf
end

local function sum(buf)
    local sum = 0
    for _, n in pairs(buf) do
        sum = sum + n
    end
    return sum
end

local input = {}
for x in io.lines([[input.txt]], "*n") do
    insert(input, 1, x)
end

print("Part A:", sum(exec(input, 25)))
print("Part B:", sum(exec(input, 75)))