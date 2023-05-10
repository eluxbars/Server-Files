HVCTips = 
{ 
	"You can access your inventory with (L) or our Radial menu!",
    "You can lock your vehicle using (,)",
    "You can support HVC by donating at: https://store.hvc.city/",
    "You can access our forums at https://hvcforums.com/",
    "If you have any issues please make sure to /calladmin and specify your reason in the ticket.",
    "Remember to stay in character at all times unless a staff member is present.",
    "Make sure to check out the server rules on the forums at https://hvcforums.com/",
}


Citizen.CreateThread(function()
	Wait(100000)
	while true do
		math.randomseed(GetGameTimer())
		num = math.random(1,#HVCTips)
		num = math.random(1,#HVCTips)
		num = math.random(1,#HVCTips)
		TriggerEvent('chatMessage', "[HVC]", {255, 51, 51}, "" .. HVCTips[num], "ooc")
		Wait(600000)
	end
end)



