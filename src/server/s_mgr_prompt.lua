local module = {}
local ProximityPromptService = game:GetService("ProximityPromptService")
local ServerScriptService = game:GetService("ServerScriptService")
local s_mgr_player = require(script.Parent.s_mgr_player)

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
