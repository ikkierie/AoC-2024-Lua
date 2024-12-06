local grid = {}
local y    = 0
for line in io.lines([[input.txt]]) do
    y = y + 1
    for x, char in line:gmatch("()(.)") do
        local pos = x .. "," .. y
        grid[pos] = false
        if char == "^" then
            start = pos
        elseif char == "#" then
            grid[pos] = char
        end
    end
end

local dirs = { "0,-1", "1,0", "0,1", "-1,0" }
local function add_pos(p1, p2)
    local x1, y1 = p1:match("^(-?%d+),(-?%d+)$")
    local x2, y2 = p2:match("^(-?%d+),(-?%d+)$")
    return (x1 + x2) .. "," .. (y1 + y2)
end

-- Part A
local a    = 0
local idir = 1
local pos  = start
local seen = { [start] = true }
while grid[pos] ~= nil do
    local next_pos = add_pos(pos, dirs[idir])
    while grid[next_pos] do
        idir     = idir % #dirs + 1
        next_pos = add_pos(pos, dirs[idir])
    end
    pos = next_pos
    if not seen[pos] then
        a = a + 1
    end
    seen[pos] = true
end
print("Part A:", a)

-- Part B
local b = 0
for new in pairs(seen) do
    if (grid[new] ~= false) or (new == start) then
        goto next_new_point
    end
    grid[new]  = true
    local pos  = start
    local idir = 1
    local seen = { [start .. ":" .. dirs[idir]] = true }
    while grid[pos] ~= nil do
        local next_pos = add_pos(pos, dirs[idir])
        while grid[next_pos] do
            idir     = idir % #dirs + 1
            next_pos = add_pos(pos, dirs[idir])
        end
        pos           = next_pos
        local pos_dir = pos .. ":" .. dirs[idir]
        if seen[pos_dir] then
            b = b + 1
            break
        end
        seen[pos_dir] = true
    end
    grid[new] = false
    ::next_new_point::
end
print("Part B:", b)