local module = {}

local toolRotate = workspace.BattleToolsTmp.rotate
local toolLife = workspace.BattleToolsTmp.life
local toolMove = workspace.BattleToolsTmp.move
local toolWeapon = workspace.BattleToolsTmp.weapon

local toolRoot : Folder = workspace.BattleToolsTmp

local arrToolTmp = {toolRotate,toolLife,toolWeapon,toolMove}

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local timePass = 0
local timeInterval = 1


-- for i = 1, 100, 1 do
--     -- print(math.random(3))
--     task.wait()
--     print(tostring(os.time()):reverse():sub(1, 6))
-- end

local function creatOneTool()
    local posX = _G.util_random.getBetween(toolRotate:GetPivot().X,toolWeapon:GetPivot().X)
    local posZ = _G.util_random.getBetween(toolRotate:GetPivot().Z,toolWeapon:GetPivot().Z)
    local posY = toolRotate:GetPivot().Y
    local tmp : Model = toolWeapon:Clone()
    tmp.Parent = toolRoot
    tmp:PivotTo(CFrame.new(posX,posY,posZ))
end 

RunService.Stepped:Connect(function(time, deltaTime)
    local arr = toolRoot:GetChildren()
    local players = Players:GetPlayers()
    local battleCount = 0
    for index, value in players do
        if value.boolInbattle then
            battleCount++
        end
    end
    if #arr<=10 then
        timePass+=deltaTime
        if timePass >= timeInterval then
            timePass -= timeInterval
            creatOneTool()
        end
    else
        timePass = 0
    end

end)

return module