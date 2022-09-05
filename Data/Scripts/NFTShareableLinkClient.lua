local CONTRACT_ADDRESS = script:GetCustomProperty("ContractAddress")
local TOKEN_ID = script:GetCustomProperty("TokenID")
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local INFO = script:GetCustomProperty("Info"):WaitForObject()
local PICTURE = script:GetCustomProperty("Picture"):WaitForObject()
local LINK_PANEL = script:GetCustomProperty("LinkPanel"):WaitForObject()
local TEXT_ENTRY = script:GetCustomProperty("TextEntry"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local token, success, err = Blockchain.GetToken(CONTRACT_ADDRESS, TOKEN_ID)

if success == BlockchainTokenResultCode.SUCCESS then
	INFO.text = token.name
	PICTURE:SetBlockchainToken(token)
	TRIGGER.isInteractable = true
else
	print(err)
end

local function OnTriggerInteracted(trigger, other)
	if other == LOCAL_PLAYER then
		Events.BroadcastToServer("DisbableCrouch")

		UI.SetCanCursorInteractWithUI(true)
		UI.SetCursorVisible(true)

		trigger.isInteractable = false
		LINK_PANEL.visibility = Visibility.FORCE_ON
		TEXT_ENTRY.text = "https://opensea.io/assets/ethereum/" .. CONTRACT_ADDRESS .. "/" .. TOKEN_ID
		TEXT_ENTRY:Focus()
	end
end

local function OnTriggerExit(trigger, other)
	if other == LOCAL_PLAYER then
		Events.BroadcastToServer("EnableCrouch")
		
		UI.SetCanCursorInteractWithUI(false)
		UI.SetCursorVisible(false)

		LINK_PANEL.visibility = Visibility.FORCE_OFF
		trigger.isInteractable = true
	end
end

TRIGGER.interactedEvent:Connect(OnTriggerInteracted)
TRIGGER.endOverlapEvent:Connect(OnTriggerExit)