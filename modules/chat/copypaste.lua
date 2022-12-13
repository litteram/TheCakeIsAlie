local addonName, addon = ...

local mainFrame = CreateFrame("Frame", addonName .. "_CopyChat", UIParent, "BackdropTemplate")
local editBox = CreateFrame("EditBox", addonName .. "_CopyChatEditBox", mainFrame)
local scrollArea = CreateFrame("ScrollFrame", addonName .. "_CopyChatScrollFrame", mainFrame, "UIPanelScrollFrameTemplate")

do
	mainFrame:SetBackdrop(BACKDROP_TUTORIAL_16_16)
	mainFrame:SetPoint("CENTER")
	mainFrame:SetSize(700, 400)
	mainFrame:Hide()
	mainFrame:SetFrameStrata("DIALOG")

	mainFrame:SetMovable(true)
	mainFrame:SetUserPlaced(true)
	mainFrame:SetClampedToScreen(true)

	mainFrame:EnableMouse(true)
	mainFrame:RegisterForDrag("LeftButton")
	mainFrame:SetScript("OnDragStart", function()
		mainFrame:StartMoving()
	end)

	mainFrame.title = mainFrame:CreateFontString(nil, "OVERLAY")
	mainFrame.title:SetFontObject(GameFontNormal)
	mainFrame.title:SetFont(select(1, mainFrame.title:GetFont()), 22, select(3, mainFrame.title:GetFont()))
	mainFrame.title:SetShadowOffset(1, -1)
	mainFrame.title:SetPoint("TOP", frame, "TOP", 0, -12)
	mainFrame.title:SetText("|cff669DFFSimple Copy Chat|r")
	mainFrame.title:SetAlpha(0.7)

	mainFrame.close = CreateFrame("Button", addonName.."_CopyChatEditBox", mainFrame, "UIPanelCloseButton")
	mainFrame.close:SetPoint("TOPRIGHT", frame)

	scrollArea:SetPoint("TOPLEFT", 12, -42)
	scrollArea:SetPoint("BOTTOMRIGHT", -30, 20)

	editBox:SetMultiLine(true)
	editBox:SetMaxLetters(99999)
	editBox:EnableMouse(true)
	editBox:SetAutoFocus(false)
	editBox:SetFontObject(GameFontNormal)
	editBox:SetWidth(scrollArea:GetWidth())
	editBox:SetHeight(400)
	editBox:SetScript("OnEscapePressed", function()
		mainFrame:Hide()
	end)

	editBox:SetScript("OnTextChanged", function(_, userInput)
		if userInput then
			return
		end

		local _, max = scrollArea.ScrollBar:GetMinMaxValues()
		for _ = 1, max do
			ScrollFrameTemplate_OnMouseWheel(scrollArea, -1)
		end
	end)

	scrollArea:SetScrollChild(editBox)
	scrollArea:HookScript("OnVerticalScroll", function(self, offset)
		editBox:SetHitRectInsets(0, 0, offset, (editBox:GetHeight() - offset - self:GetHeight()))
	end)
end

local function getChatLines(chatframe)
	local index = 1
	local lines = {}
	for i = 1, chatframe:GetNumMessages() do
		local msg, r, g, b = chatframe:GetMessageInfo(i)
		if msg then
			lines[index] = tostring(msg)
			index = index + 1
		end
	end

	return table.concat(lines, "\n", 1, index - 1)
end

local function buttonOnClick(self)
	if not mainFrame:IsShown() then
		local chatframe = _G.SELECTED_DOCK_FRAME
		local _, fontSize = chatframe:GetFont()
		_G.FCF_SetChatWindowFontSize(chatframe, chatframe, 0.01)
		PlaySound(21968)
		mainFrame:Show()

		local text = getChatLines(chatframe)
		FCF_SetChatWindowFontSize(chatframe, chatframe, fontSize)
		editBox:SetText(text)
	else
		mainFrame:Hide()
	end
end

local function buttonOnEnter(self)
	_G.UIFrameFadeIn(self, 0.25, self:GetAlpha(), 1)

	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 10, 5)
	GameTooltip:ClearLines()
	GameTooltip:AddLine("Copy Chat")
	GameTooltip:Show()
end
local function buttonOnLeave(self)
	UIFrameFadeIn(self, 0.25, self:GetAlpha(), 0.3)
	GameTooltip:Hide()
end

local function createCopyButton(id)
    local chatFrame = _G[string.format("ChatFrame%d", id)]

    local button = CreateFrame("Button", addonName .. "CopyChat_" .. id, chatFrame)
    button:SetPoint("BOTTOMLEFT", -22, -4)
    button:SetSize(16, 16)
    button:SetAlpha(0.3)

    button.Texture = button:CreateTexture(nil, "ARTWORK")
    button.Texture:SetAllPoints()
    button.Texture:SetTexture("Interface\\Buttons\\UI-GuildButton-PublicNote-Up")

    button:RegisterForClicks("AnyUp")
    button:SetScript("OnClick", buttonOnClick)
    button:SetScript("OnEnter", buttonOnEnter)
    button:SetScript("OnLeave", buttonOnLeave)
end

local function createChatButtons()
    for id = 1, _G["NUM_CHAT_WINDOWS"] do
        createCopyButton(id)
    end
end

function addon:PLAYER_ENTERING_WORLD()
    createChatButtons()
end