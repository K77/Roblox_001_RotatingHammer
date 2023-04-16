local module = {}
local ui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("MainUI")
local Player = game:GetService("Players").LocalPlayer



local labelMoney = ui:WaitForChild("Topcentre"):WaitForChild("MeDalCount") :: TextLabel
local money = Player:WaitForChild("Money") :: IntValue
labelMoney.Text = money.Value
money.Changed:Connect(function(value)
    labelMoney.Text = value
end)

local labelHeath = ui:WaitForChild("Topcentre"):WaitForChild("LifeCount") :: TextLabel
local run = game:GetService("RunService")
run.Stepped:Connect(function(time, deltaTime)
    labelHeath.Text = Player.character:WaitForChild("Humanoid").Health
end)



local btnChange = ui:WaitForChild("ChangeButton") :: GuiButton
local rotateDir = Instance.new("BoolValue",Player)
rotateDir.Name = "rotateDir"

btnChange.MouseButton1Click:Connect(function()
    rotateDir.Value = not rotateDir.Value
end)

return module
