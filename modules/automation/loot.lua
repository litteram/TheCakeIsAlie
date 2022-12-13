local _, addon = ...

-- confirm loot rolls
function addon:CONFIRM_LOOT_ROLL(rollID, rollType)
	if rollType > 0 then
		ConfirmLootRoll(rollID, rollType)
	end
end

function addon:CONFIRM_DISENCHANT_ROLL(rollID, rollType)
	if rollType > 0 then
		ConfirmLootRoll(rollID, rollType)
	end
end


local LOOT_DELAY = 0.5
local epoch = 0
local function onLootReady()
    if GetCVarBool("autoLootDefault") ~= IsModifiedClick("AUTOLOOTTOGGLE") then
        if (GetTime() - epoch) >= LOOT_DELAY then
            for i = GetNumLootItems(), 1, -1 do
                LootSlot(i)
            end
            epoch = GetTime()
        end
    end
end

function addon:LOOT_READY()
	onLootReady()
end