local module = {}
local DataStoreService = game:GetService("DataStoreService")
local PlayerDataStore = DataStoreService:GetDataStore("PlayerDailyLogin")

local Players = game:GetService("Players")
local oneDaySeconds = 60*60*25

function newDailyData()
    local tmp = {}
    tmp.CreateDay = os.time() / oneDaySeconds--os.date("%x", os.time())
    print("11111111111111111111111",tmp.CreateDay)
    return tmp
end

function getDataFromDB(playerId)
    return nil
end

function saveDataToDB(playerId)
    
end

local dic = {}

Players.PlayerAdded:Connect(function(player)
    local data = getDataFromDB(player.UserId)
    if data == nil then data = newDailyData() end
    dic[player] = data
end)

Players.PlayerRemoving:Connect(function(player)
    saveDataToDB(player.UserId)
    dic[player] = nil
end)

local currentSecond = os.time()
game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
    
end)

return module