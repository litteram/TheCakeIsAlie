local _, addon = ...

-- confirm loot rolls
addon:RegisterEvent('CONFIRM_LOOT_ROLL', function(self, rollID, rollType, ...)
  if not addon:GetSettings('confirm_loot_roll') then return 1 end

	if rollType > 0 then
		ConfirmLootRoll(rollID, rollType)
	end
end)

addon:RegisterEvent('CONFIRM_DISENCHANT_ROLL', function(self, rollID, rollType, ...)
  if not addon:GetSettings('confirm_disenchant_roll') then return 1 end

	if rollType > 0 then
		ConfirmLootRoll(rollID, rollType)
	end
end)

-- completely hide lootbox thing

local function NoLootFrame_OnEvent(self, event, ...)

    if event == 'LOOT_OPENED' then
        self.autoLoot = ...
        if self.autoLoot then
            LootFrame:SetScript('OnEvent', nil)
            CloseLoot()
            return
        end
    end

    if event == 'CHAT_MSG_LOOT' then
        local guid =  select(12, ...)
        if guid ~= UnitGUID('player') then
            return
        end
        local msg = ...
        local pre, link, color, post = msg:match('^(.*)(|c(........)|H.+|h|r)(.*)$')
        if color == PoorQualityColor then
            return
        end
        local txt = '|cff33cc33' .. pre .. FONT_COLOR_CODE_CLOSE ..
                    link .. 
                    '|cff33cc33' .. post .. FONT_COLOR_CODE_CLOSE
        UIErrorsFrame:AddMessage(txt)
        return
    end

    if event == 'LOOT_CLOSED' then
        if self.autoLoot then
            LootFrame:SetScript('OnEvent', LootFrame_OnEvent)
        end
        self.autoLoot = nil
        return
    end
end

local NoLootFrame = CreateFrame('Frame', UIParent)
NoLootFrame:SetScript('OnEvent', NoLootFrame_OnEvent)

-- We need to make sure we get this event before LootFrame so that we can
-- unset it's OnEvent handler if we're autolooting.

LootFrame:UnregisterEvent('LOOT_OPENED')

NoLootFrame:RegisterEvent('LOOT_OPENED')
LootFrame:RegisterEvent('LOOT_OPENED')

NoLootFrame:RegisterEvent('LOOT_CLOSED')
NoLootFrame:RegisterEvent('CHAT_MSG_LOOT')
