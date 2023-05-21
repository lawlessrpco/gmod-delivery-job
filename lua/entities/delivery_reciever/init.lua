AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/Humans/Group03m/Female_02.mdl")
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(bit.bor(CAP_ANIMATEDFACE, CAP_TURN_HEAD))
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()
	self:SetMaxYawSpeed(90)
end

function ENT:Use(ply)
	for k, v in pairs(ents.FindInSphere(self:GetPos(), 256)) do
		if v:GetClass() != "delivery_package" then continue end
		if v:GetTarget() != self then continue end
		hook.Call("Delivery:DeliveryCompleted", ply, v:GetName(), v:GetReward())
		return self:RewardPackage(v)
	end

	DarkRP.notify(ply, NOTIFY_GENERIC, 5, "Come back with a package for me :(")
end

function ENT:RewardPackage(package)
	package:RewardDeliveryMan()
end

function ENT:OnTakeDamage()
	return false
end
