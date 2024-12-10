local enumerate = require "enumerate"
local func      = require "func"
local point     = require "point"
local stream    = require "stream"

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

local function explore(start, part2)
    local count   = 0
    local seen    = { [start] = true }
    local visited = {}
    local queue   = { start }
    while queue[1] do
        local cur    = table.remove(queue, 1)
        visited[cur] = seen[cur]
        if grid[cur] == 9 then
            count = count + 1
        end
        for _, dir in pairs(dirs) do
            local next = cur + dir
            if (part2 or not seen[next]) and grid[next] == grid[cur] + 1 then
                table.insert(queue, next)
                seen[next] = (seen[next] or 0) + 1
            end
        end
    end
    return count
end

print("Part A:", stream.from.seq(zeros):map(explore):sum())
print("Part B:", stream.from.seq(zeros):map(explore:bind2(true)):sum())