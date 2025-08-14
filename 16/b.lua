global <const> io, ipairs, pairs, print, require, table

local point  = require "point"
local pq     = require "pq"
local struct = require "struct"

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
            start = struct {
                pos = pos,
                dir = EAST,
            }
        end
    end
end

local paths
local queue   = pq.from { [start] = 0 }
local visited = {}
local seen    = {
    [start] = {
        cost = 0,
        paths = { { head = start } },
    },
}
while queue:peek() do
    local cur    = queue:pop()
    visited[cur] = seen[cur]
    if cur.pos == goal then
        paths = visited[cur].paths
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
        local next = struct {
            pos = next_pos,
            dir = dir,
        }
        local cost = visited[cur].cost + (
            (turn == 0)
                and MOVE_COST
                or  TURN_COST
        )
        if not seen[next] or seen[next].cost > cost then
            queue:improve_or_push(next, cost)
            seen[next] = {
                cost  = cost,
                paths = {},
            }
        end
        for _, path in ipairs(visited[cur].paths) do
            table.insert(seen[next].paths, {
                head = next,
                tail = path,
            })
        end
        ::next_dir::
    end
end

local pool = {}
for _, path in ipairs(paths) do
    while path do
        pool[path.head.pos] = true
        path                = path.tail
    end
end

local count = 0
for _ in pairs(pool) do
    count = count + 1
end
print(count)
