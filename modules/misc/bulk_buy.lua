local _, addon = ...

local SF = StackSplitFrame

--[[
local ssLeft = _G.StackSplitLeftButton_OnClick
function StackSplitLeftButton_OnClick()
print("executing StackSplitLeftButton_OnClick")
  if IsModifierKeyDown() then
    if SF.split > 20 then
      local rem = SF.split % 20
      if rem == 0 then
        SF.split = SF.split + 20
      else
        SF.split = SF.split + 20 - rem
      end
    elseif SF.split < 20 then
      SF.split = 20 - split
    end
  end

  SF.split = SF.split - 1
  ssLeft()
end
]]--

hooksecurefunc("StackSplitRightButton_OnClick", function()
  print("executing StackSplitRightButton_OnClick")
end)

--[[
local ssRight = _G.StackSplitRightButton_OnClick
function StackSplitRightButton_OnClick()

  if IsModifierKeyDown() then
    if SF.split > 20 then
      SF.split = SF.split - 20
    elseif SF.split < 20 then
      SF.split = 1
    end
  end

  SF.split = SF.split + 1
  ssRight()
end
]]
