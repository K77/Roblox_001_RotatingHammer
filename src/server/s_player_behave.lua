local module = {}
local Players = game:GetService("Players")
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)

-- local rotAnimation = "rbxassetid://13019768278"
-- local runAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"


function module.ChangeAnimationRot(player : Player)
    -- local character = player.Character
    -- local humanoid = character:WaitForChild("Humanoid") :: Humanoid
	-- local animateScript = character:WaitForChild("Animate")
	-- animateScript.Enabled = false

	-- local animator = humanoid:WaitForChild("Animator")
	-- local animTracks = animator:GetPlayingAnimationTracks()

	-- for i,track in ipairs(animTracks) do
	-- 	track = track ::AnimationTrack
	-- 	print(track.Animation.AnimationId)
	-- 	track:AdjustWeight(0,0)
	-- 	track:Stop(0)
	-- 	track.Animation:Destroy()
	-- 	track:Destroy()
	-- end
	
	-- local kickAnimation = Instance.new("Animation",workspace)
	-- kickAnimation.AnimationId = rotAnimation
	-- local kickAnimationTrack = animator:LoadAnimation(kickAnimation)
	-- kickAnimationTrack:Play(0,10)
	-- animTracks = animator:GetPlayingAnimationTracks()

	-- for i,track in ipairs(animTracks) do
	-- 	print(track.Animation.AnimationId)
	-- end

	-- animateScript.run.RunAnim.AnimationId = rotAnimation
	-- animateScript.walk.WalkAnim.AnimationId = rotAnimation
	-- animateScript.idle.Animation1.AnimationId = rotAnimation
	-- animateScript.idle.Animation2.AnimationId = rotAnimation
    -- animateScript.jump.JumpAnim.AnimationId = rotAnimation
end

function module.resetAnimation(player : Player)
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid") :: Humanoid
	humanoid.WalkSpeed = 6

	local animateScript = character:WaitForChild("Animate")

	animateScript.run.RunAnim.AnimationId = rotAnimation
	animateScript.walk.WalkAnim.AnimationId = rotAnimation
	animateScript.idle.Animation1.AnimationId = rotAnimation
	animateScript.idle.Animation2.AnimationId = rotAnimation
    animateScript.jump.JumpAnim.AnimationId = rotAnimation
end















local hurting = {}
function module.knockback(pchar,echar)
	if pchar and echar then
		local pHrp = pchar:FindFirstChild("HumanoidRootPart")
		local eHrp = echar:FindFirstChild("HumanoidRootPart")
		if pHrp and eHrp then
			local ePlayer = Players:GetPlayerFromCharacter(echar)
			local pPlayer = Players:GetPlayerFromCharacter(pchar)

			if hurting[pPlayer] then return end

			if ePlayer then
				if hurting[ePlayer] then return end
				hurting[ePlayer] = true
			end

			echar.Humanoid:TakeDamage(ConfServerGlobal.hitDamage)

			local player = Players:GetPlayerFromCharacter(pchar)
			local coins = player:WaitForChild("leaderstats"):WaitForChild("coins") :: IntValue
			if echar.Humanoid.Health <=0 then
				coins.Value = coins.Value+1
				ConfServerGlobal.sound.Death1:Play()
			else
				ConfServerGlobal.sound.Hited:Play()
			end
			local forceField = Instance.new("ForceField",echar)
			forceField.Visible = true
			print("echar.Humanoid.Health: ",echar.Humanoid.Health)
			
			
			-- coins.Value = coins.Value+1

			local dir = (eHrp.Position -pHrp.Position).Unit
			local force = Instance.new("BodyVelocity", eHrp)
			force.MaxForce = Vector3.one * math.huge
			force.Velocity = (dir ).Unit * ConfServerGlobal.hitPower
			game.Debris:AddItem(force,0.25)
			-- echar.Humanoid.PlatformStand = true
			-- local att = Instance.new("Attachment",eHrp)
			-- local force = Instance.new("VectorForce",eHrp)
			-- -- local humanoid = echar:FindFirstChild("Humanoid")
			
			-- --force
			-- force.Attachment0 = att
			-- force.Force = (dir + Vector3.new(0,0.1,0)).Unit * ConfServerGlobal.hitPower
			-- force.RelativeTo = Enum.ActuatorRelativeTo.World
			
			-- -- local rot = Instance.new("AngularVelocity",eHrp)
			-- -- rot.Attachment0 = att
			-- -- rot.AngularVelocity = Vector3.new(1,1,1)*40
			-- -- rot.RelativeTo = Enum.ActuatorRelativeTo.Attachment0
			-- game.Debris:AddItem(force, .1)
			-- -- game.Debris:AddItem(rot, .1)
			-- game.Debris:AddItem(att, .1)
			
			-- local animator = humanoid:WaitForChild("Animator")
			-- local kickAnimation = Instance.new("Animation")
			-- kickAnimation.AnimationId = "rbxassetid://12974134386"
            -- local kickAnimationTrack = animator:LoadAnimation(kickAnimation)
			-- kickAnimationTrack:Play()
			ConfServerGlobal.sound.Swish:Play()

            task.wait(2)

			if ePlayer then hurting[ePlayer] = nil end
			
			forceField:Destroy()
			-- echar.Humanoid.PlatformStand = false
			-- kickAnimationTrack:Stop()
		end
	end
end


return module