local enumerate = require "enumerate"
local set       = require "set"
local point     = require "point"

local grid = {}
for y, line in enumerate(io.lines([[input.txt]])) do
    for x, char in enumerate(line:gmatch(".")) do
        grid[point { x, y }] = char
    end
end

local dirs = {
    down       = { { 0, 0 }, {  0, 1 }, {  0, 2 }, {  0, 3 } },
    right      = { { 0, 0 }, {  1, 0 }, {  2, 0 }, {  3, 0 } },
    down_right = { { 0, 0 }, {  1, 1 }, {  2, 2 }, {  3, 3 } },
    down_left  = { { 0, 0 }, { -1, 1 }, { -2, 2 }, { -3, 3 } },
}

local seen  = {}
local count = 0
for pos, char in pairs(grid) do
    for _, dir in pairs(dirs) do
        local chars = {}
        local poss  = {}
        for _, offset in ipairs(dir) do
            local new_pos  = pos + offset
            local new_char = grid[new_pos]
            if not new_char then
                goto next_dir
            end
            table.insert(poss,  new_pos)
            table.insert(chars, new_char)
        end
        poss = set(poss)
        local word = table.concat(chars):upper()
        if not seen[poss] and (word == "XMAS" or word == "SAMX") then
            seen[poss] = true
        end
        ::next_dir::
    end
end
print(#set.from.keys(seen))