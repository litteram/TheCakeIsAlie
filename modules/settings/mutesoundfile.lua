local _, addon = ...

local annoyances = {
	569772, -- sound/spells/fizzle/fizzleholya.ogg
	569773, -- sound/spells/fizzle/fizzlefirea.ogg
	569774, -- sound/spells/fizzle/fizzlenaturea.ogg
	569775, -- sound/spells/fizzle/fizzlefrosta.ogg
	569776, -- sound/spells/fizzle/fizzleshadowa.ogg
}

function addon:ADDON_LOADED()
    for _, id in next, annoyances do
        MuteSoundFile(id)
    end
end