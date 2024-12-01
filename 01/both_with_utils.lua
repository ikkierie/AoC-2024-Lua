require "utils"

local ls, rs = stream.from.iterator_mult(io.lines([[input.txt]], "*n", "*n"))
    :collect(seq)
    :transpose()
    :map(seq.sort)
    :unpack()

print("Part A:", ls:zip(rs):stream():map__u(func.ops["-"] >> math.abs):sum())
print("Part B:", ls:map(function(l) return l * rs:count(l) end):sum())