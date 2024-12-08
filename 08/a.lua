local enumerate = require "enumerate"
local point     = require "point"
local set       = require "set"

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

local seen = {}
for _, ns in pairs(nodes) do
    for i = 2, #ns do
        for j = 1, i - 1 do
            local dist = ns[i] - ns[j]
            for _, p in ipairs { ns[j] - dist, ns[i] + dist } do
                if grid[p] then
                    seen[p] = true
                end
            end
        end
    end
end
print(#set.from.keys(seen))
