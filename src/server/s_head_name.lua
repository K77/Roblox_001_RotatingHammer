local module = {}
local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
    player.CharacterAppearanceLoaded:Connect(function(char:Model)
        -- local char = script.Parent
        -- local player = game.Players:GetPlayerFromCharacter(char)
        print(script.Name.."CharacterAppearanceLoaded")
        local humanoid = char:WaitForChild("Humanoid")
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local head = char:WaitForChild("HumanoidRootPart")
        local headName = game.ServerStorage.HeadName:Clone()
        headName.Parent = head
        headName.Adornee = head
        headName.TextLabel.Text = player.Name
    end)
end)

return module