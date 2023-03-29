game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(c)
        local stick = game:GetService("Workspace"):WaitForChild("Model"):Clone()
        -- local aa = game:GetService("Players").LocalPlayer:WaitForChild("Character")
        -- stick.Parent = player.Character.Humanoid
        stick.Parent = c--:WaitForChild("Humanoid")
        -- player:SetAttribute("stick",stick)
        print(player.UserId)
    end)

end)


