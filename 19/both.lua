local patterns = {}

local input <close> = assert(io.open([[input.txt]]))
for pattern in input:read():gmatch("[^, ]+") do
    table.insert(patterns, "^" .. pattern)
end

input:read()

local seen = { [""] = 1 }
local function count_perms(line, pos)
    local sub = line:sub(pos or 1)
    if not seen[sub] then
        local count = 0
        for _, pattern in ipairs(patterns) do
            local _, stop = line:find(pattern, pos)
            if stop then
                count = count + count_perms(line, stop + 1)
            end
        end
        seen[sub] = count
    end
    return seen[sub]
end

local a, b = 0, 0
for line in input:lines() do
    local n = count_perms(line)
    a = a + math.min(n, 1)
    b = b + n
end
print("Part A:", a)
print("Part B:", b)
