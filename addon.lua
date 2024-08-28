local addonName, addon = ...

if addon.db == nil then
    addon.db = _G.TheCakeIsAlieDB
end

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
