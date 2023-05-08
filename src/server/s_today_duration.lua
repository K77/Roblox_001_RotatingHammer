local module = {}
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)
local PlayerDataStore = game:GetService("DataStoreService"):GetDataStore("s_today_duration")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local keyDuration = {}
for key, value in ConfServerGlobal.duration do
    table.insert(keyDuration,key)
end
table.sort(keyDuration)

local oneDaySeconds = 60*60*25
local currentSecond = os.time()
local today = currentSecond / oneDaySeconds
local dicDuration = {}

local function savePlayerDataToDataStore(player)
	local playerId = player.UserId

    local value = dicDuration[player]
    if value == nil then return end
	local success, err = pcall(function()
		local key = tostring(playerId)
		PlayerDataStore:SetAsync(key,value)
		print("save player data to datastore", key, value)
	end)
	if not success then
		print(err)
	end
end

local function getPlayerDataFromDataStore(player)
	local playerId = player.UserId
	local value = nil
	local success, err = pcall(function()
		local key = tostring(playerId)
		value = PlayerDataStore:GetAsync(key)
		print("get player data from datastore", key, value)
	end)
	if not success then
		print(err)
	end
	return value
end

function NewData(player)
    local tmp = {}
    tmp.duration = 0
    tmp.loginDate = today
    tmp.rewards = {}
    for i = 1, #keyDuration, 1 do
        tmp.rewards[keyDuration[i]] = false
    end
    dicDuration[player] = tmp
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    local data = getPlayerDataFromDataStore(player)
    if data == nil then data = NewData(player) 
    else
        if data.loginDate ~= today then
            data = NewData(player)
        end
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    savePlayerDataToDataStore(player)
end)

game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
    if currentSecond == time then return end
    currentSecond = time
    for player, value in dicDuration do
        dicDuration[player].duration += 1
    end
end)

local function getdurationReward(player,value)
    local result = 0
    while true do
        local data = dicDuration[player]
        if data == nil then 
            result = 1
            break
        end
        if data.rewards[value] == false then
            data.rewards[value] = true
            --todo 发送对应奖励
            break
        else
            result = 2
            break
        end
    end
    return result
end
local C2S_Func_GetAllBag = ReplicatedStorage._RojoShare.Remote.c2s_duration_reward

C2S_Func_GetAllBag.OnServerInvoke = function(player,rewardsId)
    return getdurationReward(player,rewardsId)
end

return module