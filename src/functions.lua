function msg(txt, lvl)
    if not lvl then
        txt = "[\27[1;36mINFO\27[0m][\27[1;36mnitroforce\27[0m]: " .. txt
    else
        if lvl == "OK" then lvl = "\27[1;32m" .. lvl .. "\27[0m"
        elseif lvl == "ERROR" then lvl = "\27[1;31m" .. lvl .. "\27[0m"
        elseif lvl == "WARNING" then lvl = "\27[1;33m" .. lvl .. "\27[0m" end

        txt = "[" .. lvl .. "]" .. "[\27[1;36mnitroforce\27[0m]: " .. txt
    end
    print(txt)
end

function exists(path)
    path = path or "/"

    local f = io.open(path, "rb")

    if f then io.close(f) return true else return false end
end

function getline(pipe, nline)
    local i = 0

    for line in pipe:lines() do
        if i == nline then return line end
        i = i + 1
    end
    return nil
end

function sleep(duration)
    local t0 = os.clock()

    while os.clock() - t0 <= duration do end
end

function string:split(sep)
    if not sep then sep = "%s" end

    local t = {}

    for str in self:gmatch("([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

function find_adb()
    local path = os.getenv("PATH"):split(":")

    for _, p in pairs(path) do
        if exists(path[_] .. "/adb") then
            return path[_] .. "/adb"
        end
    end
    return nil
end

function pread(cmd, return_pipe)
    local pipe = io.popen(cmd, 'r')

    if not pipe then return nil end
    if return_pipe then return pipe end

    local o = pipe:read("a")
    pipe:close()

    return o
end