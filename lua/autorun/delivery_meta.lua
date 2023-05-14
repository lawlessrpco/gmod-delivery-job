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

-- Draw the delivery position
if CLIENT then
    surface.CreateFont("Delivery:PositionNotification", {
        font = "Arial",
        size = ScreenScale(10),
        weight = 500,
    })
    
    hook.Add("HUDPaint", "Delivery:HUDPaint", function()
        local ply = LocalPlayer()
        if !ply:GetNWBool("Delivery:IsDelivering", false) == true then return end

        local package = ply:GetNWEntity("Delivery:PackageEntity", nil)
        if !IsValid(package) then return end

        local deliver_to = package:GetTarget()
        if !IsValid(deliver_to) then return end

        local packagepos = package:GetPos():ToScreen()
        local deliverpos = deliver_to:GetPos():ToScreen()

        -- If it's on the screen
        if packagepos.x >= 0 and packagepos.x <= ScrW() and packagepos.y >= 0 and packagepos.y <= ScrH() and LocalPlayer():GetPos():Distance(package:GetPos()) >= 400 then
            draw.SimpleText("Package", "Delivery:PositionNotification", packagepos.x, packagepos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        if deliverpos.x >= 0 and deliverpos.x <= ScrW() and deliverpos.y >= 0 and deliverpos.y <= ScrH() and LocalPlayer():GetPos():Distance(deliver_to:GetPos()) >= 400 then
            draw.SimpleText("Delivery Target", "Delivery:PositionNotification", deliverpos.x, deliverpos.y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end)
end
