-- local module = {}
-- local players = game:GetService("Players")

-- local PlayerDataStore = game:GetService("DataStoreService"):GetDataStore("s_all_user")

-- local function NewUserInfo(player)
--     local tmp = {}
--     tmp.name = player.name
--     tmp.displayName = player.displayName
-- end

-- local function savePlayerDataToDataStore(player)
-- 	local playerId = player.UserId

--     local value =  NewUserInfo(player)
    
-- 	local success, err = pcall(function()
-- 		local key = tostring(playerId)
-- 		PlayerDataStore:SetAsync(key,value)
-- 		print("save player data to datastore", key, value)
-- 	end)
-- 	if not success then
-- 		error(err)
-- 	end
-- end

-- local function getPlayerDataFromDataStore(player)
-- 	local playerId = player.UserId
-- 	local value = nil
-- 	local success, err = pcall(function()
-- 		local key = tostring(playerId)
-- 		value = PlayerDataStore:GetAsync(key)
-- 		print("get player data from datastore", key, value)
-- 	end)
-- 	if not success then
-- 		print(err)
-- 	end
-- 	return value
-- end

-- players.PlayerAdded:Connect(function(player)
--     local tmp = getPlayerDataFromDataStore(player)
--     if tmp == nil then
--         savePlayerDataToDataStore(player)
--     end
-- end)



-- return module