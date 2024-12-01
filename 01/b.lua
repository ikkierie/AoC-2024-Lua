local ls, rs = {}, {}

for line in io.lines([[input.txt]]) do
    local l, r = line:match("(%d+)%s*(%d+)")
    table.insert(ls, tonumber(l))
    table.insert(rs, tonumber(r))
end

local sum = 0
for _, l in ipairs(ls) do
    local n = 0
    for _, r in ipairs(rs) do
        if l == r then
            n = n + 1
        end
    end
    sum = sum + l * n
end

print(sum)