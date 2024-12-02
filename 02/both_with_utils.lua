require "utils"

local function is_valid(ns, i)
    local sign
    return ns:stream()
        :drop_nth(i or -1)
        :windows(2)
        :where__u(function(x, y)
            local diff = math.abs(x - y)
            local prev = sign
            sign       = (x > y) and 1 or (x < y) and -1 or 0
            return (diff < 1 or diff > 3)
                or (prev and prev ~= sign)
        end)
        :none()
end

local nss = seq.from.lines([[input.txt]])
    :map(function(line)
        return seq.from.string(line, "%D+"):map(tonumber)
    end)

print("Part A:", #nss:where(is_valid))
print("Part B:", #nss:where(function(ns)
    return stream.from.range(#ns + 1):any(is_valid:bind(ns))
end))