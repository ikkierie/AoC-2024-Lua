local ls, rs = {}, {}

for line in io.lines([[input.txt]]) do
    local l, r = line:match("(%d+)%s*(%d+)")
    table.insert(ls, tonumber(l))
    table.insert(rs, tonumber(r))
end

table.sort(ls)
table.sort(rs)

local sum = 0
for i = 1, #ls do
    sum = sum + math.abs(ls[i] - rs[i])
end

print(sum)