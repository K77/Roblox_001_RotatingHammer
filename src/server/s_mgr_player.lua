local module = {}
local Players = game:GetService("Players")
local s_util_player = require(script.Parent.s_util_player)
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)
local RunService = game:GetService("RunService")

-- RunService.Stepped:Connect(function(_time,delta)
--     for i,player in pairs(Players:GetPlayers()) do
--     if player.Character  and player.boolInbattle.Value then
--         local newCF = CFrame.new(player.Character:GetPivot().Position) 
-- 		local rot = player.Character:GetPivot().Rotation * CFrame.Angles(0,ConfServerGlobal.rotateSpeed,0)
--         task.wait()
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
local hurting = {}
local function knockback(pchar,echar)
	if pchar and echar then
		local pHrp = pchar:FindFirstChild("HumanoidRootPart")
		local eHrp = echar:FindFirstChild("HumanoidRootPart")
		if pHrp and eHrp and not hurting[eHrp] then

			hurting[eHrp] = true
			echar.Humanoid.PlatformStand = true
            echar.Humanoid:TakeDamage(1000)
			local dir = (eHrp.Position -pHrp.Position).Unit
			local att = Instance.new("Attachment",eHrp)
			local force = Instance.new("VectorForce",eHrp)
			local humanoid = echar:FindFirstChild("Humanoid")
			humanoid:TakeDamage(ConfServerGlobal.hitDamage)
			--force
			force.Attachment0 = att
			force.Force = (dir + Vector3.new(0,1,0)).Unit * ConfServerGlobal.hitPower
			force.RelativeTo = Enum.ActuatorRelativeTo.World
			
			local rot = Instance.new("AngularVelocity",eHrp)
			rot.Attachment0 = att
			rot.AngularVelocity = Vector3.new(1,1,1)*40
			rot.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			game.Debris:AddItem(force, .1)
			game.Debris:AddItem(rot, .1)
			game.Debris:AddItem(att, .1)
			
			local animator = humanoid:WaitForChild("Animator")


			-- Create a new "Animation" instance and assign an animation asset ID

			local kickAnimation = Instance.new("Animation")

			kickAnimation.AnimationId = "rbxassetid://12974134386"


			-- Load the animation onto the animator

			local kickAnimationTrack = animator:LoadAnimation(kickAnimation)


			-- Play the animation track

			kickAnimationTrack:Play()


			
			wait(3)
			print("stand~~~~~~~~~~~~~~~~~~")
			echar.Humanoid.PlatformStand = false
			hurting[eHrp] = nil
			kickAnimationTrack:Stop()

		end
	end
end

function module.goInBattle(player:Player)
    player.boolInbattle.Value = true
    player.Character.Humanoid.JumpPower = 11
    player.Character.Humanoid.Jump = true
    player.Character.Humanoid.AutoRotate = false
     local character = player.Character
    character:PivotTo(workspace.FightZone.Center:GetPivot())

    local hrp = character:WaitForChild("HumanoidRootPart")
        local sword = workspace.FightZone.Model:Clone() :: Model -- game:GetService("Workspace").iron_sword:Clone()
        sword.PrimaryPart.Anchored = false
		sword.Parent = character
		sword:PivotTo(character:GetPivot() * CFrame.Angles(0,math.rad(-90),0))
		-- local att = Instance.new("Attachment",sword.PrimaryPart) 
		local weld = Instance.new("WeldConstraint",sword.PrimaryPart)
		weld.Part0 = sword.PrimaryPart
		weld.Part1 = character:WaitForChild("HumanoidRootPart")
        sword.Name = "Weapon"

        s_util_player.ChangeAnimationRot(player)

            sword.PrimaryPart.Touched:Connect(function(otherPart)
            local humanoid = otherPart.Parent:FindFirstChild("Humanoid") :: Humanoid
            if humanoid then
                local echar = humanoid.Parent --game.Players:GetPlayerFromCharacter()
                if echar == player.Character then return end

                knockback(player.Character,echar)

                print("otherPart: ",otherPart.Name)
            end
        end)

        
        -- player.Character.Humanoid.PlatformStand = true
        -- wait()
        -- player.Character.Humanoid.PlatformStand = false


    -- 13019768278
    -- local att = Instance.new("Attachment",hrp)
    -- local rot = Instance.new("AngularVelocity",hrp)
    -- rot.Attachment0 = att
    -- rot.AngularVelocity = Vector3.new(1,1,1)
    -- rot.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
end

function module.goOutBattle(player:Player)
    player.boolInbattle.Value = false
    player.Character:PivotTo(workspace.SafeZone.SpawnLocation:GetPivot())
    player.CharacterAppearanceId = player.UserId
    task.wait(5)
    player:LoadCharacter()
end


return module