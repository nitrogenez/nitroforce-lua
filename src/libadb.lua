adb = {}


-- instantiates table for adb
function adb:instantiate(params)
    return
    {
        -- Fields
        path = params.path or adb:find(),
        active_device = params.active_device or self:get_device(),
        devices = params.devices or self:get_devices(),

        -- Methods
        instantiate = params.instantiate or self.instantiate,
        find = params.find or self.find,
        get_devices = params.get_devices or self.get_devices,
        get_device = params.get_device or self.get_device,
        send_input = params.send_input or self.send_input
    }
end


-- Looks for ADB in $PATH
function adb:find()
    self.path = nil

    for _, path in ipairs(os.getenv("PATH"):split(":")) do
        path = path .. "/adb"

        if exists(path) then
            self.path = path
        end
    end

    return self.path
end


-- Returns table of connected devices
function adb:get_devices()
    local out = pread("adb devices", true)

    if not out or out == "" then return nil end

    local devices = {}

    for i = 1, 10 do
        table.insert(devices, getline(out, i))
    end
    return devices
end


-- Returns connected device with index `n`
function adb:get_device(n)
    local devices = adb:get_devices()

    if not devices then return nil end
    if not n then return devices[1]:gsub("device", ""):gsub("^%s*(.-)%s*$", "%1") end

    for _, device in ipairs(devices) do
        if _ == n then return device:gsub("device", ""):gsub("^%s*(.-)%s*$", "%1") end
    end
    return nil
end


-- Wakes active device up
function adb:wake()
    self:send_input("keyevent", 82)
    sleep(0.08)
    self:send_input("swipe", { x1 = 408, y1 = 1210, x2 = 408, y2 = 85 })
end


-- Sends input to active device
function adb:send_input(type, params)
    if not params then return end

    local cmd = "adb shell input " .. type .. " "

    if type == "swipe" then
        params.duration = params.duration or ""

        cmd = cmd ..
            params.x1 .. " " .. params.y1 .. " " ..
            params.x2 .. " " .. params.y2 .. " " ..
            params.duration

    elseif type == "keyevent" then
        cmd = cmd .. params
    end
    os.execute(cmd)
end
