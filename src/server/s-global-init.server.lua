local RunService = game:GetService("RunService")
Players = game:GetService("Players")
local ConfServerGlobal= require(game:GetService("ServerStorage").conf.ConfServerGlobal)

RunService.Stepped:Connect(function(_time,delta)
    for i,player in pairs(Players:GetPlayers()) do
    if player.Character and player.Character.Model then
        local newCF = CFrame.new(player.Character:GetPivot().Position) 
			local rot = player.Character.Model:GetPivot().Rotation * CFrame.Angles(0,ConfServerGlobal.rotateSpeed,0)
        player.Character.Model:PivotTo(newCF*rot)
		--player.Character:PivotTo(newCF*rot)
    end
    end
	
end)
local hurting = {}


local function knockback(pchar,echar)
	if pchar and echar then
		local pHrp = pchar:FindFirstChild("HumanoidRootPart")
		local eHrp = echar:FindFirstChild("HumanoidRootPart")
		if pHrp and eHrp and not hurting[eHrp] then

			hurting[eHrp] = true
			echar.Humanoid.PlatformStand = true

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

local dic = {}
game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(c)
		local humanoid = c:WaitForChild("Humanoid") :: Humanoid
		humanoid.MaxHealth = ConfServerGlobal.startHealth
		humanoid.Health = ConfServerGlobal.startHealth
        local stick = game:GetService("Workspace"):WaitForChild("FightZone"):WaitForChild("Model"):Clone()
        -- local aa = game:GetService("Players").LocalPlayer:WaitForChild("Character")
        -- stick.Parent = player.Character.Humanoid
        stick.Parent = c--:WaitForChild("Humanoid")
        dic[player] = stick
        stick.PrimaryPart.Touched:Connect(function(otherPart)
            local humanoid = otherPart.Parent:FindFirstChild("Humanoid") :: Humanoid
            if humanoid then
                local echar = humanoid.Parent --game.Players:GetPlayerFromCharacter()
                if echar == player.Character then return end

                knockback(player.Character,echar)

                print("otherPart: ",otherPart.Name)
            end
        end)
        -- player:SetAttribute("stick",stick)
        -- player.stick = stick
        -- print(player.UserId)
        print(player.UserId,player.Character.Model.Name)

    end)

end)





-- 12974134386