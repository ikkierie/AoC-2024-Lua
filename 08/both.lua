local enumerate = require "enumerate"
local point     = require "point"
local seq       = require "seq"

local nodes = {}
local grid  = {}
for y, line in enumerate(io.lines([[input.txt]])) do
    for x, char in line:gmatch("()(.)") do
        local p = point { x, y }
        grid[p] = char
        if char:match("%w") then
            nodes[char] = nodes[char] or {}
            table.insert(nodes[char], p)
        end
    end
end

local a, b = {}, {}
for _, ns in pairs(nodes) do
    for i = 2, #ns do
        for j = 1, i - 1 do
            local dist = ns[i] - ns[j]
            local p    = ns[j]
            if grid[p - dist] then
                a[p - dist] = true
            end
            while grid[p] do
                b[p] = true
                p = p - dist
            end
            p = ns[i]
            if grid[p + dist] then
                a[p + dist] = true
            end
            while grid[p] do
                b[p] = true
                p = p + dist
            end
        end
    end
end
print("Part A:", #seq.from.keys(a))
print("Part B:", #seq.from.keys(b))