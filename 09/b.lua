local id     = 0
local pos    = 1
local free   = false
local files  = {}
local memory = {}
local spaces = {}
for length in io.lines([[input.txt]], 1) do
    length = tonumber(length)
    if free then
        table.insert(spaces, { pos = pos, len = length })
    else
        table.insert(files, { id = id, pos = pos, len = length })
        for i = pos, pos + length - 1 do
            memory[i] = id
        end
        id = id + 1
    end
    pos  = pos + length
    free = not free
end

for i = #files, 1, -1 do
    local file = files[i]
    for j = 1, #spaces do
        local space = spaces[j]
        if space.pos >= file.pos then
            break
        end
        if file.len <= space.len then
            for k = 1, file.len do
                memory[space.pos + k - 1] = file.id
                memory[file.pos  + k - 1] = nil
            end
            space.len = space.len - file.len
            space.pos = space.pos + file.len
            if space.len <= 0 then
                table.remove(spaces, j)
            end
            break
        end
    end
end

local checksum = 0
for i = 1, pos do
    checksum = checksum + (i - 1) * (memory[i] or 0)
end
print(checksum)