local Q = require "rational"

local b_offset = Q(10000000000000)

local input         = io.lines([[input.txt]], "*all")():lower()
local chunk_pattern = [[
button a: x%+(%d+), y%+(%d+)
button b: x%+(%d+), y%+(%d+)
prize: x=(%d+), y=(%d+)]]

local function score(ax,ay, bx,by, px,py)
    local a = (px * by - py * bx) / (ax * by - ay * bx)
    local b = (py - a * ay) / by
    return (a.d == 1 and b.d == 1)
        and 3 * a.n + b.n
        or  0
end

local a, b = 0, 0
for ax,ay, bx,by, px,py in input:gmatch(chunk_pattern) do
    ax, ay = Q(ax), Q(ay)
    bx, by = Q(bx), Q(by)
    px, py = Q(px), Q(py)
    a = a + score(ax,ay, bx,by, px,py)
    b = b + score(ax,ay, bx,by, px+b_offset,py+b_offset)
end
print("Part A:", a)
print("Part B:", b)