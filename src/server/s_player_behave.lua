local module = {}
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)

local rotAnimation = "rbxassetid://13019768278"
-- local runAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"
-- local rotAnimation = "rbxassetid://13019768278"


function module.ChangeAnimationRot(player : Player)
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid") :: Humanoid
	local animateScript = character:WaitForChild("Animate")

	animateScript.run.RunAnim.AnimationId = rotAnimation
	animateScript.walk.WalkAnim.AnimationId = rotAnimation
	animateScript.idle.Animation1.AnimationId = rotAnimation
	animateScript.idle.Animation2.AnimationId = rotAnimation
    animateScript.jump.JumpAnim.AnimationId = rotAnimation
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
		if pHrp and eHrp and not hurting[eHrp] then

			hurting[eHrp] = true
			echar.Humanoid.PlatformStand = true
            echar.Humanoid:TakeDamage(1)
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
			local kickAnimation = Instance.new("Animation")
			kickAnimation.AnimationId = "rbxassetid://12974134386"
            local kickAnimationTrack = animator:LoadAnimation(kickAnimation)
			kickAnimationTrack:Play()
			print("stand~~~~~~~~~~~~~~~~~~")
            task.wait(3)

			hurting[eHrp] = nil
			echar.Humanoid.PlatformStand = false
			kickAnimationTrack:Stop()
		end
	end
end


return module