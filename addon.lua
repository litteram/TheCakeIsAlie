local addonName, addon = ...
addon = addon or {}
if _G.TheCakeIsAlieDB == nil then
    _G.TheCakeIsAlieDB = {
        cinematics_esc = true,
        cinematics_destroy = false,
        block_rightclick = false,
        map_pin = true,
        set_ui_scale = false,
    }
end
addon.db = addon.db or _G.TheCakeIsAlieDB

addon:RegisterSlash("/alie", function()
    addon:Dump(TheCakeIsAlieDB)
end)

function trimMultiline(str)
    local out = ""
    local indent = 0
    for nline, line in str:gmatch("[^\r\n]+") do
        local ind = 0

        for i = 1, #line do
            local c = line:sub(i,i)
            ind = ind + 1
            if c ~= " " and c ~= "\t" then
                line = line:sub(i, #line)
            end
        end
        if nline ~= 0 and ind < indent then
            indent = ind
        end
    end

    return str
end

addon:RegisterSettings("TheCakeIsAlieDB", {
    {
        key = "cinematics_esc",
        type = "toggle",
        title = "Quick cancel cinematics",
        tooltip = "Quickly cancel cinematics with a single keypress (esc)",
        default = false,
        new = false,
    },
    {
        key = "cinematics_destroy",
        type = "toggle",
        title = "Automatically cancel all cinematics",
        tooltip = "Automatically cancel all cinematics without any confirmations. Recommended to be off.",
        default = false,
        new = false,
        
    },
    {
        key = "block_rightclick",
        type = "toggle",
        title = "block right click",
        tooltip = "Block right click in combat",
        default = false,
        new = false,
    },
    {
        key = "set_ui_scale",
        type = "toggle",
        title = "Set UI Scale",
        tooltip = "Set UI scale at login to be pixel-perfect",
        default = false,
        new = false,
    },
    {
        key = "map_pin",
        type = "toggle",
        title = "Map pin tweaks",
        tooltip = "Enhance map pin:\n- infinite tracking\n- time to arrive",
        default = true,
        new = false,
    },
})


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
