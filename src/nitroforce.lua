#!/usr/bin/env lua

ARGS = { ... }
VERBOSE = false

for _, arg in ipairs(ARGS) do
    if arg == "-v" or arg == "--verbose" then VERBOSE = true end
end
math.randomseed(os.time())

dofile("src/functions.lua")
dofile("src/libadb.lua")

local notice = io.open("NOTICE", "r")

if notice then
    print(notice:read("a"))
    notice:close()
end

-- Check adb
msg("Searching for adb executable...")
adb:find()

if not adb.path then
    msg("Cannot find adb executable in " .. C.ylw .. "$PATH" .. C.rst, "ERROR")
    return 1
end


msg("Found adb at \27[1;33m" .. adb.path .. "\27[0m", "OK")
msg("Checking privileges...")

local username = os.getenv("USER")
local uid = pread("id -u " .. username)

if not uid then return 1 end

if tonumber(uid) ~= 0 then
    msg("Not enough privileges", "ERROR")
    return 1
end


msg("Current user: " .. C.ylw .. username .. C.rst, "OK")
msg("Checking connected devices...")

local device = adb:get_device()

if not device or device == "" then
    msg("No devices connected", "ERROR")
    return 1
end


msg("Found connected device \27[1;33m" .. device .. "\27[0m", "OK")
msg("Tests passed, initialization complete", "OK")

sleep(1)

adb:wake()

local combination = ""
local attempt = 1
local retries_limit = 5

local digits = {}

for retries = 1, 9999 do
    for i = 1, 4 do
        digits[i] = math.random(0, 9)
        combination = combination .. digits[i]
        digits[i] = digits[i] + 7
    end

    msg(("Attempt %s%i%s, Retry %s%i%s: Combination: %s%s%s"):format(C.ylw, attempt, C.rst, C.ylw, retries, C.rst, C.ylw, combination, C.rst), "VERBOSE")

    if attempt == 3 then
        msg(("Exceeded limit of %s3%s attempts"):format(C.ylw, C.rst), "WARNING")
        msg(("From now on, there is only %s1%s retry before %s30%s second cooldown"):format(C.ylw, C.rst, C.ylw, C.rst), "WARNING")

        retries_limit = 1
    end

    for i = 0, 4 do
        adb:send_input("keyevent", digits[i])
        sleep(0.02)
    end
    combination = ""

    if retries % retries_limit == 0 then
        attempt = attempt + 1

        sleep(0.08)
        adb:send_input("keyevent", 66)

        msg(("Limit of %s%i%s retries exceeded, waiting %s30%s seconds..."):format(C.ylw, retries_limit, C.rst, C.ylw, C.rst), "WARNING")
        sleep(30)

        adb:wake()
    end
end