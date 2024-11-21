A, addon = ...

addon:RegisterEvent('ADDON_LOADED', function(self, name)
    if name ~= A then return end
    _G.AddonCompartmentFrame:RegisterAddon({
        text = "Click Binding",
        icon = "Interface\\Icons\\TEMP.blp",
        notCheckable = true,
        func = _G.ToggleClickBindingFrame,
    })

    LibStub("LibDataBroker-1.1"):NewDataObject("Bunnies!", {
        type = "data source",
        text = "Click Binding",
        icon = "Interface\\Icons\\INV_Chest_Cloth_17",
        OnClick = function() _G.ToggleClickBindingFrame() end,
    })
end)

