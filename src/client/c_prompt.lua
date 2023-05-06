local module = {}
local ProximityPromptService = game:GetService("ProximityPromptService")

-- Detect when prompt is triggered
local function onPromptTriggered(promptObject:ProximityPrompt, player:Player)
    if promptObject.Name == "PromptWeapon" then
        local ui_weapon = require(script.Parent.UI.ui_weapon)
        ui_weapon.Show(true,promptObject:GetAttribute("itemId"))
        print("onPromptTriggered",promptObject:GetAttribute("itemId"))
    elseif promptObject.Name == "PromptExpWeapon" then
        local ui_weapon = require(script.Parent.UI.ui_exp_weapon)
        ui_weapon.Show(true,promptObject:GetAttribute("itemId"))
        print("onPromptTriggered",promptObject:GetAttribute("itemId"))
    end
end

-- Detect when prompt hold begins
local function onPromptHidden(promptObject, player)
    if promptObject.Name == "PromptWeapon" then
        local ui_weapon = require(script.Parent.UI.ui_weapon)
        ui_weapon.Show(false)
    elseif promptObject.Name == "PromptExpWeapon" then
        local ui_weapon = require(script.Parent.UI.ui_exp_weapon)
        ui_weapon.Show(false)
    end
end

-- Detect when prompt hold ends
local function onPromptHoldEnded(promptObject, player)

end

-- Connect prompt events to handling functions
-- ProximityPromptService.PromptTriggered:Connect(onPromptTriggered)
ProximityPromptService.PromptShown:Connect(onPromptTriggered)
ProximityPromptService.PromptHidden:Connect(onPromptHidden)
-- ProximityPromptService.PromptButtonHoldBegan:Connect(onPromptHoldBegan)
-- ProximityPromptService.PromptButtonHoldEnded:Connect(onPromptHoldEnded)
return module
