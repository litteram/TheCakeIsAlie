local addonName, addon = ...

local defaultConfig = {
    cinematics = false,
    block_rightclick = false,
}


local function checkbox(name, parent, isChecked, onChange)
    local frame = CreateFrame("CheckButton", nil, addon.configPanel, "InterfaceOptionsCheckButtonTemplate")
    frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -20)
    frame.Text:SetText(name)
    -- there already is an existing OnClick script that plays a sound, hook it
    frame:HookScript("OnClick", function(_, _, _)
        onChange(frame:GetChecked())
    end)
    frame:SetChecked(isChecked)
    return frame
end

local function button(name, parent, onClick)
    local frame = CreateFrame("Button", nil, addon.configPanel, "UIPanelButtonTemplate")
    frame:SetPoint("TOPLEFT", parent, "BOTTOMLEFT", 0, -20)
    frame:SetText(name)
    frame:SetWidth(100)
    frame:HookScript("OnClick", function()
        onClick()
    end)
    return frame
end

local function initialize()
    addon.configPanel = CreateFrame("Frame", addonName .. "Options", _G.InterfaceOptionsFramePanelContainer)
    addon.configPanel.name = addonName

    local title = addon.configPanel:CreateFontString("ARTWORK", nil, "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 20, 4)
    title:SetText(addonName)

    local skipCinematics = checkbox("skip cinematics", title,
        addon.db.cinematics, function(val) addon.db.cinematics = val; end)
    if InCombatLockdown() then skipCinematics:Disable() end

    local blockRightclick = checkbox("block right click in combat", skipCinematics,
        addon.db.block_rightclick, function(val) addon.db.block_rightclick = val; end)
    if InCombatLockdown() then skipCinematics:Disable() end

    addon.configPanel:SetScript("OnEvent", function(_, event)
        if event == "PLAYER_REGEN_DISABLED" then
            skipCinematics:Disable()
            blockRightclick:Disable()
        else
            skipCinematics:Enable()
            blockRightclick:Enable()
        end
    end)
    addon.configPanel:RegisterEvent("PLAYER_REGEN_ENABLED")
    addon.configPanel:RegisterEvent("PLAYER_REGEN_DISABLED")
    addon.configPanel:SetScript("OnShow", nil)

    InterfaceOptions_AddCategory(addon.configPanel)
end

function addon:ADDON_LOADED(evt)
    if evt == addonName then
        TheCakeIsAlieDB = TheCakeIsAlieDB or CopyTable(defaultConfig)
        addon.db = TheCakeIsAlieDB
        -- addon:Dump(TheCakeIsAlieDB)

        initialize()
    end
end

addon:RegisterSlash("/alie", function()
    addon:Dump(TheCakeIsAlieDB)
end)