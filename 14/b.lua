local <const> W, H = 101, 103

local rs = {}

for _, px, _, py, _, vx, _, vy in io.lines([[input.txt]], 2, "*n", 1, "*n", 3, "*n", 1, "*n", 1) do
    table.insert(rs, {
        pos = { x = px, y = py },
        vel = { x = vx, y = vy },
    })
end

local min_var_x   = { n = -1, val = math.huge }
local min_var_y   = { n = -1, val = math.huge }
local min_var_xy  = { n = -1, val = math.huge }
local min_var_x_y = { n = -1, val = math.huge }

local turn = 0
repeat
    local n        = 0
    local sx,  sy  = 0, 0
    local sx2, sy2 = 0, 0
    for _, r in ipairs(rs) do
        local x = (r.pos.x + r.vel.x * turn) % W
        local y = (r.pos.y + r.vel.y * turn) % H

        sx = sx + x
        sy = sy + y

        sx2 = sx2 + x^2
        sy2 = sy2 + y^2

        n = n + 1
    end

    local var_x = sx2 / n - (sx / n)^2
    local var_y = sy2 / n - (sy / n)^2

    turn = turn + 1
until math.abs(var_x) < 400 and math.abs(var_y) < 400
print(turn - 1)
