local enumerate = require "enumerate"
local point     = require "point"

local max_x, max_y = 0, 0
local grid = {}
for y, line in enumerate(io.lines([[input.txt]])) do
    for x, char in line:gmatch("()(.)") do
        if char == "^" then
            start = point { x, y }
        elseif char == "#" then
            grid[point { x, y }] = char
        end
        max_x = math.max(x, max_x)
    end
    max_y = math.max(y, max_y)
end

local dirs = {
    point {  0, -1 },
    point {  1,  0 },
    point {  0,  1 },
    point { -1,  0 },
}

local count = 0
for y = 1, max_y do
    for x = 1, max_x do
        local new = point { x, y }
        if grid[new] then
            goto next_new_point
        end
        grid[new]  = true
        local pos  = start
        local idir = 1
        local seen = { [start] = { [dirs[idir]] = true } }
        while
            (1 <= pos.x and pos.x <= max_x) and
            (1 <= pos.y and pos.y <= max_y)
        do
            local next_pos = pos + dirs[idir]
            while grid[next_pos] do
                idir     = idir % #dirs + 1
                next_pos = pos + dirs[idir]
            end
            pos       = next_pos
            seen[pos] = seen[pos] or {}
            if seen[pos][dirs[idir]] then
                count = count + 1
                break
            end
            seen[pos][dirs[idir]] = true
        end
        grid[new] = nil
        ::next_new_point::
    end
end
print(count)