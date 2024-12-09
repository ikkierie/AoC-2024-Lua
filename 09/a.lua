local id     = 0
local pos    = 1
local last   = 0
local free   = false
local memory = {}
for length in io.lines([[input.txt]], 1) do
    length = tonumber(length)
    if not free then
        for i = pos, pos + length - 1 do
            memory[i] = id
            last      = i
        end
        id = id + 1
    end
    pos  = pos + length
    free = not free
end

local checksum = 0
for i = 1, pos do
    if not memory[i] then
        while i < last and not memory[last] do
            last = last - 1
        end
        if i > last then
            break
        end
        memory[i]    = memory[last]
        memory[last] = nil
        last         = last - 1
    end
    checksum = checksum + (i - 1) * (memory[i] or 0)
end
print(checksum)