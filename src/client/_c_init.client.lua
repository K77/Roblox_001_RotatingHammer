local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false)


_G.Remote = game:GetService("ReplicatedStorage"):WaitForChild("_RojoShare"):WaitForChild("Remote") :: Folder
print("_G.Remote: ",_G.Remote)
_G.EnumBattleStatus = {
	none = 0,
	outBattle =1,
	goInBattle = 2,
	inBattle = 3,
	goOutBattle =4
}


local Players = game:GetService("Players")
local run = game:GetService("RunService")
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)
local c_debug = require(script.Parent:WaitForChild("c_debug"))
local c_prompt = require(script.Parent:WaitForChild("c_prompt"))
local c_data_bag = require(script.Parent:WaitForChild("c_data_bag"))
local ui_main = require(script.Parent.UI.ui_main)
local c_animation = require(script.Parent.c_animation)
local player = Players.LocalPlayer


local rotAnimation = "rbxassetid://13019768278"
local battleStatus = Players.LocalPlayer:WaitForChild("battleStatus") :: IntValue

battleStatus.Changed:Connect(function(value)
    if value == _G.EnumBattleStatus.inBattle then
        -- rotAnimation = workspace:WaitForChild("Sounds"):WaitForChild("HandsUp")--
        c_animation.onlyRot()
    elseif value == _G.EnumBattleStatus.outBattle then
        c_animation.resetAnim(player)
    end
end)

print("player.battleStatus.Value",_G.EnumBattleStatus.inBattle,Players)

run.RenderStepped:Connect(function(deltaTime)
    local player = Players.LocalPlayer
    local rotateDir = player:WaitForChild("rotateDir")
    local battleStatus = player:WaitForChild("battleStatus")
    if battleStatus.Value == _G.EnumBattleStatus.inBattle then
        local rotate = player:WaitForChild("countRotate").Value * ConfServerGlobal.rotateToolAdd
        local newCF = CFrame.new(player.Character:GetPivot().Position)
        local rValue = 0
        if rotateDir.Value then
            rValue = ConfServerGlobal.rotateSpeed*(rotate+1)
        else
            rValue = -ConfServerGlobal.rotateSpeed*(rotate+1)
        end


		local rot = player.Character:GetPivot().Rotation * CFrame.Angles(0,rValue,0)
        player.Character:PivotTo(newCF*rot)
    end
end)