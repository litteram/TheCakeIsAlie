local _, addon = ...

addon:RegisterEvent('MERCHANT_SHOW', function(self, ...)
    if  addon:GetOption('auto_sell_junk') then
        _G.MerchantSellAllJunkButton:Click()

        -- accept confirmation dialog (unless the `StaticButtonPopup1` belongs to a different popup)
        addon:Defer(function()
            _G.StaticPopup1Button1:Click()
        end)
    end

    addon:Defer(function()
        if addon:GetOption('auto_repair') then
            _G.MerchantRepairAllButton:Click()
        end
    end)
end)

addon:RegisterEvent('MERCHANT_SHOW', function(self, ...)
    if addon:GetOption('auto_repair') then
        _G.MerchantRepairAllButton:Click()
    end
end)
