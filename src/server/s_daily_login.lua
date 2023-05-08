local module = {}
local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDailyLogin")
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)

print("ConfServerGlobal.duration: ", #ConfServerGlobal.duration)

local Players = game:GetService("Players")
local oneDaySeconds = 60*60*25
local dbKeyDays = "keyDays"
local dbKeyDuration = "keyDuration"
local today = os.time() / oneDaySeconds


function processData(days)
    local function newDailyData()
        local tmp = {}
        tmp.CreateDay = today--os.date("%x", os.time())
        tmp.Days30 = {}
        tmp.Days30[today] = false
        -- table.insert(tmp.Days30,today)
        return tmp
    end


    if days == nil then
        days = newDailyData()
    else
        if days.Days30[today] == nil then
            days.Days30[today] = false
        end
    end
    
end

function getDataFromDB(playerId,key)
    return nil
end

function saveDataToDB(playerId,key)
    
end

local dicDays = {}

Players.PlayerAdded:Connect(function(player)
    local data = getDataFromDB(player.UserId,dbKeyDays)
    data = processData(data)
    saveDataToDB(player.UserId,dbKeyDays)
    dicDays[player] = data
end)

Players.PlayerRemoving:Connect(function(player)
    saveDataToDB(player.UserId)
    dicDays[player] = nil
end)

local currentSecond = os.time()

game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
    if currentSecond == time then return end
    currentSecond = time

    --处理登录天数
    local date = os.time() / oneDaySeconds
    if today ~= date then
        today = date
        for player, data in dicDays do
            dicDays[player] = processData(data)
            -- task.wait(1)
        end
    end
end)

return module