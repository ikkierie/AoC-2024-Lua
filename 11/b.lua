local cache = {}
local function chunk(n)
    if not cache[n] then
        local stones = { n }
        for _ = 1, 25 do
            local new = {}
            for i = 1, #stones do
                local x = stones[i]
                local d = math.ceil(math.log(x + 1, 10))
                if x == 0 then
                    table.insert(new, 1)
                elseif d % 2 == 0 then
                    table.insert(new, x // math.tointeger(10^(d / 2)))
                    table.insert(new, x %  math.tointeger(10^(d / 2)))
                else
                    table.insert(new, x * 2024)
                end
            end
            stones = new
        end
        cache[n] = stones
    end
    return cache[n]
end

local sum = 0
for n in io.lines([[input.txt]], "*n") do
    for _, x in ipairs(chunk(n)) do
        for _, y in ipairs(chunk(x)) do
            sum = sum + #chunk(y)
        end
    end
end
print(sum)