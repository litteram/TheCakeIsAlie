local addonName, addon = ...
local L = addon.L

addon:RegisterSlash('/alie', function()
    addon:DumpUI(_G.TheCakeIsAlieDB)
end)

addon:RegisterSettings("TheCakeIsAlieDB", {
    -- Combat
    {
        key = "block_rightclick",
        type = "toggle",
        title = L["block right click"],
        tooltip = L["Block right click during combat"],
        default = false,
        new = false,
    },
    -- UI
    {
        key = "cinematics_esc",
        type = "toggle",
        title = L["Quick cancel cinematics"],
        tooltip = L["Quickly cancel cinematics with a single keystroke (esc)"],
        default = false,
        new = false,
    },
    {
        key = "cinematics_destroy",
        type = "toggle",
        title = L["Automatically cancel all cinematics"],
        tooltip = L["Automatically cancel all cinematics without any confirmations."],
        default = false,
        new = false,
        
    },
    {
        key = "set_ui_scale",
        type = "toggle",
        title = L["Set UI scale"],
        tooltip = L["Set UI scale at login to be pixel-perfect"],
        default = false,
        new = false,
    },
    -- Map
    {
        key = "map_pin",
        type = "toggle",
        title = L["Map pin tweaks"],
        tooltip = L["Enhance map pin with infinite tracking and time to arrive"],
        default = true,
        new = false,
    },
    -- Minimap
    {
        key = "fade_minimap_buttons",
        type = "toggle",
        title = L["Fade minimap buttons"],
        tooltip = L["Hide minimap buttons, hover with your cursor to show them again"],
        default = false,
        new = false,
    },
    {
        key = "fade_minimap_garrison_button",
        type = "toggle",
        title = L["Fade minimap garrison button"],
        tooltip = L["Hide minimap garrison buttons, hover with your cursor to show it again"],
        default = false,
        new = false,
    },
    -- Automation
    {
        key = "auto_repair",
        type = "toggle",
        title = L["Repair"],
        tooltip = L["Automatically repair gear when visiting a vendor"],
        default = true,
        new = false,
    },
    {
        key = "auto_sell_junk",
        type = "toggle",
        title = L["Sell junk"],
        tooltip = L["Automatically sell all junk when visiting a vendor"],
        default = true,
        new = false,
    },
})

addon:RegisterSettingsSlash('/'..addonName, '/thecake')

local bindings = {}
function addon:BindButton(name, key, template)
    local button = self:CreateButton('Button', addonName .. 'Bind' .. name, nil, template)
    bindings[button:GetName()] = key
    return button
end

function addon:PLAYER_LOGIN()
    for button, key in next, bindings do
        SetBindingClick(key, button)
    end
    return true
end

-- utils

local FORMAT_DAYS = '%dd'
local FORMAT_HOURS = '%dh'
local FORMAT_MIN = '%dm'
local FORMAT_SEC = '%ds'

function addon:FormatAuraTime(seconds)
    -- copy from SharedXML/TimeUtil.lua with modifications to return whole time in compact format
    local output = ''
    if seconds >= 86400 then
        output = output .. FORMAT_DAYS:format(seconds / 86400) .. ' '
        seconds = seconds % 86400
    end
    if seconds >= 3600 then
        output = output .. FORMAT_HOURS:format(seconds / 3600) .. ' '
        seconds = seconds % 3600
    end
    if seconds >= 60 then
        output = output .. FORMAT_MIN:format(seconds / 60) .. ' '
        seconds = seconds % 60
    end
    if seconds > 0 then
        output = output .. FORMAT_SEC:format(seconds)
    end
    return output .. ' remaining'
end
