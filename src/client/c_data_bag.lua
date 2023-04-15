local module = {}
-- local c_global = require(script.Parent.c_global)
local c2s_all_bag = _G.Remote.c2s_all_bag :: RemoteFunction
local dic = c2s_all_bag:InvokeServer()
print("bag: ",dic)

local s2c_bag_change = _G.Remote:WaitForChild("s2c_bag_change") :: RemoteEvent
local c2c_bag_change = _G.Remote:WaitForChild("c2c_bag_change") :: BindableEvent
s2c_bag_change.OnClientEvent:Connect(function(itemid)
    dic[itemid] = 1
    c2c_bag_change:Fire(itemid)
end)

function module.GetItemCount(itemid)
    return dic[itemid] or 0
end
module.Inited = true
return module