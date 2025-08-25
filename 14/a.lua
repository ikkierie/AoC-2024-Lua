local w,  h  = 101,    103
local w2, h2 = w // 2, h // 2
local n      = 100
local quads  = {}
local robots = {}

for _, px, _, py, _, vx, _, vy in io.lines([[input.txt]], 2, "*n", 1, "*n", 3, "*n", 1, "*n", 1) do
    local px = (px + vx * n) % w
    local py = (py + vy * n) % h
    
    table.insert(robots, { n = i, x = px, y = py })
    local q
        =  (px < w2 and "l" or px > w2 and "r" or "")
        .. (py < h2 and "u" or py > h2 and "d" or "")
    if #q == 2 then
        quads[q] = (quads[q] or 0) + 1
    end
end

local prod = 1
for q, n in pairs(quads) do
    prod = prod * n
end
print(prod)
