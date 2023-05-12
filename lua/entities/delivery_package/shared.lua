ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Package"
ENT.Category = "Delivery"
ENT.Author = "Lion"
ENT.Spawnable = true
ENT.AdminOnly = false

-- Setup some varialbes
function ENT:SetupDataTables()
    self:NetworkVar("Entity", 1, "DeliveryMan") -- The person who is suppose to be deliverying the package
    self:NetworkVar("Entity", 2, "Target") -- The delivery target
    self:NetworkVar("Int", 3, "ExpTime") -- The time when the delivery was too late
end
