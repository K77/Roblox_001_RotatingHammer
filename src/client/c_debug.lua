local module = {}
local ui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root",20)
local player = game:GetService("Players").LocalPlayer
local lblVersion = ui:WaitForChild("TextLabel")

if player.Name == "light_horseman" then
    lblVersion.Visible = true
end


return module
