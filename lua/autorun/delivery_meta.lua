if SERVER then
    AddCSLuaFile("delivery/deliv_config.lua")
end
include("delivery/deliv_config.lua")

-- Setup some meta tables
local pMeta = getmetatable("Player")

-- Setup some base variables
function pMeta:SetupDeliveryDefaults()
    if SERVER then
        self:SetNWBool("Delivery::IsDeliveringPackage", false) -- is the player currently delivering a package
    end
end

-- Is the player a delivery man
function pMeta:IsDeliveryMan()
    return ply:getJobTable().delivery_man
end
