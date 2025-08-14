global <const> io, pairs, print, require

local const = require "const"
local point = require "point"
local pq    = require "pq"

local <const> MOVE_COST, TURN_COST     = 1, 1000
local <const> NORTH, EAST, SOUTH, WEST = 1, 2, 3, 4
local <const> START, GOAL, WALL, SPACE = "S", "E", "#", "."

local dirs = {
    point {  0, -1 }, -- dirs[NORTH]
    point {  1,  0 }, -- dirs[EAST]
    point {  0,  1 }, -- dirs[SOUTH]
    point { -1,  0 }, -- dirs[WEST]
}

local start, goal
local grid = {}

local y = 0
for line in io.lines([[input.txt]]) do
    y = y + 1
    for x, chr in line:gmatch("()(%S)") do
        local pos = point { x, y }
        grid[pos] = chr
        if chr == GOAL then
            goal = pos
        elseif chr == START then
            start = const {
                pos = pos,
                dir = EAST,
            }
        end
    end
end

local seen  = { [start] = 0 }
local queue = pq.from { [start] = seen[start] }
while queue:peek() do
    local cur = queue:pop()
    if cur.pos == goal then
        print(seen[cur])
        break
    end
    for turn = -1, 1 do
        local dir      = (cur.dir + turn - 1) % #dirs + 1
        local next_pos = (turn == 0)
            and cur.pos + dirs[dir]
            or  cur.pos
        if grid[next_pos] == WALL then
            goto next_dir
        end
        local next = const {
            pos = next_pos,
            dir = dir,
        }
        local cost = seen[cur] + (
            (turn == 0)
                and MOVE_COST
                or  TURN_COST
        )
        if not seen[next] or seen[next] > cost then
            seen[next] = cost
            queue:improve_or_push(next, cost)
        end
        ::next_dir::
    end
end
