local RunService = game:GetService("RunService")
Players = game:GetService("Players")
RunService.Stepped:Connect(function(_time,delta)
    for i,player in pairs(Players:GetPlayers()) do
    if player.Character and player.Character.Model then
        local newCF = CFrame.new(player.Character:GetPivot().Position) 
        local rot = player.Character.Model:GetPivot().Rotation * CFrame.Angles(0,0.1,0)
        player.Character.Model:PivotTo(newCF*rot)
    end
    end
	
end)

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(c)
        local stick = game:GetService("Workspace"):WaitForChild("Model"):Clone()
        -- local aa = game:GetService("Players").LocalPlayer:WaitForChild("Character")
        -- stick.Parent = player.Character.Humanoid
        stick.Parent = c--:WaitForChild("Humanoid")
        -- player:SetAttribute("stick",stick)
        -- player.stick = stick
        -- print(player.UserId)
        print(player.UserId,player.Character.Model.Name)

    end)

end)





