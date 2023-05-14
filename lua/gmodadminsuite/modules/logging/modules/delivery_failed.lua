local MODULE = GAS.Logging:MODULE()
MODULE.Category = "Delivery System"
MODULE.Name = "Ended Deliveries"
MODULE.Colour = Color(30,183,243)


MODULE:Setup(function()
	MODULE:Hook("Delivery:DeliveryEnded", "failed_delivery", function(ply, delivery_name, delivery_reward)
		MODULE:Log("{1} failed a delivery of {2} that would have gotten them {3}", GAS.Logging:FormatPlayer(actor), delivery_name, delivery_reward)
	end)
end)
