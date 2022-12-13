std = 'lua51'

quiet = 1 -- suppress report output for files without warnings

-- see https://luacheck.readthedocs.io/en/stable/warnings.html#list-of-warnings
-- and https://luacheck.readthedocs.io/en/stable/cli.html#patterns
ignore = {
	'212/self', -- unused argument self
	'212/event', -- unused argument event
	'212/unit', -- unused argument unit
	'212/element', -- unused argument element
	'312/event', -- unused value of argument event
	'312/unit', -- unused value of argument unit
	'431', -- shadowing an upvalue
	'631', -- line is too long
}

exclude_files = {
	'modules/units_old/*.lua',
	'modules/units_old/**/*.lua',
}

globals = {
	-- FrameXML objects we mutate
	'ChatTypeInfo',
	'StaticPopupDialogs',
	'ObjectiveTrackerFrame',
	'SuperTrackedFrame',
	'SlashCmdList',
	'TimeManager_LoadUI',

	'TheCakeIsAlieDB',
}

read_globals = {
	bit = {fields = {'band'}},
	string = {fields = {'split', 'trim', 'join'}},
	table = {fields = {'wipe'}},

	-- FrameXML objects
	'BuffFrame',
	'ChatFontNormal',
	'ChatFrame1',
	'ChatFrame2',
	'ChatFrameChannelButton',
	'ChatFrameMenuButton',
	'CompactRaidFrameManager',
	'ContainerFrame1MoneyFrame',
	'DurabilityFrame',
	'GameTooltip',
	'GameTooltipStatusBar',
	'GarrisonLandingPageMinimapButton',
	'HybridMinimap',
	'MainMenuBar',
	'MerchantFrame',
	'MicroButtonAndBagsBar',
	'Minimap',
	'MiniMapMailFrame',
	'MiniMapMailIcon',
	'MiniMapTrackingDropDown',
	'NamePlateDriverFrame',
	'ObjectiveTrackerFrame',
	'OrderHallCommandBar',
	'PetBattleFrame',
	'QuestInfoFrame',
	'QueueStatusMinimapButton',
	'QuickJoinToastButton',
	'ReadyCheckListenerFrame',
	'ScenarioBlocksFrame',
	'SendMailMailButton',
	'SendMailMoneyCopper',
	'SendMailMoneyGold',
	'SendMailMoneySilver',
	'SendMailNameEditBox',
	'SendMailSubjectEditBox',
	'TemporaryEnchantFrame',
	'TicketStatusFrame',
	'TradeSkillFrame',
	'UIErrorsFrame',
	'UIParent',
	'VehicleSeatIndicator',
	'WeeklyRewardsFrame',
	'WorldMapFrame',
	'WorldMapFrameCloseButton',

	-- FrameXML functions
	'nop',
	'GetDifficultyColor',
	'GetUnitName',
	'IsSecureCmd',
	'RegisterAttributeDriver',
	'ReloadUI',
	'ToggleCalendar',
	'ToggleDropDownMenu',
	'ChatEdit_DeactivateChat',
	'ChatEdit_GetActiveWindow',
	'ChatEdit_ParseText',
	'ChatEdit_SendText',
	'ChatFrame_AddChannel',
	'ChatFrame_AddMessageGroup',
	'ChatFrame_OpenChat',
	'ChatFrame_ReceiveAllPrivateMessages',
	'ChatFrame_RemoveAllChannels',
	'ChatFrame_RemoveAllMessageGroups',
	'FCF_Close',
	'FCF_GetChatWindowInfo',
	'FCF_OpenNewWindow',
	'FCF_ResetChatWindows',
	'FCF_RestorePositionAndDimensions',
	'FCF_SavePositionAndDimensions',
	'FCF_SelectDockFrame',
	'FCF_SetWindowAlpha',
	'FCF_SetWindowColor',
	'GameTooltip_Hide',
	'GarrisonLandingPageMinimapButton_OnClick',
	'Minimap_OnClick',
	'PlayerTalentTab_OnClick',
	'StaticPopup_Hide',
	'StaticPopup_Visible',
	'UnitFrame_OnEnter',
	'UnitFrame_OnLeave',

	-- FrameXML constants
	'BACKPACK_CONTAINER',
	'BNET_CLIENT_D3',
	'BNET_CLIENT_HEROES',
	'BNET_CLIENT_OVERWATCH',
	'BNET_CLIENT_SC2',
	'BNET_CLIENT_WOW',
	'BNET_CLIENT_WTCG',
	'COPPER_PER_GOLD',
	'COPPER_PER_SILVER',
	'FACTION_BAR_COLORS',
	'FRAMERATE_FREQUENCY',
	'GREEN_FONT_COLOR_CODE',
	'INVENTORY_ALERT_COLORS',
	'INVENTORY_ALERT_STATUS_SLOTS',
	'NUM_BAG_SLOTS',
	'NUM_CHAT_WINDOWS',
	'PAPERDOLL_STATCATEGORIES',
	'PERFORMANCEBAR_UPDATE_INTERVAL',
	'RAID_CLASS_COLORS',
	'RED_FONT_COLOR_CODE',
	'SELECTED_CHAT_FRAME',
	'SILVER_PER_GOLD',
	'SOUNDKIT',
	'TALENTS_TAB',
	'YELLOW_FONT_COLOR_CODE',

	-- SharedXML objects
	'BackdropTemplateMixin',

	-- SharedXML functions
	'CreateColor', -- SharedXML/Color.lua
	'FormatLargeNumber', -- SharedXML/FormattingUtil.lua
	'GetItemInfoFromHyperlink', -- SharedXML/LinkUtil.lua
	'Mixin', -- SharedXML/Mixin.lua
	'SecondsToTime', -- SharedXML/TimeUtil.lua

	-- GlobalStrings
	'ARTIFACT_POWER',
	'CHAT_FLAG_AFK',
	'CHAT_FLAG_DND',
	'CURRENCY',
	'HELPFRAME_ITEM_TITLE',
	'ID',
	'IDLE_MESSAGE',
	'INSTANCE',
	'ITEM_COOLDOWN_TIME',
	'LEADER',
	'MINIMAP_TRACKING_MAILBOX',
	'MINIMAP_TRACKING_REPAIR',
	'MONEY',
	'MOUNT',
	'RAID_WARNING',
	'SLASH_SMART_WHISPER1',
	'STAT_CATEGORY_SPELL',
	'TIMER_MINUTES_DISPLAY',
	'UNAVAILABLE',
	'UNKNOWN',

	-- namespaces
	'C_ArtifactUI',
	'C_BattleNet',
	'C_ChallengeMode',
	'C_Covenants',
	'C_CurrencyInfo',
	'C_CVar',
	'C_DateAndTime',
	'C_FriendList',
	'C_Garrison',
	'C_Map',
	'C_MountJournal',
	'C_Navigation',
	'C_PartyInfo',
	'C_PetJournal',
	'C_PlayerInfo',
	'C_QuestLog',
	'C_Timer',
	'C_ToyBox',
	'C_TradeSkillUI',
	'C_UI',
	'Enum',

	-- API
	'hooksecurefunc',
	'AcceptGroup',
	'BNGetNumFriends',
	'CanEjectPassengerFromSeat',
	'CanGuildBankRepair',
	'CanMerchantRepair',
	'CanWithdrawGuildBankMoney',
	'ChangeChatColor',
	'ClearCursor',
	'ConfirmLootRoll',
	'ContainerIDToInventoryID',
	'CreateFrame',
	'CursorHasItem',
	'EjectPassengerFromSeat',
	'EquipPendingItem',
	'GetAchievementInfo',
	'GetAutoCompletePresenceID',
	'GetBattlefieldStatus',
	'GetBuybackItemLink',
	'GetChannelName',
	'GetContainerItemID',
	'GetContainerItemInfo',
	'GetContainerItemLink',
	'GetContainerNumSlots',
	'GetExistingSocketLink',
	'GetFramerate',
	'GetGuildBankItemLink',
	'GetGuildBankMoney',
	'GetGuildBankWithdrawMoney',
	'GetGuildInfo',
	'GetGuildRosterInfo',
	'GetInboxItemLink',
	'GetInventoryAlertStatus',
	'GetInventoryItemID',
	'GetItemCooldown',
	'GetItemCount',
	'GetItemCreationContext',
	'GetLFGDungeonRewardInfo',
	'GetLFGDungeonRewardLink',
	'GetLFGDungeonShortageRewardLink',
	'GetLootRollItemLink',
	'GetLootSlotLink',
	'GetMerchantItemCostItem',
	'GetMerchantItemLink',
	'GetMoney',
	'GetNetStats',
	'GetNewSocketLink',
	'GetNumGuildMembers',
	'GetNumSpecializations',
	'GetNumTrackingTypes',
	'GetPhysicalScreenSize',
	'GetProfessionInfo',
	'GetProfessions',
	'GetPvpTalentInfoByID',
	'GetQuestCurrencyID',
	'GetQuestItemInfo',
	'GetQuestLogItemLink',
	'GetQuestLogRewardCurrencyInfo',
	'GetQuestLogSpecialItemInfo',
	'GetRealmID',
	'GetRealmName',
	'GetRepairAllCost',
	'GetSendMailItemLink',
	'GetShapeshiftFormInfo',
	'GetSpecializationInfo',
	'GetSpellBookItemInfo',
	'GetSpellBookItemName',
	'GetSpellBookItemTexture',
	'GetSpellCooldown',
	'GetSpellInfo',
	'GetSpellTexture',
	'GetTime',
	'GetTotemInfo',
	'GetTrackingInfo',
	'GetTradePlayerItemLink',
	'GetTradeTargetItemLink',
	'GetTrainerServiceItemLink',
	'GetVoidItemInfo',
	'GetVoidTransferDepositInfo',
	'GetVoidTransferWithdrawalInfo',
	'GetWeaponEnchantInfo',
	'HasNewMail',
	'InCombatLockdown',
	'IsAddOnLoaded',
	'IsControlKeyDown',
	'IsCurrentSpell',
	'IsPlayerSpell',
	'IsShiftKeyDown',
	'IsSpellKnown',
	'IsSwimming',
	'LoadAddOn',
	'PickupBagFromSlot',
	'PickupContainerItem',
	'PlayerHasToy',
	'PlaySound',
	'PutItemInBag',
	'RepairAllItems',
	'SecureCmdOptionParse',
	'SendChatMessage',
	'SetBindingClick',
	'SetChatColorNameByClass',
	'SetTracking',
	'TaxiRequestEarlyLanding',
	'UnitAura',
	'UnitBattlePetLevel',
	'UnitBattlePetType',
	'UnitCanAssist',
	'UnitCanCooperate',
	'UnitClassBase',
	'UnitClassification',
	'UnitCreatureFamily',
	'UnitCreatureType',
	'UnitExists',
	'UnitFactionGroup',
	'UnitGUID',
	'UnitIsBattlePetCompanion',
	'UnitIsDeadOrGhost',
	'UnitIsFriend',
	'UnitIsInMyGuild',
	'UnitIsPlayer',
	'UnitIsUnit',
	'UnitIsWildBattlePet',
	'UnitLevel',
	'UnitName',
	'UnitOnTaxi',
	'UnitRace',
	'UnitReaction',
	'UnitVehicleSeatCount',
	'UseContainerItem',

	-- exposed from other addons
	'_detalhes', -- Details
	'LibStub',
	'OneRingLib', -- OPie
	'OPie',
}
