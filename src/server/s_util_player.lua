local module = {}

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
	humanoid.WalkSpeed = 6


	local animateScript = character:WaitForChild("Animate")

	animateScript.run.RunAnim.AnimationId = rotAnimation
	animateScript.walk.WalkAnim.AnimationId = rotAnimation
	animateScript.idle.Animation1.AnimationId = rotAnimation
	animateScript.idle.Animation2.AnimationId = rotAnimation
    animateScript.jump.JumpAnim.AnimationId = rotAnimation
end

return module