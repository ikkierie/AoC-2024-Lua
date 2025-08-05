global <const> *

local point = require "point"

local <const> ROBOT, BOX, WALL, SPACE = "@", "O", "#", "."
local <const> UP, DOWN, LEFT, RIGHT   = "^", "v", "<", ">"

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
            local p = point { x, y }
            if c == ROBOT then
                robot = p
            end
            grid[p] = c
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

local function move(pos, new, dir)
    if     grid[new] == WALL then return false
    elseif grid[new] == BOX  then return move(new, new + dir, dir)
    else                          return (grid[pos] ~= BOX) or new
    end
end

for command in commands:gmatch("%S") do
    local dir = dirs[command]
    local new = robot + dir
    local mv  = move(robot, new, dir)
    if mv then
        grid[robot] = SPACE
        grid[new]   = ROBOT
        robot       = new
        if mv ~= true then
            grid[mv] = BOX
        end
    end
end

local sum = 0
for pos, ty in pairs(grid) do
    if ty == BOX then
        sum = sum + (pos.x - 1) + 100 * (pos.y - 1)
    end
end

print(sum)
