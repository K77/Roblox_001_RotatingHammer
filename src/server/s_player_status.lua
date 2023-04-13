local module = {}
local Players = game:GetService("Players")
local s_player_behave = require(script.Parent.s_player_behave)
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)


game.Players.PlayerAdded:Connect(function(player)
    module.addToServer(player)
end)

local function resetPlayerValue(player:Player)
    player.battleStatus.Value = _G.EnumBattleStatus.outBattle
    player.countWeapon.Value = 0
    player.countShoe.Value = 0
    player.countRotate.Value = 0

end

function module.addToServer(player:Player)
    -- local inbattle = Instance.new("BoolValue",player)
    local battleStatus = Instance.new("IntValue",player)
    battleStatus.Name = "battleStatus"

    local countWeapon = Instance.new("IntValue",player)
    countWeapon.Name = "countWeapon"

    local countShoe = Instance.new("IntValue",player)
    countShoe.Name = "countShoe"

    local countRotate = Instance.new("IntValue",player)
    countRotate.Name = "countRotate"

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
    player.battleStatus.Value = _G.EnumBattleStatus.inBattle
    print("player.battleStatus.Value",_G.EnumBattleStatus.inbattle,player.battleStatus.Value)
    player.Character.Humanoid.JumpPower = 0
    player.Character.Humanoid.Jump = true
    player.Character.Humanoid.AutoRotate = false
    local character = player.Character
    character:PivotTo(workspace.FightZone.Center:GetPivot())
    character.Humanoid.WalkSpeed = 6

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

        s_player_behave.ChangeAnimationRot(player)
        sword.PrimaryPart.Touched:Connect(function(otherPart)
        local humanoid = otherPart.Parent:FindFirstChild("Humanoid") :: Humanoid
        if humanoid then
            local echar = humanoid.Parent --game.Players:GetPlayerFromCharacter()
            if echar == player.Character then return end
            s_player_behave.knockback(player.Character,echar)
            print("otherPart: ",otherPart.Name)
        end
        end)

end

function module.goOutBattle(player:Player)
    player.battleStatus.Value = _G.EnumBattleStatus.outBattle
    player.Character:PivotTo(workspace.SafeZone.SpawnLocation:GetPivot())
    player.CharacterAppearanceId = player.UserId
    task.wait(1)
    player:LoadCharacter()
end


return module