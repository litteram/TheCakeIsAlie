local _, addon = ...

-- confirm loot rolls
addon:RegisterEvent('CONFIRM_LOOT_ROLL', function(self, rollID, rollType, ...)
  if not addon:GetOption('confirm_loot_roll') then return 1 end

	if rollType > 0 then
		ConfirmLootRoll(rollID, rollType)
	end
end)

addon:RegisterEvent('CONFIRM_DISENCHANT_ROLL', function(self, rollID, rollType, ...)
  if not addon:GetOption('confirm_disenchant_roll') then return 1 end

	if rollType > 0 then
		ConfirmLootRoll(rollID, rollType)
	end
end)

-- completely hide lootbox thing

local function NoLootFrame_OnEvent(self, event, ...)
    if not addon:GetOption('auto_loot_fast') then return 0 end

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
        local pre, link, color, post = msg:match('^(.*)(|c(.+)|H.+|h|r)(.*)$')
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
            _G['LootFrame']:SetScript('OnEvent', _G['LootFrame_OnEvent'])
        end
        self.autoLoot = nil
        return
    end
end

local NoLootFrame = CreateFrame('Frame', _G['UIParent'])
local function noop() end

local function init_autoloot()
    if addon:GetOption('auto_loot_fast') then
        NoLootFrame:SetScript('OnEvent', NoLootFrame_OnEvent)
        -- We need to make sure we get this event before LootFrame so that we can
        -- unset it's OnEvent handler if we're autolooting.

        _G['LootFrame']:UnregisterEvent('LOOT_OPENED')
        NoLootFrame:RegisterEvent('LOOT_OPENED')
        _G['LootFrame']:RegisterEvent('LOOT_OPENED')

        NoLootFrame:RegisterEvent('LOOT_CLOSED')
        NoLootFrame:RegisterEvent('CHAT_MSG_LOOT')
    else
        NoLootFrame:SetScript('OnEvent', noop)
    end
end

addon:RegisterEvent("PLAYER_LOGIN", init_autoloot)
addon:RegisterOptionCallback('auto_loot_fast', init_autoloot)
