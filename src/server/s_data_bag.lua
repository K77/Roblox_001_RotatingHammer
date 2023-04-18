local module = {}
print("ServerData_UserBag begin init")
local DataStoreService = game:GetService("DataStoreService")
local PlayerBagStore = DataStoreService:GetDataStore("PlayerBag")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local S2C_Event_BagChange = ReplicatedStorage._RojoShare.Remote.s2c_bag_change
local C2S_Func_GetAllBag = ReplicatedStorage._RojoShare.Remote.c2s_all_bag

local dicBag = {}
local needSave = {}

local function SaveAll(player)
	-- if player.UserId <= 0 then return end
	local success, err = pcall(function()
		-- local key = tostring(player.UserId)
		PlayerBagStore:SetAsync(player.UserId,dicBag[player.UserId])
		print("save player data to datastore", player.UserId, dicBag[player.UserId])
	end)
	if not success then
		print(err)
	end
end

function module.changeItemCount(player,itemName,count)
	local playerId = player.UserId
	count = count or 1
	local itemId = tostring(itemName)
	print("will save bag: ",playerId, itemName,count,dicBag[player.UserId],type(itemName))

	
	if dicBag[player.UserId][itemId] then
		dicBag[player.UserId][itemId] = dicBag[player.UserId][itemId]+count
	else
		dicBag[player.UserId][itemId] = count
	end

	print(dicBag)
	
	S2C_Event_BagChange:FireClient(player,itemId,dicBag[player.UserId][itemId])
	if needSave[player.UserId] then return end
	needSave[player.UserId] = true
	task.wait(1)
	SaveAll(player)
	needSave[player.UserId] = nil
end

-- function module.getPlayerDataFromDataStore(player)
-- 	local playerId = player.UserId
-- 	print("get data: ",playerId, "PlayerBag")

-- 	if playerId <= 0 then return 0 end
-- 	local value = nil
-- 	local success, err = pcall(function()
-- 		local key = tostring(playerId)
-- 		value = PlayerBagStore:GetAsync(key)
-- 		print("get player data from datastore", key, value)
-- 	end)
-- 	if not success then
-- 		print(err)
-- 		task.wait(1)
-- 		return module.getPlayerDataFromDataStore(player)
-- 	end
-- 	return value or {}
-- end

function module.removePlayerFromDataStore(player)
	local playerId = player.UserId
	print("get data: ",playerId)

	-- if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		value = PlayerBagStore:RemoveAsync(playerId)
		print("get player data from datastore", playerId, value)
	end)
	if not success then
		print(err)
	end
	return value
end

function module.removePlayerDataFromDataStore(player, dataName)
	local playerId = player.UserId
	print("get data: ",playerId, dataName)

	-- if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		value = PlayerBagStore:RemoveAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

-- game.Players.PlayerAdded:Connect(function(player)
-- 	module.removePlayerFromDataStore(player)
-- end)

-- game.Players.PlayerRemoving:Connect(function(player)
-- 	SaveAll(player)
-- 	dicBag[player.UserId] = nil
-- end)

-- local function GetAllItem(player)
-- 	print("ServerData_UserBag GetAllItem: ",player.UserId)
-- 	return dicBag[player.UserId]
-- end

C2S_Func_GetAllBag.OnServerInvoke = function(player)
	local playerId = player.UserId
	print("get data: ",playerId, "PlayerBag")

	-- if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		-- local key = tostring(playerId)
		value = PlayerBagStore:GetAsync(playerId)
		print("get player data from datastore", playerId, value)
	end)
	if not success then
		print(err)
		task.wait(1)
		module.getPlayerDataFromDataStore(player)
	end
	if value == nil or value == {} then value = {["1"] = 1} end
	dicBag[playerId] = value
	print(dicBag)
	return dicBag[playerId]
end

return module
