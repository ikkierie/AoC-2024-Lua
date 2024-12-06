local enumerate = require "enumerate"
local set       = require "set"
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
    {  0, -1 },
    {  1,  0 },
    {  0,  1 },
    { -1,  0 },
}

local idir = 1
local cnt  = 0
local pos  = start
local seen = { [start] = true }
while
    (1 <= pos.x and pos.x <= max_x) and
    (1 <= pos.y and pos.y <= max_y)
do
    local next_pos = pos + dirs[idir]
    if grid[next_pos] then
        idir     = idir % #dirs + 1
        next_pos = pos + dirs[idir]
    end
    pos       = next_pos
    seen[pos] = true
end
print(#set.from.keys(seen) - 1)
