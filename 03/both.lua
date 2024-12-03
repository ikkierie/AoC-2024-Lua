local input   = io.lines([[input.txt]], "*all")()
local enabled = true
local a, b    = 0, 0
for instr, args in input:gmatch("([%a']+)%(([%d,]*)%)") do
    if instr:match("do$") then
        enabled = true
    elseif instr:match("don't$") then
        enabled = false
    elseif instr:match("mul$") then
        local x, y = args:match("^(%d+),(%d+)$")
        if x and y then
            if enabled then
                b = b + x * y
            end
            a = a + x * y
        end
    end
end
print("Part A:", a)
print("Part B:", b)