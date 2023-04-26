local module = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)



local toolRotate = workspace.BattleToolsTmp.rotate
local toolLife = workspace.BattleToolsTmp.life
local toolMove = workspace.BattleToolsTmp.move
local toolWeapon = workspace.BattleToolsTmp.weapon
local toolRoot : Folder = workspace.Enemy
local arrToolTmp = {toolRotate,toolLife,toolWeapon,toolMove}

-- local function eatOneTool(player:Player,tool:Model)
--     if player == nil then return end
--     local humanoid = player.Character.Humanoid
--     if tool.Name == "rotate" then
--         player.countRotate.Value = player.countRotate.Value +1
--         if player.countRotate.Value > ConfServerGlobal.rotateToolMax then
--             player.countRotate.Value = ConfServerGlobal.rotateToolMax
--         end
--         -- humanoid.WalkSpeed = ConfServerGlobal.moveSpeed*(1+player.countShoe.Value*ConfServerGlobal.moveToolAdd)
--     elseif  tool.Name == "life" then
--         humanoid.Health = humanoid.Health+1
--         -- player.countLife.Value = player.countLife.Value +1
--     elseif  tool.Name == "move" then
--         player.countShoe.Value = player.countShoe.Value +1
--         if player.countShoe.Value > ConfServerGlobal.moveToolMax then
--             player.countShoe.Value = ConfServerGlobal.moveToolMax
--         end
--         humanoid.WalkSpeed = ConfServerGlobal.moveSpeed*(1+player.countShoe.Value*ConfServerGlobal.moveToolAdd)
--     elseif  tool.Name == "weapon" then
--         player.countWeapon.Value = player.countWeapon.Value +1
--         if player.countWeapon.Value > ConfServerGlobal.weaponToolMax then
--             player.countWeapon.Value = ConfServerGlobal.weaponToolMax
--         else
--             local scale = (player.countWeapon.Value *ConfServerGlobal.weaponToolAdd + 1)/
--                 ((player.countWeapon.Value - 1)*ConfServerGlobal.weaponToolAdd + 1)
--             player.Character.Weapon.PrimaryPart.Size = player.Character.Weapon.PrimaryPart.Size * scale
--         end
--     end

--     ConfServerGlobal.sound.Pick:Play()
--     tool:Destroy()
-- end


local dicEnemyTime = {}
local function creatOne()
    local posX = _G.util_random.getBetween(toolRotate:GetPivot().X,toolWeapon:GetPivot().X)
    local posZ = _G.util_random.getBetween(toolRotate:GetPivot().Z,toolWeapon:GetPivot().Z)
    local posY = toolRotate:GetPivot().Y
    local tmp : Model = workspace.WatchingPeople.Enemy:Clone()
    dicEnemyTime[tmp] = 0
    local humanoid = tmp.Humanoid :: Humanoid
    humanoid.MaxHealth = 3
    humanoid.Health = 3
    -- tmp.PrimaryPart.ParticleEmitter.Enabled = true
    tmp.Parent = toolRoot
    tmp:PivotTo(CFrame.new(posX,posY,posZ))
    -- tmp.PrimaryPart.Transparency = 0
    -- tmp.PrimaryPart.Touched:Connect(function(otherPart)
    --     local humanoid = otherPart.Parent:FindFirstChild("Humanoid") :: Humanoid
    --     if humanoid then
    --         local echar = humanoid.Parent --game.Players:GetPlayerFromCharacter()
    --         local player:Player = Players:GetPlayerFromCharacter(echar)
    --         eatOneTool(player,tmp)

    --     end
    -- end)
end 

local timePass = 0
local timeInterval = 3
local timeInterval1 = 300

local maxTool = 6
RunService.Stepped:Connect(function(time, deltaTime)
    local arr = toolRoot:GetChildren()
    -- local players = Players:GetPlayers()
    if #arr<=(maxTool) then
        timePass+=deltaTime
        if timePass >= timeInterval then
            timePass -= timeInterval
            creatOne()
        end
    else
        timePass = 0
    end
    
    for i = 1, #arr, 1 do
        local humanoid = arr[i].Humanoid
        dicEnemyTime[arr[i]] +=deltaTime
        if humanoid.Health <= 0 then
            task.wait(2)
            arr[i]:Destroy()
            return
        end
        if dicEnemyTime[arr[i]]>600 then
            arr[i]:Destroy()
            return
        end
    end


end)

return module