local _, addon = ...

local annoyances = {
	569772, -- sound/spells/fizzle/fizzleholya.ogg
	569773, -- sound/spells/fizzle/fizzlefirea.ogg
	569774, -- sound/spells/fizzle/fizzlenaturea.ogg
	569775, -- sound/spells/fizzle/fizzlefrosta.ogg
	569776, -- sound/spells/fizzle/fizzleshadowa.ogg

  -- Grand Expedition Yak: Cousin Slowhands: Welcome - 31613
  640336, 640338, 640340,
  -- Grand Expedition Yak: Cousin Slowhands: Farewell - 31616
  640314, 640316, 640318, 640320,
  -- Grand Expedition Yak: Mystic Birdhat: Welcome - 31595
  640180, 640182, 640184,
  -- Grand Expedition Yak: Mystic Birdhat: Farewell - 31598
  640158, 640160, 640162, 640164,
  -- Mighty Caravan Brutosaur: Merchant Maku: Welcome - 109415
  1998117, 1998118, 1998119,
  -- Mighty Caravan Brutosaur: Merchant Maku: Farewell - 109416
  1998112, 1998114, 1998115,
  -- Mighty Caravan Brutosaur: Collector Unta: Welcome - 109419
  1998116,
  -- Mighty Caravan Brutosaur: Collector Unta: Farewell - 109418
  1998113,
  -- Traveler's Tundra Mammoth: Hakmud of Argus: Welcome - 9772
  557341, 557335, 557328, 557331, 557325, 557324,
  -- Traveler's Tundra Mammoth: Hakmud of Argus: Farewell - 9769
  557342, 557326, 557322, 557332, 557338, 557334,
  -- Traveler's Tundra Mammoth: Mojodishu: Welcome - 6657
  562812,562802,562815,562814,562816,562807,562804,562803,
  -- Traveler's Tundra Mammoth: Mojodishu: Farewell - 5953
  562809,562808,562813,562817,562806,
  -- Traveler's Tundra Mammoth: Drix Blackwrench: Welcome - 6632
  550818,550817,550805,550813,550819,550806,550820,550809,
  -- Traveler's Tundra Mammoth: Drix Blackwrench: Farewell - 5965
  550807,550808,550812
}

function addon:ADDON_LOADED()
    for _, id in next, annoyances do
        MuteSoundFile(id)
    end
end
