C = {
    rst = "\27[0m",
    red = "\27[1;31m",
    grn = "\27[1;32m",
    ylw = "\27[1;33m",
    cyn = "\27[1;36m"
}


function msg(txt, lvl)

    if not lvl then
        if not VERBOSE then
            return
        end
        lvl = ("%sLOG%s"):format(C.cyn, C.rst)

    elseif lvl == "VERBOSE" then
        lvl = ("%sLOG%s"):format(C.cyn, C.rst)

    elseif lvl == "OK" then
        lvl = ("%s%s%s"):format(C.grn, lvl, C.rst)

    elseif lvl == "WARNING" then
        lvl = ("%s%s%s"):format(C.ylw, lvl, C.rst)

    elseif lvl == "ERROR" then
        lvl = ("%s%s%s"):format(C.red, lvl, C.rst)
    end

    print(("[%s][%snitroforce%s]: %s"):format(lvl, C.cyn, C.rst, txt))
end

function exists(path)
    if not path then return false end

    local f = io.open(path, "rb")

    if f then
        io.close(f)
        return true
    else
        return false
    end
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