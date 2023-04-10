local module = {}
local Players = game:GetService("Players")
local s_util_player = require(script.Parent.s_util_player)
local ConfServerGlobal= require(game:GetService("ServerStorage").conf.ConfServerGlobal)
local RunService = game:GetService("RunService")

-- RunService.Stepped:Connect(function(_time,delta)
--     for i,player in pairs(Players:GetPlayers()) do
--     if player.Character  and player.boolInbattle.Value then
--         local newCF = CFrame.new(player.Character:GetPivot().Position) 
-- 		local rot = player.Character:GetPivot().Rotation * CFrame.Angles(0,ConfServerGlobal.rotateSpeed,0)
--         -- task.wait()
--         player.Character:PivotTo(newCF*rot)
--     end
--     end
	
-- end)

-- local Players = game:GetService("Players")
game.Players.PlayerAdded:Connect(function(player)
    module.addToServer(player)
end)

function module.addToServer(player:Player)
    local inbattle = Instance.new("BoolValue",player)
    inbattle.Value = false
    inbattle.Name = "boolInbattle"
    player.CharacterAdded:Connect(function(character)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            module.goOutBattle(player)
        end)
        
    end)
end

function module.removeFromServer(player:Player)
    
end
function module.goInBattle(player:Player)
    player.boolInbattle.Value = true
    player.Character.Humanoid.JumpPower = 7
    player.Character.Humanoid.Jump = true
    player.Character.Humanoid.AutoRotate = false
     local character = player.Character
    character:PivotTo(workspace.FightZone.Center:GetPivot())

    local hrp = character:WaitForChild("HumanoidRootPart")
        local sword = workspace.FightZone.Model:Clone() :: Model -- game:GetService("Workspace").iron_sword:Clone()
        sword.PrimaryPart.Anchored = false
		sword.Parent = character
		sword:PivotTo(character:GetPivot())
		-- local att = Instance.new("Attachment",sword.PrimaryPart) 
		local weld = Instance.new("WeldConstraint",sword.PrimaryPart)
		weld.Part0 = sword.PrimaryPart
		weld.Part1 = character:WaitForChild("HumanoidRootPart")
        sword.Name = "Weapon"

        s_util_player.ChangePoseRot(player)

        wait(1)
        
        -- player.Character.Humanoid.PlatformStand = true
        -- wait()
        -- player.Character.Humanoid.PlatformStand = false


    -- 13019768278
    local att = Instance.new("Attachment",hrp)
    local rot = Instance.new("AngularVelocity",hrp)
    rot.Attachment0 = att
    rot.AngularVelocity = Vector3.new(1,1,1)
    rot.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
end

function module.goOutBattle(player:Player)
    player.boolInbattle.Value = false
    player.Character:PivotTo(workspace.SafeZone.SpawnLocation:GetPivot())
    player.CharacterAppearanceId = player.UserId
    player:LoadCharacter()
end


return module