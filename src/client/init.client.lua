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

print(game:GetService("Players"):WaitForChild("LocalPlayer"):WaitForChild("Character"))
-- print(game:GetService("Players").LocalPlayer.Character.Humanoid)