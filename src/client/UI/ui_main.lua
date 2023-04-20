local module = {}
local ui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root",20):WaitForChild("MainUI")
local Players = game:GetService("Players")
local Player = game:GetService("Players").LocalPlayer



local labelMoney = ui:WaitForChild("Topcentre"):WaitForChild("MeDalCount") :: TextLabel
local money = Player:WaitForChild("leaderstats"):WaitForChild("coins") :: IntValue

local battleStatus = Players.LocalPlayer:WaitForChild("battleStatus") :: IntValue



labelMoney.Text = money.Value
local btnChange = ui:WaitForChild("ChangeButton") :: GuiButton
btnChange.Visible = false
local txtChangeCD = btnChange:WaitForChild("TextCD") :: TextLabel
txtChangeCD.Visible = false

battleStatus.Changed:Connect(function(value)
    if value == _G.EnumBattleStatus.inBattle then
        btnChange.Visible = true
        txtChangeCD.Visible = false
    elseif value == _G.EnumBattleStatus.outBattle then
        btnChange.Visible = false
    end
end)

money.Changed:Connect(function(value)
    labelMoney.Text = value
end)

local run = game:GetService("RunService")
run.Stepped:Connect(function(time, deltaTime)
    local uiTopcentre = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
        :WaitForChild("UI_Root"):WaitForChild("MainUI"):WaitForChild("Topcentre")
    uiTopcentre:WaitForChild("LifeCount").Text = Player.character:WaitForChild("Humanoid").Health
    uiTopcentre:WaitForChild("MoveSpeed").Text = Player:WaitForChild("countShoe").Value
    uiTopcentre:WaitForChild("RotatingSpeed").Text = Player:WaitForChild("countRotate").Value
    uiTopcentre:WaitForChild("WeaponScale").Text = Player:WaitForChild("countWeapon").Value
end)




local rotateDir = Instance.new("BoolValue",Player)
rotateDir.Name = "rotateDir"

local cdTime = 3
local curCD = 9999
btnChange.MouseButton1Click:Connect(function()
    if curCD < cdTime then return end
    txtChangeCD.Visible = true
    curCD = 0
    Player.rotateDir.Value = not Player.rotateDir.Value
    while curCD < cdTime do
        txtChangeCD.Text = cdTime - curCD
        task.wait(1)
        curCD += 1
    end
    txtChangeCD.Visible = false
end)

return module
