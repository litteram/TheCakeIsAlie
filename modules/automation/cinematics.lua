local _, addon = ...

if addon.db.cinematics_destroy then
    function addon:CINEMATIC_START()
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
end


if addon.db.cinematics_esc then
    CinematicFrame:HookScript("OnKeyDown", function(self, key)
        if key == "ESCAPE" then
            if CinematicFrame:IsShown() and CinematicFrame.closeDialog and CinematicFrameCloseDialogConfirmButton then
                CinematicFrameCloseDialog:Hide()
            end
        end
    end)
    CinematicFrame:HookScript("OnKeyUp", function(self, key)
        if key == "SPACE" or key == "ESCAPE" or key == "ENTER" then
            if CinematicFrame:IsShown() and CinematicFrame.closeDialog and CinematicFrameCloseDialogConfirmButton then
                CinematicFrameCloseDialogConfirmButton:Click()
            end
        end
    end)
    MovieFrame:HookScript("OnKeyUp", function(self, key)
        if key == "SPACE" or key == "ESCAPE" or key == "ENTER" then
            if MovieFrame:IsShown() and MovieFrame.CloseDialog and MovieFrame.CloseDialog.ConfirmButton then
                MovieFrame.CloseDialog.ConfirmButton:Click()
            end
        end
    end)
end
