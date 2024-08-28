local addonName, addon = ...

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
        key = "cinematics",
        type = "toggle",
        title = "Quick cancel cinematics",
        tooltip = "Quickly cancel cinematics with a single keypress",
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
        key = "map_pin",
        type = "toggle",
        title = "Map pin tweaks",
        tooltip = "Enhance map pin:\n- infinite tracking\n- time to arrive",
        default = true,
        new = false,
    },
})
