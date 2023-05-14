DELIV = DELIV or {}

-- To add a delivery man job add
    -- delivery_man = true
-- to the job creation script

-- How long the NPC waits until it gets a new package
-- Is per NPC
DELIV.Cooldown = 10

-- How long the player has to deliver the package
DELIV.DeliveryGuarentee = 30

-- Different package types
DELIV.Packages = {
    -- {"name", "model", $reward$}
    {"Shipment of Rocket Ammo", "models/Items/item_item_crate.mdl", 2000},
    {"Shipment of Plastic Bags", "models/Items/item_item_crate.mdl", 1500},
    {"Shipment of Completely Legal Tender", "models/props_c17/BriefCase001a.mdl", 1256},
    {"NASA Proprietary Rocket Thruster", "models/xqm/afterburner1.mdl", 5000}
}
