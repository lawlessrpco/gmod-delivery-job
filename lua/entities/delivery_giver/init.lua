AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Initialize()
	self:SetModel("models/gman_high.mdl")
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
	if ply:getJobTable().delivery_man != true then
		DarkRP.notify(ply, NOTIFY_ERROR, 5, "You're not a delivery man!")
		return
	end

	if ply:GetNWBool("Delivery:IsDelivering", false) == true then
		DarkRP.notify(ply, NOTIFY_HINT, 5, "You can try again in " .. DELIV.Cooldown .. " seconds") -- this appears as the farthest down notification, so it looks better
		DarkRP.notify(ply, NOTIFY_ERROR, 5, "Guess you're not up to the delivery, I've taken the package back.")

		local current_package = ply:GetNWEntity("Delivery:PackageEntity")
		if IsValid(current_package) then
			hook.Call("Delivery:DeliveryEnded", ply, current_package:GetName(), current_package:GetReward())
			SafeRemoveEntity(current_package)
			ply:SetNWEntity("Delivery:PackageEntity", nil)
		end

		ply:SetNWInt("Delivery:Cooldown", CurTime() + DELIV.Cooldown)
		ply:SetNWBool("Delivery:IsDelivering", false)

	elseif ply:GetNWInt("Delivery:Cooldown", 0) > CurTime() then
		DarkRP.notify(ply, NOTIFY_ERROR, 5, "I'm not giving you another package that quickly, come back in " .. math.ceil(ply:GetNWInt("Delivery:Cooldown", 0) - CurTime()) .. " seconds.")
	else
		local deliver_to = table.Random(ents.FindByClass("delivery_reciever"))
		if !IsValid(deliver_to) then
			DarkRP.notify(ply, NOTIFY_ERROR, 5, "Noone is around to deliver this package to right now.")
			return
		end

		local package_config_index = math.random(#DELIV.Packages)
		local package_config = DELIV.Packages[package_config_index]

		local package = ents.Create("delivery_package")
		package:SetPos(self:GetPos() + (self:GetForward() * 50) + self:GetUp() * 50)
		package:SetDeliveryMan(ply)
		package:SetTarget(deliver_to)
		package:SetExpTime(CurTime() + DELIV.DeliveryGuarentee)

		-- {"Rocket Ammo", "models/Items/ammoCrate_Rockets.mdl", 500}
		package:SetName(package_config[1])
		package:SetModel(package_config[2])
		package:SetReward(package_config[3])

		-- Spawn it!
		package:Spawn()
		package:SetupPhys() -- without this the collisions are all fucked up

		-- Tell everyone whoose package this is
		ply:SetNWEntity("Delivery:PackageEntity", package)

		DarkRP.notify(ply, NOTIFY_GENERIC, 5, "Deliver this package and i'll reward you nicely. (You have " .. DELIV.DeliveryGuarentee .. " seconds to complete this task)")
		ply:SetNWBool("Delivery:IsDelivering", true)

		hook.Call("Delivery:DeliveryStarted", ply)
	end
end

function ENT:OnTakeDamage()
	return false
end
