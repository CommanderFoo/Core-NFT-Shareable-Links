local PICTURE = script:GetCustomProperty("Picture"):WaitForObject()
local INFO = script:GetCustomProperty("Info"):WaitForObject()
local CONTACT_ADDRESS = script:GetCustomProperty("ContactAddress")
local TOKEN_ID = script:GetCustomProperty("TokenID")
local TRIGGER = script:GetCustomProperty("Trigger"):WaitForObject()
local LINK_PANEL = script:GetCustomProperty("LinkPanel"):WaitForObject()
local URLTEXT_ENTRY = script:GetCustomProperty("URLTextEntry"):WaitForObject()

local LOCAL_PLAYER = Game.GetLocalPlayer()
local token, success, err = Blockchain.GetToken(CONTACT_ADDRESS, TOKEN_ID)

if success == BlockchainTokenResultCode.SUCCESS then
	INFO.text = token.name
	PICTURE:SetBlockchainToken(token)
else
	print(err)
end

TRIGGER.isInteractable = true

local function OnTriggerInteracted(trigger, other)
	if other == LOCAL_PLAYER then
		UI.SetCanCursorInteractWithUI(true)
		UI.SetCursorVisible(true)

		trigger.isInteractable = false
		LINK_PANEL.visibility = Visibility.FORCE_ON
		URLTEXT_ENTRY.text = "https://opensea.io/assets/ethereum/" .. CONTACT_ADDRESS .. "/" .. TOKEN_ID
		URLTEXT_ENTRY:Focus()
	end
end

local function OnTriggerExit(trigger, other)
	if other == LOCAL_PLAYER then
		UI.SetCanCursorInteractWithUI(false)
		UI.SetCursorVisible(false)

		LINK_PANEL.visibility = Visibility.FORCE_OFF
		trigger.isInteractable = true
	end
end

TRIGGER.interactedEvent:Connect(OnTriggerInteracted)
TRIGGER.endOverlapEvent:Connect(OnTriggerExit)