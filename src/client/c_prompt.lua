local module = {}
local ProximityPromptService = game:GetService("ProximityPromptService")
local ui_weapon = require(script.Parent.UI.ui_weapon)

-- Detect when prompt is triggered
local function onPromptTriggered(promptObject, player:Player)
    print("onPromptTriggered")
	ui_weapon.Show(true)
end

-- Detect when prompt hold begins
local function onPromptHoldBegan(promptObject, player)

end

-- Detect when prompt hold ends
local function onPromptHoldEnded(promptObject, player)

end

-- Connect prompt events to handling functions
-- ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptShown:Connect(onPromptTriggered)
ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)
return module
