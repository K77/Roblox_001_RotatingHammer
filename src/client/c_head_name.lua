-- local module = {}
-- local player = game:GetService("Players").LocalPlayer
-- local headName

-- local function addHeadName(char)
--     if char == nil then return end
--     print(script.Name.."CharacterAppearanceLoaded")
--     local humanoid = char:WaitForChild("Humanoid") :: Humanoid
--     humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
--     humanoid.NameDisplayDistance = 0
--     local head = char:WaitForChild("HumanoidRootPart")
--     if headName then headName:Destroy() end
--     headName = workspace:WaitForChild("Util"):WaitForChild("HeadName"):Clone()
--     headName.Parent = head
--     headName.Adornee = head
--     headName.TextLabel.Text = player.DisplayName
-- end

-- player.CharacterAppearanceLoaded:Connect(addHeadName)
-- addHeadName(player.Character)

-- return module