local model ={}
local players = game:GetService("Players")
local DataStoreService = game:GetService("DataStoreService")
local DBGlobalExp = DataStoreService:GetOrderedDataStore("GlobalUserExp")
local arrUINames = {}
local arrUIExp = {}
-- function initUI()
    for i = 1, 10, 1 do
        table.insert(arrUINames,workspace.SafeZone.TimePlayedLeaderboard.Model.ScoreBlock.SurfaceGui.Names["Name"..i])
    end
    for i = 1, 10, 1 do
        table.insert(arrUIExp,workspace.SafeZone.TimePlayedLeaderboard.Model.ScoreBlock.SurfaceGui.Score["Score"..i])
    end
-- end

local function setGLobalExpToDB(player)
    if player == nil then return end
	local playerId = player.UserId
	-- if playerId <= 0 then return end
	local success, err = pcall(function()
		local key = player.Name
		DBGlobalExp:SetAsync(key,player:WaitForChild("leaderstats"):WaitForChild("coins").Value)
	end)
	if not success then
		error(err)
	end
end

local dicToSave = {}

players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder",player)
    leaderstats.Name = "leaderstats"

    local coins = Instance.new("IntValue",leaderstats)
    coins.Name = "coins"
    coins.Changed:Connect(function()
        if dicToSave[player] then return end
        dicToSave[player] = true
        task.wait(10)
        setGLobalExpToDB(player)
	end)
end)

local refreshInterval = 60
local tmpDuration = refreshInterval
local topTen 
local function refresh()
    local isAscending = false
	local pageSize = 10
	local pages = DBGlobalExp:GetSortedAsync(isAscending, pageSize)
	topTen = pages:GetCurrentPage()
    local ind = 1
	for rank, data in ipairs(topTen) do
		local name = data.key
		local points = data.value
        arrUINames[ind].Text = name
        arrUIExp[ind].Text = points
        ind += 1
		print(name .. " is ranked #" .. rank .. " with " .. points .. "points")
	end
end

game:GetService("RunService").Stepped:Connect(function(time, deltaTime)
    tmpDuration+=deltaTime
    if tmpDuration > refreshInterval then
        tmpDuration -= refreshInterval
        refresh()
    end
end)


return model