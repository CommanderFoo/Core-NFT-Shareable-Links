local function DisableCrouch(player)
	print(1)
	player.isCrouchEnabled = false
end

local function EnableCrouch(player)
	player.isCrouchEnabled = true
end

Events.ConnectForPlayer("DisableCrouch", DisableCrouch)
Events.ConnectForPlayer("EnableCrouch", EnableCrouch)