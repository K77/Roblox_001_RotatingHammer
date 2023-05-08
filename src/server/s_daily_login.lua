local module = {}
local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDailyLogin")

local Players = game:GetService("Players")
local oneDaySeconds = 60*60*25
local keyDays = "keyDays"
local keyDuration = "keyDuration"
local today = os.time() / oneDaySeconds

function processDays(days)
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
local dicDuration = {}

Players.PlayerAdded:Connect(function(player)
    local data = getDataFromDB(player.UserId,keyDays)
    data = processDays(data)
    saveDataToDB(player.UserId,keyDays)
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

    for player, value in dicDuration do
        dicDuration[player] = value+1
    end

    --处理登录天数
    local date = os.time() / oneDaySeconds
    if today ~= date then
        today = date
        for player, data in dicDays do
            dicDays[player] = processDays(data)
            -- task.wait(1)
        end
    end
end)

return module