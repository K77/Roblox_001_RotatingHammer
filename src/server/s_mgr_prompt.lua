local module = {}
local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")
local Players = game:GetService("Players")
local s_mgr_player = require(script.Parent.s_player_status)

local function transToBattle(otherPart)
	local humanoid = otherPart.Parent:FindFirstChild("Humanoid") :: Humanoid
	if humanoid then
		local echar = humanoid.Parent --game.Players:GetPlayerFromCharacter()
		local player = Players:GetPlayerFromCharacter(echar)
		if player then
			s_mgr_player.goInBattle(player)
		end
	end
end

local TransToBattle1 = workspace.SafeZone.TransToBattle1
local TransToBattle2 = workspace.SafeZone.TransToBattle2
TransToBattle1.Touched:Connect(transToBattle)
TransToBattle2.Touched:Connect(transToBattle)


-- Detect when prompt is triggered
local function onPromptTriggered(promptObject, player:Player)
	if promptObject.Name == "PromptTransToBattle" then
		s_mgr_player.goInBattle(player)
	elseif promptObject.Name == "PromptTransToSafe" then
		s_mgr_player.goOutBattle(player)
	end
end

-- Detect when prompt hold begins
local function onPromptHoldBegan(promptObject, player)

end

-- Detect when prompt hold ends
local function onPromptHoldEnded(promptObject, player)

end

-- Connect prompt events to handling functions
ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)
return module
