local _, addon = ...

function addon:CINEMATIC_START()
  if not addon.db.cinematics then return nil end

  if not IsControlKeyDown() or not InomenaConfig.cinematics then
    CinematicFrame_CancelCinematic()
  end

  local PlayMovie_hook = MovieFrame_PlayMovie
  MovieFrame_PlayMovie = function(...)
    if IsModifierKeyDown() then
      PlayMovie_hook(...)
    else
      GameMovieFinished()
    end
  end
end
