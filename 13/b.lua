local Q = require "rational"

local b_offset = 10000000000000

local input         = io.lines([[input.txt]], "*all")():lower()
local chunk_pattern = [[
button a: x%+(%d+), y%+(%d+)
button b: x%+(%d+), y%+(%d+)
prize: x=(%d+), y=(%d+)]]

local sum = 0
for ax,ay, bx,by, px,py in input:gmatch(chunk_pattern) do
    ax, ay = Q(ax), Q(ay)
    bx, by = Q(bx), Q(by)
    px, py = Q(px + b_offset), Q(py + b_offset)

    local a = (px * by - py * bx) / (ax * by - ay * bx)
    local b = (py - a * ay) / by

    if a.d == 1 and b.d == 1 then
        sum = sum + 3 * a.n + b.n
    end
end
print(sum)