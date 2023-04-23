local module = {}
local Players = game:GetService("Players")
local s_player_behave = require(script.Parent.s_player_behave)
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)
local ServerStorage = game:GetService("ServerStorage")

game.Players.PlayerAdded:Connect(function(player:Player)
    player.CharacterAdded:Connect(function()
        local char = player.Character
        local humanoid = char:WaitForChild("Humanoid")
        humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
        local head = char:WaitForChild("Head")
        local headName = ServerStorage.HeadName:Clone()
        headName.Parent = head
        headName.Adornee = head
        headName.TextLabel.Text = player.Name
        print("asdfasdfasdfasdfasdfasdfasdfads")
    end)
    module.addToServer(player)
end)

local swordTouch = {}
local function resetPlayerValue(player:Player)
    player.battleStatus.Value = _G.EnumBattleStatus.outBattle
    player.countWeapon.Value = 0
    player.countShoe.Value = 0
    player.countRotate.Value = 0

    local humanoid = player.character:WaitForChild("Humanoid")
    humanoid.JumpPower = 0
    humanoid.WalkSpeed = ConfServerGlobal.defaultMoveSpeed
    humanoid.MaxHealth = ConfServerGlobal.startHealth
    humanoid.Health = ConfServerGlobal.startHealth
    player.Character.Humanoid.AutoRotate = true

    player.Character:PivotTo(workspace.SafeZone.SpawnLocation:GetPivot())
    if swordTouch[player] then
        swordTouch[player]:Disconnect()
    end
    if player.Character:FindFirstChild("Weapon") then
        player.Character.Weapon:Destroy()
    end
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
        resetPlayerValue(player)
        local humanoid = character:WaitForChild("Humanoid")
        humanoid.Died:Connect(function()
            task.wait(2)
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
    character.Humanoid.WalkSpeed = ConfServerGlobal.moveSpeed
    character.Humanoid.MaxHealth = ConfServerGlobal.startHealth
    character.Humanoid.Health = ConfServerGlobal.startHealth
    character.Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOn

    local hrp = character:WaitForChild("HumanoidRootPart")
        -- local sword = workspace.FightZone.Model1:Clone() :: Model -- game:GetService("Workspace").iron_sword:Clone()
        local sword = ConfServerGlobal.equip[player.Equip.Value].model:Clone()
        sword.PrimaryPart.Anchored = false
		sword.Parent = character
		sword:PivotTo(character:GetPivot() * CFrame.Angles(0,math.rad(-90),0))
		-- local att = Instance.new("Attachment",sword.PrimaryPart) 
		local weld = Instance.new("WeldConstraint",sword.PrimaryPart)
		weld.Part0 = sword.PrimaryPart
		weld.Part1 = character:WaitForChild("HumanoidRootPart")
        sword.Name = "Weapon"

        s_player_behave.ChangeAnimationRot(player)
        swordTouch[player] = sword.PrimaryPart.Touched:Connect(function(otherPart)
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
    resetPlayerValue(player)
end

return module