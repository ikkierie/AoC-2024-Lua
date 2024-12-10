local enumerate = require "enumerate"
local point     = require "point"

local grid, zeros = {}, {}
for y, line in enumerate(io.lines([[input.txt]])) do
    for x, char in line:gmatch("()(.)") do
        grid[point { x, y }] = tonumber(char)
        if char == "0" then
            table.insert(zeros, point { x, y })
        end
    end
end

local dirs = { { 0, 1 }, { 0, -1 }, { 1, 0 }, { -1, 0 } }

local function explore(start)
    local count = 0
    local seen  = { [start] = true }
    local queue = { start }
    while queue[1] do
        local cur = table.remove(queue, 1)
        if grid[cur] == 9 then
            count = count + 1
        end
        for _, dir in pairs(dirs) do
            local next = cur + dir
            if grid[next] == grid[cur] + 1 then
                table.insert(queue, next)
                seen[next] = (seen[next] or 0) + 1
            end
        end
    end
    return count
end

local sum = 0
for _, pos in ipairs(zeros) do
    sum = sum + explore(pos)
end
print(sum)