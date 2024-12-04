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
    up       = { point { 0, 0 }, point { 0, 1 }, point { 0, 2 }, point { 0, 3 } },
    right    = { point { 0, 0 }, point { 1, 0 }, point { 2, 0 }, point { 3, 0 } },
    daig1    = { point { 0, 0 }, point { 1, 1 }, point { 2, 2 }, point { 3, 3 } },
    diag2    = { point { 0, 0 }, point {-1, 1 }, point {-2, 2 }, point {-3, 3 } },
    daig3    = { point { 0,-0 }, point { 1,-1 }, point { 2,-2 }, point { 3,-3 } },
    daig3    = { point {-0,-0 }, point {-1,-1 }, point {-2,-2 }, point {-3,-3 } },

}

local seen  = {}
local count = 0
for pos, char in pairs(grid) do
    for _, dir in pairs(search_dirs) do
        local chars = {}
        local poss  = {}
        for _, offset in ipairs(dir) do
            local posc = pos + offset
            local c    = grid[posc]
            if not c then
                goto next_dir
            end
            table.insert(poss,  posc)
            table.insert(chars, c)
        end
        poss = set(poss)
        if not seen[poss] then
            seen[poss] = true
            if
                table.concat(chars):lower()           == "xmas" or
                table.concat(chars):lower():reverse() == "xmas"
            then
                count = count + 1
            end
        end
        ::next_dir::
    end
end
print(count)

local stop = os.clock()
print("Done (" .. (stop - start) .. "s)")

-- DON'T FORGET TO MOVE TO b.lua FOR PART B