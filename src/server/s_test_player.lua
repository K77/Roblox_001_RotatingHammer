local module = {}
local Players = game:GetService("Players")
Players.PlayerAdded:Connect(function(player)
    print(player.UserId,player.Name,player.DisplayName,player.CharacterAppearanceId)
end)


return module