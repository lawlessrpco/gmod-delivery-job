if SERVER then
    AddCSLuaFile("delivery/deliv_config.lua")
end
include("delivery/deliv_config.lua")

-- Setup some meta tables
local pMeta = getmetatable("Player")

-- Is the player a delivery man
function pMeta:IsDeliveryMan()
    return ply:getJobTable().delivery_man
end
