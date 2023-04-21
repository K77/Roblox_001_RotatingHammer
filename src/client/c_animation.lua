print("first require: ", script.Name)
local module = {}
local rotAnimation = "rbxassetid://13019768278"

local character = game:GetService("Players").LocalPlayer.Character
local humanoid = character:WaitForChild("Humanoid") :: Humanoid
local animator = humanoid:WaitForChild("Animator")
local animation = Instance.new("Animation",workspace)
animation.Name = "selfAnimation"
animation.AnimationId = rotAnimation
local animationTrack = animator:LoadAnimation(animation)


function module.onlyRot(player:Player)
    local animateScript = character:WaitForChild("Animate")
    animateScript.Enabled = false
    local animator = humanoid:WaitForChild("Animator")
    local animTracks = animator:GetPlayingAnimationTracks()

    for i,track in ipairs(animTracks) do
        track = track ::AnimationTrack
        if (track.Animation.AnimationId == rotAnimation) then continue end
        track:AdjustWeight(0,0)
        track:Stop(0)
        track.Animation:Destroy()
        track:Destroy()
    end
    animationTrack:Play(0,10)
end



function module.resetAnim(player:Player)
    animationTrack:Stop(0)
    local character = player.Character
    local animateScript = character:WaitForChild("Animate")
    animateScript.Enabled = true
end

return module