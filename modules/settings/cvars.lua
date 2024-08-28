local _, addon = ...

-- list of all settings listed in the interface options
local CVARS = {
    -- Controls
    deselectOnClick = 1,
    autoDismountFlying = 1,
    autoClearAFK = 1,
    autoLootDefault = 1,
    interactOnLeftClick = 0,

    -- Combat
    spellActivationOverlayOpacity = 1,
    doNotFlashLowHealthWarning = 0,
    lossOfControl = 1,

    -- Raid
    raidFramesDisplayClassColor = 1,

    -- Display
    hideAdventureJournalAlerts = 0, -- legion
    showTutorials = 0,
    enableFloatingCombatText = 0, -- legion
    Outline = 2,
    ShowQuestUnitCircles = 0, -- legion, find the category
    findYourselfMode = -1, -- legion
    chatBubbles = 1,
    chatBubblesParty = 0,

    -- Social
    profanityFilter = 0,
    spamFilter = 0,
    guildMemberNotify = 1,
    blockTrades = 0,
    blockChannelInvites = 0,
    showToastOnline = 0,
    showToastOffline = 0,
    showToastBroadcast = 0,
    showToastFriendRequest = 0,
    showToastWindow = 0,
    enableTwitter = 0,
    showTimestamps = 'none',
    whisperMode = 'inline',

    -- ActionBars
    lockActionBars = 1,
    alwaysShowActionBars = 0,
    countdownForCooldowns = 0,

    -- Names
    UnitNameOwn = 0,
    UnitNameNPC = 0,
    UnitNameHostleNPC = 0,
    UnitNameFriendlySpecialNPCName = 1,
    UnitNameInteractiveNPC = 0,
    UnitNameNonCombatCreatureName = 0,
    UnitNameFriendlyPlayerName = 1,
    UnitNameFriendlyMinionName = 0,
    UnitNameEnemyPlayerName = 1,
    UnitNameEnemyMinionName = 0,
    nameplateShowFriends = 0,
    nameplateShowFriendlyMinions = 0,
    nameplateShowEnemies = 1,
    nameplateShowEnemyMinions = 0,
    nameplateShowEnemyMinus = 1,
    ShowNamePlateLoseAggroFlash = 1,
    nameplateShowAll = 1,
    NamePlateHorizontalScale = 1,
    NamePlateVerticalScale = 1,
    nameplateMotion = 1,
    nameplateShowOnlyNames = 1,
    nameplateOverlapV = 0.5,
    nameplateOtherTopInset = 0.1,
    nameplateLargeTopInset = 0.1,
    nameplateOtherBottomInset = 0.1,
    nameplateLargeBottomInset = 0.1,


    -- Personal Display
    nameplateShowSelf = 1,
    NameplatePersonalClickThrough = 1,
    NameplatePersonalHideDelayAlpha = 0.45,
    NameplatePersonalHideDelaySeconds = 6.0,
    NameplatePersonalShowInCombat = 1,
    NameplatePersonalShowWithTarget = 0,
    nameplatePlayerLargerScale = 1.8,
    nameplateResourceOnTarget = 0,
    nameplateSelfScale = 1.0,
    nameplateSelfBottomInset = 0.28,
    nameplateSelfTopInset = 0.39,


    -- Camera
    cameraWaterCollision = 0,
    cameraDistanceMaxZoomFactor = 2.6, -- 2.6 is default max
    cameraSmoothStyle = 0,
    cameraIndirectVisibility = 1,
    cameraIndirectOffset = 10,

    -- Mouse
    enableMouseSpeed = 0,
    mouseInvertPitch = 0,
    autoInteract = 0,
    cameraYawMoveSpeed = 90,

    -- Accessibility
    enableMovePad = 0,
    movieSubtitle = 1,
    colorblindMode = 0,
    colorblindSimulator = 0,

    -- Sound
    Sound_EnableAllSound = 1,
    Sound_EnableSFX = 1,
    Sound_EnableMusic = 0,
    Sound_EnableAmbience = 1,
    Sound_EnableDialog = 1,
    Sound_EnableErrorSpeech = 0,
    Sound_EnableSoundWhenGameIsInBG = 1,
    Sound_EnableReverb = 0,
    Sound_EnablePositionalLowPassFilter = 1,
    Sound_EnableDSPEffects = 0,
    Sound_MasterVolume = 0.2,
    Sound_SFXVolume = 0.3,
    Sound_MusicVolume = 0.2,
    Sound_AmbienceVolume = 0.1,
    Sound_DialogVolume = 0.6,

    -- Combat
    floatingCombatTextCombatDamage = 1,
    floatingCombatTextCombatHealing = 1,
}

-- list of settings NOT listed in the interface options, but still used
local UVARS = {
    ActionButtonUseKeyDown = 1,
    autoQuestWatch = 1, -- unused
    autoSelfCast = 1, -- unused, still a keybind
    chatStyle = 'im',
    lootUnderMouse = 0,
    mapFade = 1,
    removeChatDelay = 1, -- unused
    screenshotFormat = 'png',
    screenshotQuality = 10,
    scriptErrors = 1,
    taintLog = 1,
    trackQuestSorting = 'proximity',
    secureAbilityToggle = 1,
    cursorSizePreferred = 1,

    nameplateOtherTopInset = -1,
    nameplateOtherBottomInset = -1,
}

function addon:PLAYER_LOGIN()
    -- sort bags the *right* way
    C_Container.SetSortBagsRightToLeft(true)

    if C_CVar.GetCVarBool('autoLootDefault') then
        -- we'll use this one to check if we're set, since it's off by default
        return
    end

    for key, value in next, CVARS do
        C_CVar.SetCVar(key, tostring(value))
    end

    for key, value in next, UVARS do
        C_CVar.SetCVar(key, tostring(value))
    end

    -- need to update the nameplate driver for cvars to take effect
    NamePlateDriverFrame:UpdateNamePlateOptions()

    return true
end
