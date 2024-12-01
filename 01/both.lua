local ls, rs = {}, {}

for line in io.lines([[input.txt]]) do
    local l, r = line:match("(%d+)%s*(%d+)")
    table.insert(ls, tonumber(l))
    table.insert(rs, tonumber(r))
end

table.sort(ls)
table.sort(rs)

local a, b = 0, 0
for i = 1, #ls do
    local l, r = ls[i], rs[i]
    local n_rs = 0
    for j = 1, #rs do
        if rs[j] == l then
            n_rs = n_rs + 1
        end
    end
    a = a + math.abs(l - r)
    b = b + l * n_rs
end

print("Part A:", a)
print("Part B:", b)