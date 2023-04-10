print("Hello world, from client!")

aa = 10
print("aa:",aa,bb)
-- for key, value in pairs(script) do
--     print(key,value)
-- end

local function newClass()
    local aaa = {}
    aaa.v1 = 1
    aaa.v2 = 2
    function aaa.func()
        print("aaaaaaa")
    end
    return aaa
end

local a1 = newClass()
local a2 = newClass()

print(a1.func == a2.func)

-- print(game:GetService("Players"):WaitForChild("LocalPlayer"):WaitForChild("Character"))
-- print(game:GetService("Players").LocalPlayer.Character.Humanoid)

local Players = game:GetService("Players")
local run = game:GetService("RunService")
run.RenderStepped:Connect(function(deltaTime)
    local player = Players.LocalPlayer
    local boolV = player:WaitForChild("boolInbattle")
    if boolV.Value then
        local newCF = CFrame.new(player.Character:GetPivot().Position) 
		local rot = player.Character:GetPivot().Rotation * CFrame.Angles(0,0.01,0)
        player.Character:PivotTo(newCF*rot)
    end
    
end)