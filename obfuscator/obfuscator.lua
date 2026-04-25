local input = io.read("*a")

local function rand(n)
    local s = ""
    local chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for i = 1, n do
        local c = chars:sub(math.random(#chars), math.random(#chars))
        s = s .. c
    end
    return s
end

local function encode_strings(code)
    return code:gsub([["(.-)"]], function(str)
        local bytes = {}
        for i = 1, #str do
            table.insert(bytes, str:byte(i))
        end
        return "string.char(" .. table.concat(bytes, ",") .. ")"
    end)
end

local function rename_identifiers(code)
    local map = {}
    return code:gsub("([A-Za-z_][A-Za-z0-9_]*)", function(id)
        if not map[id] then
            map[id] = "_" .. rand(12)
        end
        return map[id]
    end)
end

local function minify(code)
    code = code:gsub("%-%-[^\n]*", "")
    code = code:gsub("%s+", " ")
    return code
end

math.randomseed(os.time())

local out = input
out = encode_strings(out)
out = rename_identifiers(out)
out = minify(out)

print(out)
