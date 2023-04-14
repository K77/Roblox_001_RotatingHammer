local module = {}
local RunService = game:GetService("RunService")
local uiTmp = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui'):WaitForChild("UI_Root"):WaitForChild("ui_weapon")
local ui:ScreenGui

module.isShow = false
module.asset = nil

function module.Show(flag:boolean, ...)
    module.isShow = flag
    if flag then
        ui = uiTmp:Clone()
        ui.Parent = uiTmp.Parent
        ui.Enabled = true
        local Btn_buy_ring = ui:WaitForChild("ImageBack"):WaitForChild("ImageLabel"):WaitForChild("TextButton") :: TextButton
        Btn_buy_ring.MouseButton1Click:Connect(function()
            print("btn click")
        end)
    else
        if ui then ui:Destroy() end
    end
end

RunService.Stepped:Connect(function(time, deltaTime)
    if not module.isShow then return end
    
end)

return module