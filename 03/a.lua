local input = io.lines([[input.txt]], "*all")()
local sum   = 0
for a, b in input:gmatch("mul%((%d+),(%d+)%)") do
    sum = sum + a * b
end
print(sum)