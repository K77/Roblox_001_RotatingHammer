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
local currentSecond  = 0-- = os.time()
local today = math.floor( os.time() / oneDaySeconds)
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
        table.insert(tmp.rewards,keyDuration[i])
        -- tmp.rewards[keyDuration[i]] = false
    end
    dicDuration[player] = tmp
    return tmp
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    local data = getPlayerDataFromDataStore(player)
    if data == nil then data = NewData(player) 
    else
        if data.loginDate ~= today then
            data = NewData(player)
        end
    end
    dicDuration[player] = data
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    savePlayerDataToDataStore(player)
end)

game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
    time = math.floor(time)
    if currentSecond == time then return end
    
    currentSecond = time
    local todayTmp = math.floor( os.time() / oneDaySeconds)
    if todayTmp~= today then
        
        for player, value in dicDuration do
            NewData(player)
        end
    else
        for player, value in dicDuration do
            dicDuration[player].duration += 1
        end
    end
    today = todayTmp
    -- print("today:", today)

end)


local c2s_get_duration_info = game:GetService("ReplicatedStorage")._RojoShare.Remote.c2s_get_duration_info
local c2s_get_duration_reward = game:GetService("ReplicatedStorage")._RojoShare.Remote.c2s_get_duration_reward
c2s_get_duration_info.OnServerInvoke = function(player)
	return dicDuration[player]
end
c2s_get_duration_reward.OnServerInvoke = function(player,duration)
    local data = dicDuration[player].rewards
    for i = 1, #data, 1 do
        if data[i] == duration then
            table.remove(data,i)
            if ConfServerGlobal.duration[duration] then
                player.leaderstats.coins.Value += ConfServerGlobal.duration[duration]
            end
            break
        end
    end
	return dicDuration[player]
end
return module