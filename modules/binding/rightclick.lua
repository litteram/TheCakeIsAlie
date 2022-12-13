local addonName, addon = ...
local UnitAffectingCombat = _G.UnitAffectingCombat
local MouselookStop = _G.MouselookStop
local GetTimePreciseSec = _G.GetTimePreciseSec
local WorldFrame = _G["WorldFrame"]

local debounceMin = 0.8
local debounceTime = GetTimePreciseSec()
function addon:ADDON_LOADED(name)
    if name ~= addonName then return end
    if not addon.db.block_rightclick then return end
    WorldFrame:HookScript("OnMouseUp", function(_, button)
        if button == "RightButton" then
            if UnitAffectingCombat("player") and (GetTimePreciseSec() - debounceTime) < debounceMin then
                MouselookStop()
                debounceTime = GetTimePreciseSec()
            end
        end
    end)
end