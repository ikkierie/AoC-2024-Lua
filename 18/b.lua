local point = require "point"
local pq    = require "priority_queue"

local <const> MEM_SIZE = 70

local dirs = {
    up    = point {  0, -1 },
    down  = point {  0,  1 },
    left  = point {  1,  0 },
    right = point { -1,  0 },
}

local memory = {}

local i = 0
for x, _, y in io.lines([[input.txt]], "*n", 1, "*n", 1) do
    i = i + 1
    memory[point { x, y }] = i
end

for y = 0, MEM_SIZE do
    for x = 0, MEM_SIZE do
        local p   = point { x, y }
        memory[p] = memory[p] or math.huge
    end
end

local start = point { 0, 0 }
local goal  = point { MEM_SIZE, MEM_SIZE }
local fail_time

-- impossible times are much faster than
-- possible ones (since the searchable
-- space is smaller), so we iterate in
-- reverse
for time = i, 1, -1 do
    local seen  = { [start] = 0 }
    local queue = pq.from { [start] = seen[start] }
    while queue:peek() do
        local cur = queue:pop()
        if cur == goal then
            fail_time = time + 1
            goto found_answer
        end
        for _, dir in pairs(dirs) do
            local next = cur + dir
            if memory[next] and memory[next] > time then
                local cost = seen[cur] + 1
                if not seen[next] or cost < seen[next] then
                    queue:improve_or_push(next, cost)
                    seen[next] = cost
                end
            end
        end
    end
end
::found_answer::

for pos, time in pairs(memory) do
    if time == fail_time then
        print(pos.x .. "," .. pos.y)
    end
end
