local MODULE = GAS.Logging:MODULE()
MODULE.Category = "Delivery System"
MODULE.Name = "Completed Deliveries"
MODULE.Colour = Color(30,183,243)


MODULE:Setup(function()
	MODULE:Hook("Delivery:DeliveryCompleted", "completed_delivery", function(ply, delivery_name, delivery_reward)
		MODULE:Log("{1} completed a delivery of {2} with a reward of {3}", GAS.Logging:FormatPlayer(actor), delivery_name, DarkRP.formatMoney(delivery_reward))
	end)
end)
