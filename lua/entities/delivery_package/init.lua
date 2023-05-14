
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

function ENT:Initialize()
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)

    self:SetupPhys()
end

function ENT:SetupPhys()
    local physObj = self:GetPhysicsObject()
    if not physObj:IsValid() then return end

    physObj:Wake()
end

function ENT:Use(ply)
    local reward_money = DarkRP.formatMoney(self:GetReward())

    ply:ChatPrint(string.format([[
    %s
    Delivery Man: %s
    Reward for Delivery: %s
    ]], self:GetName() or "dildo", self:GetDeliveryMan():Nick(), reward_money))
end

-- Auto remove the entity if we run out of time
function ENT:Think()
    -- Some failsafes
    if !IsValid(self:GetDeliveryMan()) then return self:StopDelivery() end
    if !IsValid(self:GetTarget()) then return self:StopDelivery() end
    if self:GetExpTime() <= CurTime() then return self:StopDelivery() end
end

-- Stop the delivery and reset the player
function ENT:StopDelivery()
    DarkRP.notify(self:GetDeliveryMan(), NOTIFY_ERROR, 5, "You failed to complete the delivery in time")

    -- Reset some things and restrict the player from delivering again
    self:ResetPlayer()

    self:Remove()
end

function ENT:ResetPlayer()
    self:GetDeliveryMan():SetNWInt("Delivery:Cooldown", CurTime() + DELIV.Cooldown)
    self:GetDeliveryMan():SetNWBool("Delivery:IsDelivering", false)
    self:GetDeliveryMan():SetNWEntity("Delivery:PackageEntity", nil)
end

function ENT:RewardDeliveryMan()
	local delivery_man = self:GetDeliveryMan()
	local reward = self:GetReward()
	local name = self:GetName()

	-- Give rewards
    self:ResetPlayer() -- stop the delivery
	delivery_man:addMoney(reward)
    DarkRP.notify(delivery_man, NOTIFY_GENERIC, 5, "Thanks, here's " .. DarkRP.formatMoney(reward) .. ", I really needed a(n) " .. name .. ".")

    self:Remove()
end
