local patterns = {}

local input <close> = assert(io.open([[input.txt]]))
for pattern in input:read():gmatch("[^, ]+") do
    table.insert(patterns, "^" .. pattern)
end

input:read()

local seen = { [""] = 1 }
local function is_valid(line, pos)
    local sub = line:sub(pos or 1)
    if not seen[sub] then
        local count = 0
        for _, pattern in ipairs(patterns) do
            local _, stop = line:find(pattern, pos)
            if stop then
                count = count + is_valid(line, stop + 1)
            end
        end
        seen[sub] = count
    end
    return seen[sub]
end

local count = 0
for line in input:lines() do
    count = count + is_valid(line)
end
print(count)
