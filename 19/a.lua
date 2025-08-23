local patterns = {}

local input <close> = assert(io.open([[input.txt]]))
for pattern in input:read():gmatch("[^, ]+") do
    table.insert(patterns, "^" .. pattern)
end

input:read()

local seen = { [""] = true }
local function is_valid(line, pos)
    local sub = line:sub(pos or 1)
    if seen[sub] == nil then
        for _, pattern in ipairs(patterns) do
            local _, stop = line:find(pattern, pos)
            if stop and is_valid(line, stop + 1) then
                seen[sub] = true
                return seen[sub]
            end
        end
        seen[sub] = false
    end
    return seen[sub]
end

local count = 0
for line in input:lines() do
    if is_valid(line) then
        count = count + 1
    end
end
print(count)
