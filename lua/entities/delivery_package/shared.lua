ENT.Type = "anim"
ENT.Base = "base_anim"

ENT.PrintName = "Package"
ENT.Category = "Delivery"
ENT.Author = "Lion"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

-- Setup some varialbes
function ENT:SetupDataTables()
    self:NetworkVar("Entity", 1, "DeliveryMan") -- The person who is suppose to be delivering the package
    self:NetworkVar("Entity", 2, "Target") -- The delivery target
    self:NetworkVar("Int", 3, "ExpTime") -- The time when the delivery was too late
    self:NetworkVar("String", 4, "Name") -- The name of the package
    self:NetworkVar("Int", 5, "Reward") -- The amount of money to reward to the player upon completion
end
