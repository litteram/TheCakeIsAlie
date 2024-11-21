local _, addon = ...

local function defer(fn)
  return C_Timer.After(0.025, fn)
end

local function eventHandler()
  local opt_instances_mute = addon:GetOption('talking_head_instances_mute')
  local opt_instances_hide = addon:GetOption('talking_head_instances_hide')
  local opt_mute = addon:GetOption('talking_head_mute')
  local opt_hide = addon:GetOption('talking_head_hide')
  local inInstance, instanceType = IsInInstance()

  if inInstance and not opt_instances_hide or not opt_instances_mute then
    return 1
  end

  if opt_hide or opt_instances_hide then
    defer(function()
      TalkingHeadFrame:Hide()
      if TalkingHeadFrame.voHandle then StopSound(TalkingHeadFrame.voHandle) end
    end)
    return
  end

  if opt_silent or opt_instances_mute then
    defer(function()
      if TalkingHeadFrame.voHandle then StopSound(TalkingHeadFrame.voHandle) end
    end)
  end

end

hooksecurefunc(TalkingHeadFrame, "PlayCurrent", eventHandler)
