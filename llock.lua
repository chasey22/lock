-- CREDITS TO RUZZEL
-- // Services
local accomidationfactor = 0.165

local Players = game:GetService("Players")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Silent Aim Module
local SilentAim = loadstring(game:HttpGet('https://pastebin.com/raw/mZ9667Bx'))()
SilentAim.TeamCheck = false

-- // Metatable vars
local mt = getrawmetatable(game)
local backupindex = mt.__index
setreadonly(mt, false)

-- // Check if player is down
SilentAim.checkSilentAim = function()
    local checkA = (SilentAim.SilentAimEnabled == true and SilentAim.Selected ~= LocalPlayer)
    local playerCharacter = SilentAim.Selected.Character
    local daHood = (playerCharacter.BodyEffects["K.O"].Value == false or playerCharacter:FindFirstChild("GRABBING_CONSTRAINT") ~= nil)

    return (checkA and daHood)
end

-- // Hook
mt.__index = newcclosure(function(t, k)
    if (t:IsA("Mouse") and (k == "Hit" or k == "Target")) then
        local CPlayer = SilentAim.Selected
        if (SilentAim.checkSilentAim()) then
            if (CPlayer.Character:FindFirstChild("HumanoidRootPart")) then
                return (k == "Hit" and CPlayer.Character.HumanoidRootPart.CFrame+(CPlayer.Character.HumanoidRootPart.Velocity*accomidationfactor) or CPlayer.Character.HumanoidRootPart.CFrame+(CPlayer.Character.HumanoidRootPart.Velocity*accomidationfactor))
            end
        end
    end
    return backupindex(t, k)
end)

-- // Revert
setreadonly(mt, true)

while wait() do
    local ping = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
    local Value = tostring(ping)
    local PingNumber = pingValue[1]
    
    accomidationfactor = PingNumber/1000 + 0.1

end