local addonName, addon = ...

-- dragonflight
local fishingID = 131474
local fishingCastingID = 131476

-- keybind
local keybinding = "["

local isFishing = false
-- create a new secure macro-button
local button = addon:BindButton(addonName .. 'Fishing', keybinding, 'SecureActionButtonTemplate')
button:SetAttribute('type', 'macro')
button:SetAttribute('macrotext', '/cast [nocombat] Fishing')
button:SetScript('PreClick', function(self)
    if InCombatLockdown() then return end
    isFishing = true
end)
button:SetScript('PostClick', function(self)
    C_Timer.After(0.5, function()
        if InCombatLockdown() then return end
        if isFishing then
            SetOverrideBinding(self, true, keybinding, "INTERACTTARGET")
        else
            ClearOverrideBindings(self)
        end
    end)
end)

local userCVars = {}
local fishingCVars = {
    -- targeting
    SoftTargetInteract = 3,
    SoftTargetInteractArc = 2,
    SoftTargetInteractRange = 15,
    SoftTargetIconGameObject = 1,
    -- sound enhancement
    Sound_EnableAmbience = 0,
    Sound_EnableDialog = 0,
    Sound_EnableMusic = 0,
    Sound_AmbienceVolume = 0,
    Sound_EnableAllSound = 1,
    Sound_EnableEmoteSounds = 0,
    Sound_EnableErrorSpeech = 0,
    Sound_EnablePetSounds = 0,
    Sound_EnableSFX = 1,
    Sound_MasterVolume = 0.5,
    Sound_MusicVolume = 0.25,
    Sound_SFXVolume = 1,
}

local function SetupCVars(data)
    for cvar, value in next, data do
        _G.SetCVar(cvar, tonumber(value))
    end
end

local function OnFishingStart(self, unit, _, spellid)
    if InCombatLockdown() then return end
    if unit ~= "player" then return end
    if spellid ~= fishingCastingID then return end

    isFishing = true
    UIErrorsFrame:AddMessage('+ fishing', 0.1, 1, 0.8)

    SetupCVars(fishingCVars)
end

local function OnFishingStop(self, unit, _, spellid)
    if InCombatLockdown() then return end
    if unit ~= "player" then return end
    if spellid ~= fishingCastingID then return end

    isFishing = false
    UIErrorsFrame:AddMessage('- fishing', 0.1, 1, 0.8)

    ClearOverrideBindings(button)

    SetupCVars(userCVars)
end

addon:RegisterEvent("UNIT_SPELLCAST_CHANNEL_START", OnFishingStart)
addon:RegisterEvent("UNIT_SPELLCAST_CHANNEL_STOP", OnFishingStop)
addon:RegisterEvent("UNIT_SPELLCAST_INTERRUPTED", OnFishingStop)

function addon:PLAYER_ENTERING_WORLD()
    -- save CVars
    for cvar, _ in next, fishingCVars do
        userCVars[cvar] = GetCVar(cvar)
    end
end
