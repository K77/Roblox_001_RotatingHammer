local module = {}
local ui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("MainUI")
local Player = game:GetService("Players").LocalPlayer



local labelMoney = ui:WaitForChild("Topcentre"):WaitForChild("MeDalCount") :: TextLabel
local money = Player:WaitForChild("Money") :: IntValue
labelMoney.Text = money.Value
money.Changed:Connect(function(value)
    labelMoney.Text = value
end)

local run = game:GetService("RunService")
run.Stepped:Connect(function(time, deltaTime)
    local ui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("MainUI")
    local labelHeath = ui:WaitForChild("Topcentre"):WaitForChild("LifeCount") :: TextLabel
    print("run.Stepped",Player.character:WaitForChild("Humanoid").Health)
    labelHeath.Text = Player.character:WaitForChild("Humanoid").Health
end)



local btnChange = ui:WaitForChild("ChangeButton") :: GuiButton
local rotateDir = Instance.new("BoolValue",Player)
rotateDir.Name = "rotateDir"

btnChange.MouseButton1Click:Connect(function()
    print("btnChange.MouseButton1Click")
    Player.rotateDir.Value = not Player.rotateDir.Value
end)

return module
