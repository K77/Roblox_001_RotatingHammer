local module = {}
local RunService = game:GetService("RunService")

module.isShow = false
module.asset = nil

function module.Show(flag:boolean, ...)
    module.isShow = flag
end

RunService.Stepped:Connect(function(time, deltaTime)
    if not module.isShow then return end
    
end)

return module