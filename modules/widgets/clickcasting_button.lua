A, addon = ...

addon:RegisterEvent('ADDON_LOADED', function(self, name)
    if name ~= A then return end
    _G.AddonCompartmentFrame:RegisterAddon({
        text = "Click Bindings",
        icon = "Interface\\Icons\\TEMP.blp",
        notCheckable = true,
        func = _G.ToggleClickBindingFrame,
    })
end)

