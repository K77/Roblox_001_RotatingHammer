local module = {}



-- local MgrUI = require(script.Parent:WaitForChild("C_Mgr_UI"))
-- function module.Init()
-- 	module.UI = MgrUI.UI_Root:WaitForChild("UI_Main",100)
-- 	local Btn_Bag = module.UI:WaitForChild("Btn_Bag")
-- 	Btn_Bag.MouseButton1Click:Connect(function()
-- 		print("asdfasdfasdfasdfsadfsdf")
-- 		local UI_Bag = require(script.Parent:WaitForChild("UI_Bag"))
-- 		UI_Bag.Show()
-- 	end)
	
-- 	module.UI = MgrUI.UI_Root:WaitForChild("UI_Main",100)
-- 	local Btn_buy_ring = module.UI:WaitForChild("ImageLabel"):WaitForChild("Btn_BuyRing")
-- 	Btn_buy_ring.MouseButton1Click:Connect(function()
-- 		print("asdfasdfasdfasdfsadfsdf")
-- 		local UI_Robuxshop = require(script.Parent:WaitForChild("UI_Robuxshop"))
-- 		UI_Robuxshop.Show()
-- 	end)
	
-- 	local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- 	local S2C_Event_BagChange = ReplicatedStorage:WaitForChild("Remote"):WaitForChild("S2C_Event_BagChange")
-- 	S2C_Event_BagChange.OnClientEvent:Connect(function(itemName,itemCount,itemChange)
-- 		if itemName == nil then return end
-- 		if itemChange < 0 then return end
-- 		wait(0.7)
-- 		local toast = module.UI:WaitForChild("Toast_reward")
-- 		--local conf = require(game:GetService("ReplicatedStorage").Confs.ConfsReward1)
		
-- 		toast.Visible = true
-- 		toast.ImageLabel.Image = _G.UI_Bag.ConfsReward.dic[itemName].icon
-- 		wait(1)
-- 		toast.Visible =false
-- 	end)
-- end
return module
