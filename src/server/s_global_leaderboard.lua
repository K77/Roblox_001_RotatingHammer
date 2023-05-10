local module = {}
local DataStoreService = game:GetService("DataStoreService")
local DBGlobalExp = DataStoreService:GetOrderedDataStore("GlobalUserExp")
local dicData ={}


local function setGLobalExpToDB(player)
    if player == nil then return end
	local playerId = player.UserId
	-- if playerId <= 0 then return end
	local success, err = pcall(function()
		local key = tostring(playerId)
		DBGlobalExp:SetAsync(key,dicData[player])
	end)
	if not success then
		error(err)
	end
end



local needChangeMoney = {}

local function newUser(player,exp)
    local tmp = {}
    tmp.exp = 0 or exp
    tmp.name = player.displayName
    dicData[player] = tmp
end

game.Players.PlayerAdded:Connect(function(player)
	local Money = player:WaitForChild("leaderstats"):WaitForChild("coins")
	Money.Value = dicData[player].exp
	Money.Changed:Connect(function()
        dicData[player].exp = Money.Value
		if needChangeMoney[player.UserId] then return end
		needChangeMoney[player.UserId] = true
		-- wait(6)
		setGLobalExpToDB(player)
		needChangeMoney[player.UserId]  = nil
	end)
end)

game.Players.PlayerRemoving:Connect(function(player)
	setGLobalExpToDB(player)
    dicData[player] = nil
end)


return module












-- local sample = script:WaitForChild("Sample") --Our Sample frame
-- local sf = sg:WaitForChild("ScrollingFrame") --The scrolling frame
-- local ui = sf:WaitForChild("UI") --The UI list layout

-- local dataStoreService = game:GetService("DataStoreService")
-- --The data store service
-- local dataStore = dataStoreService:GetOrderedDataStore("Leaderboard")
-- --Get the data store with key "Leaderboard"

-- wait(10)
-- while true do
-- 	for i,plr in pairs(game.Players:GetChildren()) do--Loop through players
-- 		if plr.UserId>0 then--Prevent errors
-- 			local ps = game:GetService("PointsService")--PointsService
-- 			local w = ps:GetGamePointBalance(plr.UserId)--Get point balance
-- 			if w then
-- 				pcall(function()
-- 				--Wrap in a pcall so if Roblox is down, it won't error and break.
-- 					dataStore:UpdateAsync(plr.UserId,function(oldVal)
-- 				        --Set new value
-- 						return tonumber(w)
-- 					end)
-- 				end)
-- 			end
-- 		end
-- 	end    
-- 	local smallestFirst = false--false = 2 before 1, true = 1 before 2
--     local numberToShow = 100--Any number between 1-100, how many will be shown
--     local minValue = 1--Any numbers lower than this will be excluded
--     local maxValue = 10e30--(10^30), any numbers higher than this will be excluded
--     local pages = dataStore:GetSortedAsync(smallestFirst, numberToShow, minValue, maxValue)
--     --Get data
--     local top = pages:GetCurrentPage()--Get the first page
-- 	local data = {}--Store new data
-- 	for a,b in ipairs(top) do--Loop through data
-- 		local userid = b.key--User id
-- 		local points = b.value--Points
-- 		local username = "[Failed To Load]"--If it fails, we let them know
-- 		local s,e = pcall(function()
-- 		 username = game.Players:GetNameFromUserIdAsync(userid)--Get username
-- 		end)
-- 		if not s then--Something went wrong
-- 		   warn("Error getting name for "..userid..". Error: "..e)
-- 		end
-- 		local image = game.Players:GetUserThumbnailAsync(userid, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
-- 		--Make a image of them
-- 		table.insert(data,{username,points,image})--Put new data in new table
-- 	end
-- 	ui.Parent = script
-- 	sf:ClearAllChildren()--Remove old frames
-- 	ui.Parent = sf
-- 	for number,d in pairs(data) do--Loop through our new data
-- 		local name = d[1]
-- 		local val = d[2]
-- 		local image = d[3]
-- 		local color = Color3.new(1,1,1)--Default color
-- 		if number == 1 then
-- 			color = Color3.new(1,1,0)--1st place color
-- 		elseif number == 2 then
-- 			color = Color3.new(0.9,0.9,0.9)--2nd place color
-- 		elseif number == 3 then
-- 			color = Color3.fromRGB(166, 112, 0)--3rd place color
-- 		end
-- 		local new = sample:Clone()--Make a clone of the sample frame
-- 		new.Name = name--Set name for better recognition and debugging
--                 new.LayoutOrder = number--UIListLayout uses this to sort in the correct order
-- 		new.Image.Image = image--Set the image
-- 		new.Image.Place.Text = number--Set the place
-- 		new.Image.Place.TextColor3 = color--Set the place color (Gold = 1st)
-- 		new.PName.Text = name--Set the username
-- 		new.Value.Text = val--Set the amount of points
-- 		new.Value.TextColor3 = color--Set the place color (Gold = 1st)
-- 		new.PName.TextColor3 = color--Set the place color (Gold = 1st)
-- 		new.Parent = sf--Parent to scrolling frame
-- 	end
-- 	wait()
-- 	sf.CanvasSize = UDim2.new(0,0,0,ui.AbsoluteContentSize.Y)
-- 	--Give enough room for the frames to sit in
--         wait(120)
-- end