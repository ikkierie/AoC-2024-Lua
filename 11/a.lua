local stones = {}
for n in io.lines([[input.txt]], "*n") do
    table.insert(stones, n)
end
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
print(#stones)