local _, addon = ...

function addon:CINEMATIC_START()
  if not addon.db.cinematics then
    return
  end

  if not IsModifierKeyDown() then
    CinematicFrame_CancelCinematic()
  end

  local PlayMovie_hook = MovieFrame_PlayMovie
  MovieFrame_PlayMovie = function(...)
    if IsModifierKeyDown() or not addon.db.cinematics then
      PlayMovie_hook(...)
    else
      GameMovieFinished()
    end
  end
end
