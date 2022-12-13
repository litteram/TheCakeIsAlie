local _, addon = ...

local stop = true
local list = {}
local GetContainerNumSlots, GetContainerItemLink, UseContainerItem
= C_Container.GetContainerNumSlots
, C_Container.GetContainerItemLink
, C_Container.UseContainerItem

local function sellGray()
    if stop then return end
    for bag=0,4 do
        for slot=0,GetContainerNumSlots(bag) do
            if stop then return end

            local link = GetContainerItemLink(bag, slot)
            if link and select(3, GetItemInfo(link)) == 0 and not list["b"..bag.."s"..slot] then
                --print(A,"selling",link,"bag",bag,"slot",slot)
                list["b"..bag.."s"..slot] = true
                UseContainerItem(bag, slot)
                C_Timer.After(0.1, sellGray)
                return
            end
        end
    end
end

function addon:MERCHANT_SHOW()
        stop = false
        wipe(list)
        sellGray()
end
function addon:MERCHANT_CLOSED()
        stop = true
end
