local module = {}
local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
    player.CharacterAppearanceLoaded:Connect(function(char:Model)
        -- local char = script.Parent
        -- local player = game.Players:GetPlayerFromCharacter(char)
        print(script.Name.."CharacterAppearanceLoaded")
        local humanoid = char:WaitForChild("Humanoid") :: Humanoid
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        humanoid.DisplayName = ""
        humanoid.NameDisplayDistance = 0
        local head = char:WaitForChild("HumanoidRootPart")
        local headName = game.ServerStorage.HeadName:Clone()
        headName.Parent = head
        headName.Adornee = head
        headName.TextLabel.Text = player.DisplayName
    end)
end)

return module