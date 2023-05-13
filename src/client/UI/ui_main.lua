local module = {}
local ui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root",20):WaitForChild("MainUI")
local ui_duiration = require(script.Parent.ui_duiration)
local Players = game:GetService("Players")
local Player = game:GetService("Players").LocalPlayer
local SocialService = game:GetService("SocialService")


local labelMoney = ui:WaitForChild("Topcentre"):WaitForChild("MeDalCount") :: TextLabel
local money = Player:WaitForChild("leaderstats"):WaitForChild("coins") :: IntValue

local battleStatus = Players.LocalPlayer:WaitForChild("battleStatus") :: IntValue






local btnInvite = ui:WaitForChild("BtnInvite"):WaitForChild("Click") :: GuiButton
btnInvite.MouseButton1Click:Connect(function()
    local success, result = pcall(
        function()
            return SocialService:CanSendGameInviteAsync(Player)
        end
    )
    if result == true then
        SocialService:PromptGameInvite(Player)
    end
end)

local btnDuration = ui:WaitForChild("Rewards"):WaitForChild("Click") :: GuiButton
btnDuration.MouseButton1Click:Connect(function()
    print("btnDuration.MouseButton1Click")
    ui_duiration.Show(true)
end)
local lableDuration = ui:WaitForChild("Rewards"):WaitForChild("TextLabel") :: TextLabel



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

    local seconds = math.floor(ui_duiration.info.duration)
    local minute = math.floor(seconds / 60)
    seconds = seconds - minute*60
    local hour = math.floor(minute/60)
    minute = minute - hour * 60
    
    if minute < 10 then
        minute = "0"..minute
    end
    if seconds < 10 then
        seconds = "0"..seconds
    end


    lableDuration.Text = hour .. ":"..minute..":"..seconds
    -- print("asdfasdfads")
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
