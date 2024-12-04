require "utils"

point = require "point"

local start = os.clock()

local grid = {}
for y, line in enumerate(io.lines([[input.txt]])) do
    for x, char in enumerate(line:gmatch(".")) do
        grid[point { x, y }] = char
    end
end

local search_dirs = {
    { point {-1, 1 }, point { 0, 0 }, point { 1,-1 }, },
    { point {-1,-1 }, point { 0, 0 }, point { 1, 1 }, },
}

local seen  = {}
local count = 0
for pos, char in pairs(grid) do
    if char ~= "A" then
        goto next_pos
    end
    local mas = {}
    local pis = {}
    for i, dir in pairs(search_dirs) do
        mas[i] = {}
        pis[i] = {}
        for _, offset in ipairs(dir) do
            local pos = pos + offset
            local c   = grid[pos]
            if not c or not c:match("[MAS]") then
                goto next_pos
            end
            table.insert(mas[i], c)
            table.insert(pis[i], pos)
        end
    end
    local mas1 = table.concat(mas[1])
    local mas2 = table.concat(mas[2])
    if
        (mas1 == "MAS" or mas1 == "SAM") and
        (mas2 == "MAS" or mas2 == "SAM")
    then
        print(pos)
        count = count + 1
    else
        print("", pos)
    end
    ::next_pos::
end
print(count)

local stop = os.clock()
print("Done (" .. (stop - start) .. "s)")

-- DON'T FORGET TO MOVE TO b.lua FOR PART B