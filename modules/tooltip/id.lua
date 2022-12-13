local TooltipDataProcessor = _G["TooltipDataProcessor"]

local function idTips(tooltip)
    if _G["GameTooltip"] ~= tooltip then return end
    local _, itemLink = tooltip:GetItem()
    if (itemLink ~= nil) then
        local itemId, _, _, _, _, _, _ = _G.GetItemInfoInstant(itemLink)
        if itemId then tooltip:AddLine("Item ID " .. itemId) end
    end
end

TooltipDataProcessor.AddTooltipPostCall(Enum.TooltipDataType.Item, idTips)
