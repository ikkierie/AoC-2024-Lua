local function explore(a, b, goal)
    local gx, gy  = goal:match("^(%d+),(%d+)$")
    local dirs    = { [a] = 3, [b] = 1 }
    local pos     = "0,0"
    local visited = {}
    local seen    = { [pos] = 0 }
    local queue   = { pos }
    while queue[1] and pos ~= goal do
        pos          = table.remove(queue, 1)
        visited[pos] = seen[pos]
        for dir, cost in pairs(dirs) do
            local px, py = pos:match("^(%d+),(%d+)$")
            local dx, dy = dir:match("^(%d+),(%d+)$")
            local new    = (px + dx) .. "," .. (py + dy)
            if
                not visited[new]
                and px + dx - gx <= 0
                and py + dy - gy <= 0
            then
                cost = cost + seen[pos]
                if not seen[new] then
                    table.insert(queue, new)
                end
                seen[new] = math.min(cost, seen[new] or math.huge)
            end
        end
    end
    return seen[goal] or 0
end

local input         = io.lines([[input.txt]], "*all")():lower()
local chunk_pattern = [[
button a: x%+(%d+), y%+(%d+)
button b: x%+(%d+), y%+(%d+)
prize: x=(%d+), y=(%d+)]]
local sum = 0
for ax,ay, bx,by, px,py in input:gmatch(chunk_pattern) do
    sum = sum + explore(
        ax .. "," .. ay,
        bx .. "," .. by,
        px .. "," .. py
    )
end
print(sum)