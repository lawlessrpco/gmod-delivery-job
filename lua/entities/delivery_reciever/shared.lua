ENT.Type = "ai"
ENT.Base = "base_ai"
ENT.PrintName = "Delivery Reciever"
ENT.Category = "Delivery"
ENT.Author = "Lion"
ENT.Spawnable = true
ENT.AdminOnly = false

ENT.Title = "Delivery Target" -- The title above the man's head

function ENT:SetupDataTables()
    self:NetworkVar("Bool", 1, "ExpectingDelivery") -- Is the man expecting a delivery
    self:NetworkVar("Entity", 2, "Package") -- The package the man is expecting
    self:NetworkVar("Entity", 3 "DeliveryMan") -- The expected delivery man
end
