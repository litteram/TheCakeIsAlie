local _, addon = ...

addon:RegisterEvent('PLAYER_LOGIN', function (self, ...)
    if not addon:GetOption('fade_minimap_buttons') then return 1 end

    local hooked = false

    local function ToggleLibDBIconButtons(show)
        for i = 1, Minimap:GetNumChildren() do
            local child = select(i, Minimap:GetChildren())
            local childName = child:GetName() or ""
            if string.find(childName, "LibDBIcon") or childName == "ExpansionLandingPageMinimapButton" then
                if show then
                    child:Show()
                    if addon:GetOption('fade_minimap_garrison_button') then
                        ExpansionLandingPageMinimapButton:Show()
                    end
                else
                    child:Hide()
                    if addon:GetOption('fade_minimap_garrison_button') then
                        ExpansionLandingPageMinimapButton:Hide()
                    end
                end
            end
        end
    end

    ToggleLibDBIconButtons(false)
    C_Timer.After(1, function()
        ToggleLibDBIconButtons(false)

        -- Set up the Minimap's OnEnter and OnLeave script handlers
        Minimap:HookScript("OnEnter", function()
            iconMouseOver = true
            ToggleLibDBIconButtons(true)
        end)

        Minimap:HookScript("OnLeave", function()
            iconMouseOver = false
            -- Delay hiding to check if we left the Minimap to another LibDBIcon or completely out
            C_Timer.After(0.1, function() 
                if not Minimap:IsMouseOver() and not iconMouseOver then
                    ToggleLibDBIconButtons(false)
                end
            end)
        end)

        ExpansionLandingPageMinimapButton:HookScript("OnEnter", function()
            iconMouseOver = true
            ToggleLibDBIconButtons(true)
        end)

        ExpansionLandingPageMinimapButton:HookScript("OnLeave", function()
            iconMouseOver = false
            -- Delay hiding to check if we left the Minimap to another LibDBIcon or completely out
            C_Timer.After(0.1, function() 
                if not Minimap:IsMouseOver() and not iconMouseOver then
                    ToggleLibDBIconButtons(false)
                end
            end)
        end)

        for i = 1, Minimap:GetNumChildren() do
            local child = select(i, Minimap:GetChildren())
            local childName = child:GetName() or ""
            if string.find(childName, "LibDBIcon") or childName == "ExpansionLandingPageMinimapButton" then
                child:HookScript("OnEnter", function()
                    iconMouseOver = true
                    ToggleLibDBIconButtons(true)
                end)
                child:HookScript("OnLeave", function()
                    iconMouseOver = false
                    -- Delay hiding to check if we left the icon to the Minimap or another icon
                    C_Timer.After(0.1, function()
                        if not Minimap:IsMouseOver() and not iconMouseOver then
                            ToggleLibDBIconButtons(false)
                        end
                    end)
                end)
            end
        end

        hooked = true
    end)

end)
