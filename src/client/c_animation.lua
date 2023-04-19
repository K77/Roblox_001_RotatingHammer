print("first require: ", script.Name)
local module = {}
local KeyframeSequenceProvider = game:GetService("KeyframeSequenceProvider")

local function clearAnimation(player:Player)
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid") :: Humanoid
    local animateScript = character:WaitForChild("Animate")
    animateScript.Enabled = false
    local animator = humanoid:WaitForChild("Animator")
    local animTracks = animator:GetPlayingAnimationTracks()

    for i,track in ipairs(animTracks) do
        track = track ::AnimationTrack
        print(track.Animation.AnimationId)
        track:AdjustWeight(0,0)
        track:Stop(0)
        track.Animation:Destroy()
        track:Destroy()
    end
end

local function playById(player:Player,id:string)
    local character = player.Character
    local humanoid = character:WaitForChild("Humanoid") :: Humanoid
    local animator = humanoid:WaitForChild("Animator")
    local animation = Instance.new("Animation",workspace)
    animation.Name = "selfAnimation"
    animation.AnimationId = id
    local animationTrack = animator:LoadAnimation(animation)
    animationTrack:Play(0,10)
end

local function playBySequence(player:Player,keyframeSequence:KeyframeSequence)
    local hashId = KeyframeSequenceProvider:RegisterKeyframeSequence(keyframeSequence)
	if hashId then
		local animation = Instance.new("Animation",workspace)
		animation.AnimationId = hashId
        local character = player.Character
        local humanoid = character:WaitForChild("Humanoid") :: Humanoid
        local animator = humanoid:WaitForChild("Animator")
        local animationTrack = animator:LoadAnimation(animation)
        animationTrack:Play(0,10)
	end
end

function module.clearAndPlay(player:Player, ani)
    if player == nil then
        player = game:GetService("Players").LocalPlayer
    end
    clearAnimation(player)
    local typeInput = typeof(ani)
    if typeInput == "string" then
        playById(player,ani)
    else
        print(typeInput)
        playBySequence(player,ani)
    end
end

function module.resetAnim(player:Player)
    clearAnimation(player)
    local character = player.Character
    local animateScript = character:WaitForChild("Animate")
    animateScript.Enabled = true
end

return module