local module = {}
local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerEquip1")
local c2s_equip = game:GetService("ReplicatedStorage")._RojoShare.Remote.c2s_equip

c2s_equip.OnServerEvent:Connect(function(player,itemId)
	player.Equip.Value = itemId
end)
local function savePlayerDataToDataStore(player,dataName,value)
	local playerId = player.UserId
	print("save data: ",playerId, dataName,value)
	-- if playerId <= 0 then return end
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		PlayerDataStore:SetAsync(key,value)
		print("save player data to datastore", key, value)
	end)
	if not success then
		print(err)
	end
end

local function getPlayerDataFromDataStore(player, dataName)
	local playerId = player.UserId
	print("get data: ",playerId, dataName)

	-- if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		value = PlayerDataStore:GetAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

local function removePlayerDataFromDataStore(player, dataName)
	local playerId = player.UserId
	print("get data: ",playerId, dataName)

	-- if playerId <= 0 then return 0 end
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId ..":" .. dataName)
		value = PlayerDataStore:RemoveAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

local defaultWeapon = "exp_0"
local needChangePlayerList = {}
game.Players.PlayerAdded:Connect(function(player)
	local Equip = Instance.new("StringValue", player)
	Equip.Name = "Equip"
	Equip.Value = defaultWeapon

	local EquipValue = getPlayerDataFromDataStore(player,"equip")
	if EquipValue == nil then EquipValue = defaultWeapon end
	print("Equip: "..EquipValue)
	Equip.Value = EquipValue
	Equip.Changed:Connect(function()
		if needChangePlayerList[player.UserId] then return end
		needChangePlayerList[player.UserId] = true
		wait(6)
		savePlayerDataToDataStore(player,"equip",Equip.Value)
		needChangePlayerList[player.UserId]  = nil
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	savePlayerDataToDataStore(player,"equip",player.Equip.Value)
end)
return module