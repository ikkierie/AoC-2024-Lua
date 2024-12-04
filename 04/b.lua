local enumerate = require "enumerate"
local set       = require "set"
local point     = require "point"

local grid = {}
for y, line in enumerate(io.lines([[input.txt]])) do
    for x, char in enumerate(line:gmatch(".")) do
        grid[point { x, y }] = char
    end
end

local search_dirs = {
    { point { -1, 1 }, point { 0, 0 }, point { 1, -1 }, },
    { point { -1,-1 }, point { 0, 0 }, point { 1,  1 }, },
}

local count = 0
for pos, char in pairs(grid) do
    if char ~= "A" then
        goto next_pos
    end
    local mas = {}
    for i, dir in pairs(search_dirs) do
        mas[i] = {}
        for _, offset in ipairs(dir) do
            local pos = pos + offset
            local c   = grid[pos]
            if not c or not c:match("[MAS]") then
                goto next_pos
            end
            table.insert(mas[i], c)
        end
    end
    local mas1 = table.concat(mas[1])
    local mas2 = table.concat(mas[2])
    if
        (mas1 == "MAS" or mas1 == "SAM") and
        (mas2 == "MAS" or mas2 == "SAM")
    then
        count = count + 1
    end
    ::next_pos::
end
print(count)