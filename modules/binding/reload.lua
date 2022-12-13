local _, addon = ...

addon:BindButton('Reload', 'F12'):SetScript('OnClick', C_UI.Reload)

SLASH_RELOADUI1 = '/rl'
SlashCmdList.RELOADUI = C_UI.ReloadUI