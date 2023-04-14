local Players = game:GetService("Players")
local run = game:GetService("RunService")
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)

_G.EnumBattleStatus = {
	none = 0,
	outBattle =1,
	goInBattle = 2,
	inBattle = 3,
	goOutBattle =4
}
print("player.battleStatus.Value",_G.EnumBattleStatus.inBattle,Players)

run.RenderStepped:Connect(function(deltaTime)
    local player = Players.LocalPlayer
    local battleStatus = player:WaitForChild("battleStatus")
    if battleStatus.Value == _G.EnumBattleStatus.inBattle then
        local rotate = player:WaitForChild("countRotate").Value
        local newCF = CFrame.new(player.Character:GetPivot().Position) 

		local rot = player.Character:GetPivot().Rotation * CFrame.Angles(0,ConfServerGlobal.rotateSpeed*(rotate+1),0)
        player.Character:PivotTo(newCF*rot)
    end
end)