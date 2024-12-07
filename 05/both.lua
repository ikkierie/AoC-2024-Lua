local graph = {}
local mode  = 1
local a, b  = 0, 0
for line in io.lines([[input.txt]]) do
    if line == "" then
        mode = mode + 1
    elseif mode == 1 then
        local x, y  = line:match("(%d+)|(%d+)")
        x, y        = tonumber(x), tonumber(y)
        graph[x]    = graph[x] or {}
        graph[x][y] = true
    elseif mode == 2 then
        local xs = {}
        for n in line:gmatch("%d+") do
            table.insert(xs, tonumber(n))
        end
        for i = 2, #xs do
            for j = 1, (i - 1) do
                if (graph[xs[i]] or "")[xs[j]] then
                    table.sort(xs, function(x, y) return (graph[x] or "")[y] end)
                    b = b + xs[math.ceil(#xs / 2)]
                    goto next_line
                end
            end
        end
        a = a + xs[math.ceil(#xs / 2)]
    end
    ::next_line::
end

print("Part A:", a)
print("Part B:", b)