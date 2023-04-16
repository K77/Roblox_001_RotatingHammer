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
local c_prompt = require(script.Parent:WaitForChild("c_prompt"))
local c_data_bag = require(script.Parent:WaitForChild("c_data_bag"))
local ui_main = require(script.Parent.UI.ui_main)

local rotAnimation = "rbxassetid://13019768278"
local battleStatus = Players.LocalPlayer:WaitForChild("battleStatus") :: IntValue
battleStatus.Changed:Connect(function(value)
    if value == _G.EnumBattleStatus.inBattle then
        local player = Players.LocalPlayer
        local character = player.Character
        local humanoid = character:WaitForChild("Humanoid") :: Humanoid
        local animateScript = character:WaitForChild("Animate")
        animateScript.Enabled = false
    
        local animator = humanoid:WaitForChild("Animator")
        local animTracks = animator:GetPlayingAnimationTracks()
    
        for i,track in ipairs(animTracks) do
            track = track ::AnimationTrack
            print(track.Animation.AnimationId)
            track:AdjustWeight(0,0)
            track:Stop(0)
            track.Animation:Destroy()
            track:Destroy()
        end
        
        local kickAnimation = Instance.new("Animation",workspace)
        kickAnimation.AnimationId = rotAnimation
        local kickAnimationTrack = animator:LoadAnimation(kickAnimation)
        kickAnimationTrack:Play(0,10)
        animTracks = animator:GetPlayingAnimationTracks()
    
        for i,track in ipairs(animTracks) do
            print(track.Animation.AnimationId)
        end
    end
end)

print("player.battleStatus.Value",_G.EnumBattleStatus.inBattle,Players)

run.RenderStepped:Connect(function(deltaTime)
    local player = Players.LocalPlayer
    local rotateDir = player:WaitForChild("rotateDir")
    local battleStatus = player:WaitForChild("battleStatus")
    if battleStatus.Value == _G.EnumBattleStatus.inBattle then
        local rotate = player:WaitForChild("countRotate").Value
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