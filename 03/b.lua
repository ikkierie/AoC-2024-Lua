local input   = io.lines([[input.txt]], "*all")()
local enabled = true
local sum     = 0
for instr, args in input:gmatch("([%a']+)%(([%d,]*)%)") do
    if instr:match("do$") and args == "" then
        enabled = true
    elseif instr:match("don't$") and args == "" then
        enabled = false
    elseif enabled and instr:match("mul$") then
        local a, b = args:match("^(%d+),(%d+)$")
        if a and b then
            sum = sum + a * b
        end
    end
end
print(sum)