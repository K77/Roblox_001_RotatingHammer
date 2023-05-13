local module = {}
local ConfServerGlobal= require(game:GetService("ReplicatedStorage").globalConf.ConfServerGlobal)

local RunService = game:GetService("RunService")
module.isShow = false
local Player = game:GetService("Players").LocalPlayer
local c2s_get_duration_info = game:GetService("ReplicatedStorage")._RojoShare.Remote.c2s_get_duration_info
local c2s_get_duration_reward = game:GetService("ReplicatedStorage")._RojoShare.Remote.c2s_get_duration_reward

module.info = c2s_get_duration_info:InvokeServer()
print("duration;" , module.info)

local ui,btn1,btn2,btn3
local function setBtnText()
    if btn3 == nil then return end
    if module.info.duration < 60 then
        btn1.Text = math.floor(module.info.duration)
    elseif table.find(module.info.rewards,60) then
        btn1.Text = "Receive"
        else
            btn1.Text = "Received"
    end
    if module.info.duration < 300 then
        btn2.Text = math.floor(module.info.duration)
    elseif table.find(module.info.rewards,300) then
        btn2.Text = "Receive"
        else
            btn2.Text = "Received"
    end
    if module.info.duration < 600 then
        btn3.Text = math.floor(module.info.duration)
    elseif table.find(module.info.rewards,600) then
        btn3.Text = "Receive"
        else
            btn3.Text = "Received"
    end
end
function module.Show(flag:boolean, ...)
    module.isShow = flag
    -- local arg = {...}
	if flag then
		local uiTmp = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("ui_dayDuration")
		ui = uiTmp:Clone()
        ui.Parent = uiTmp.Parent
        ui.Enabled = true

        module.info = c2s_get_duration_info:InvokeServer()

        btn1 = ui:WaitForChild("RewardsDetail"):WaitForChild("TextButton1") :: TextButton

        btn1.MouseButton1Click:Connect(function()
            module.info = c2s_get_duration_reward:InvokeServer(60)
            -- btn1.Text = "Received"
        end)

        btn2 = ui:WaitForChild("RewardsDetail"):WaitForChild("TextButton2") :: TextButton

        btn2.MouseButton1Click:Connect(function()
            module.info = c2s_get_duration_reward:InvokeServer(300)
            -- btn2.Text = "Received"
        end)

        btn3 = ui:WaitForChild("RewardsDetail"):WaitForChild("TextButton3") :: TextButton

        btn3.MouseButton1Click:Connect(function()
            module.info = c2s_get_duration_reward:InvokeServer(600)
            -- btn3.Text = "Received"
        end)

        local btn = ui:WaitForChild("RewardsDetail"):WaitForChild("BtnClose") ::GuiButton
        btn.MouseButton1Click:Connect(function()
            if ui then ui:Destroy() end
        end)
        setBtnText()
    else
        if ui then ui:Destroy() end
    end
end

RunService.Stepped:Connect(function(time, deltaTime)
    module.info.duration += deltaTime
    if not module.isShow then return end
    setBtnText()
end)

return module