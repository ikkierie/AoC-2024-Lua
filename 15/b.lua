global <const> *

local point = require "point"

local <const> BOXL, BOXR              = "[", "]"
local <const> ROBOT, BOX, WALL, SPACE = "@", "O", "#", "."
local <const> UP, DOWN, LEFT, RIGHT   = "^", "v", "<", ">"

local grid_map = {
    [BOX]   = { l = BOXL,  r = BOXR  },
    [WALL]  = { l = WALL,  r = WALL  },
    [ROBOT] = { l = ROBOT, r = SPACE },
    [SPACE] = { l = SPACE, r = SPACE },
}

local robot, grid, commands
do
    local f <close> = assert(io.open([[input.txt]]))

    grid    = {}
    local y = 1
    for line in f:lines() do
        if line == "" then
            break
        end
        for x, c in line:gmatch("()(.)") do
            local p1 = point { 2 * x - 1, y }
            local p2 = point { 2 * x,     y }
            if c == ROBOT then
                robot = p1
            end
            grid[p1] = grid_map[c].l
            grid[p2] = grid_map[c].r
        end
        y = y + 1
    end

    commands = f:read("*all")
end

local dirs = {
    [UP]    = point {  0, -1 },
    [DOWN]  = point {  0,  1 },
    [LEFT]  = point { -1,  0 },
    [RIGHT] = point {  1,  0 },
}

local function move(grid, pos, dir, second_half)
    local here = grid[pos]

    if here == SPACE then
        return true
    elseif here == WALL then
        return false
    end

    local new      = pos + dir
    local can_move = move(grid, new, dir)

    if can_move and not second_half and (
        dir == dirs[UP] or
        dir == dirs[DOWN]
    ) then
        local dir2 =
            (here == BOXL) and dirs[RIGHT] or
            (here == BOXR) and dirs[LEFT]  or nil

        if dir2 then
            can_move = move(grid, pos + dir2, dir, true)
        end
    end

    if can_move then
        grid[pos] = SPACE
        grid[new] = here
    end

    return can_move
end

for command in commands:gmatch("%S") do
    local dir = dirs[command]
    local prx = setmetatable({}, { __index = grid })
    local new = robot + dir
    local mv  = move(prx, new, dir)
    if mv then
        for pos, item in pairs(prx) do
            grid[pos] = item
        end
        grid[robot] = SPACE
        grid[new]   = ROBOT
        robot       = new
    end
end

local sum = 0
for pos, ty in pairs(grid) do
    if ty == BOXL then
        sum = sum + (pos.x - 1) + 100 * (pos.y - 1)
    end
end

print(sum)
