local module = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)



local toolRotate = workspace.BattleToolsTmp.rotate
local toolLife = workspace.BattleToolsTmp.life
local toolMove = workspace.BattleToolsTmp.move
local toolWeapon = workspace.BattleToolsTmp.weapon
local toolRoot : Folder = workspace.BattleToolsTmp
local arrToolTmp = {toolRotate,toolLife,toolWeapon,toolMove}

local function eatOneTool(player:Player,tool:Model)
    local humanoid = player.Character.Humanoid
    if tool.Name == "rotate" then
        player.countRotate.Value = player.countRotate.Value +1
        if player.countRotate.Value > ConfServerGlobal.rotateToolMax then
            player.countRotate.Value = ConfServerGlobal.rotateToolMax
        end
        -- humanoid.WalkSpeed = ConfServerGlobal.moveSpeed*(1+player.countShoe.Value*ConfServerGlobal.moveToolAdd)
    elseif  tool.Name == "life" then
        humanoid.Health = humanoid.Health+1
        -- player.countLife.Value = player.countLife.Value +1
    elseif  tool.Name == "move" then
        player.countShoe.Value = player.countShoe.Value +1
        if player.countShoe.Value > ConfServerGlobal.moveToolMax then
            player.countShoe.Value = ConfServerGlobal.moveToolMax
        end
        humanoid.WalkSpeed = ConfServerGlobal.moveSpeed*(1+player.countShoe.Value*ConfServerGlobal.moveToolAdd)
    elseif  tool.Name == "weapon" then
        player.countWeapon.Value = player.countWeapon.Value +1
    end
    tool:Destroy()
end

local function creatOneTool()
    local posX = _G.util_random.getBetween(toolRotate:GetPivot().X,toolWeapon:GetPivot().X)
    local posZ = _G.util_random.getBetween(toolRotate:GetPivot().Z,toolWeapon:GetPivot().Z)
    local posY = toolRotate:GetPivot().Y
    local ind = math.random(4)
    local tmp : Model = arrToolTmp[ind]:Clone()
    tmp.Parent = toolRoot
    tmp:PivotTo(CFrame.new(posX,posY,posZ))
    tmp.PrimaryPart.Transparency = 0
    tmp.PrimaryPart.Touched:Connect(function(otherPart)
        local humanoid = otherPart.Parent:FindFirstChild("Humanoid") :: Humanoid
        if humanoid then
            local echar = humanoid.Parent --game.Players:GetPlayerFromCharacter()
            local player:Player = Players:GetPlayerFromCharacter(echar)
            eatOneTool(player,tmp)

        end
    end)
end 

local timePass = 0
local timeInterval = 1
local maxTool = 5
RunService.Stepped:Connect(function(time, deltaTime)
    local arr = toolRoot:GetChildren()
    local players = Players:GetPlayers()
    -- local battleCount = 0
    -- for index, value in players do
    --     if value.boolInbattle then
    --         battleCount = battleCount+1
    --     end
    -- end
    if #arr<=(3+maxTool) then
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