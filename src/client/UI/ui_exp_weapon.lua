local module = {}
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)

local RunService = game:GetService("RunService")
local c_data_bag = require(script.Parent.Parent.c_data_bag)
module.isShow = false
module.asset = nil
local Player = game:GetService("Players").LocalPlayer
local c2s_equip = game:GetService("ReplicatedStorage")._RojoShare.Remote.c2s_equip
local ui
function module.Show(flag:boolean, ...)
    module.isShow = flag
    local arg = {...}
	if flag then
		local uiTmp = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("ui_weapon")
		ui = uiTmp:Clone()
        ui.Parent = uiTmp.Parent
        ui.Enabled = true

        local itemId = arg[1]

        local txtDes = ui:WaitForChild("ImageBack"):WaitForChild("TextDes") :: TextLabel
        txtDes.Text = ConfServerGlobal.equip[itemId].descript

        local txtName = ui:WaitForChild("ImageBack"):WaitForChild("TextName") :: TextLabel
        txtName.Text = ConfServerGlobal.equip[itemId].name

        local Btn_close = ui:WaitForChild("ImageBack"):WaitForChild("BtnClose") :: GuiButton
        Btn_close.MouseButton1Click:Connect(function()
            module.Show(false)
        end)

        local Btn_buy_ring = ui:WaitForChild("ImageBack"):WaitForChild("ImageLabel"):WaitForChild("TextButton") :: TextButton
        local money = Player:WaitForChild("leaderstats"):WaitForChild("coins").Value
        -- local itemCount = c_data_bag.GetItemCount(itemId)
        -- if itemCount>0 then
        --     Btn_buy_ring.Text = "EQUIP"
        --     else
        --         Btn_buy_ring.Text = "Buy"
        -- end
        Btn_buy_ring.MouseButton1Click:Connect(function()
            print("btn click", arg[1])
            if money > ConfServerGlobal.equip[itemId].needExp then
                c2s_equip:FireServer(itemId)
            else
                return
                -- local MarketplaceService = game:GetService("MarketplaceService")
                -- local Players = game:GetService("Players")
                -- local Player = Players.LocalPlayer
                -- MarketplaceService:PromptProductPurchase(Player,itemId)
            end
            module.Show(false)
        end)
    else
        if ui then ui:Destroy() end
    end
end

RunService.Stepped:Connect(function(time, deltaTime)
    if not module.isShow then return end
    
end)

return module