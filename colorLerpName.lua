--    Gradient Scroll Nickname module by:
  
--       _______           __                           _           
--      / ____(_)_________/ /__  ____ ___  ____ _____  (_)___ ______
--     / /   / / ___/ ___/ / _ \/ __ `__ \/ __ `/ __ \/ / __ `/ ___/
--    / /___/ / /  / /__/ /  __/ / / / / / /_/ / / / / / /_/ / /__  
--    \____/_/_/   \___/_/\___/_/ /_/ /_/\__,_/_/ /_/_/\__,_/\___/  

--    This module (v1.i_am_currently_in_immense_pain.1) takes your nickname (or any string you set it to)
--    and makes it a custom animated color gradient through JSON. Note that it WILL NOT WORK
--    if the string you give it is already in JSON format.
--    This version includes performance improvements by Manuel_
--    This version also includes more performance provements by auriafoxgirl

-- CONFIG --
local username = "Skye"                            -- leave empty to use your player name
local colors = {"#5BCEFA","#5BCEFA","#F5A9B8","#F5A9B8","#FFFFFF","#F5A9B8","#F5A9B8"} -- this array can be of any length, example {"#5BCEFA","#F5A9B8","#FFFFFF","#F5A9B8"} for trans flag
local offset = 0.1                             -- color scroll per letter, 1 - one color in the array
local speed  = 0.1                             -- how fast color spreads from letter to letter
local affectFiguraMark = true                  -- wheter to color the mark icon as well
--------------------------------

local hexToRGB = vectors.hexToRGB
for i, v in ipairs(colors) do
  colors[i - 1] = hexToRGB(v)
end
local colorCount = #colors
colors[colorCount] = colors[0]
local floor = math.floor
local rgbToHex = vectors.rgbToHex
if username == "" then
  function events.ENTITY_INIT()
    username = player:getName()
  end
end
local usernameChars

function events.tick()
  if not usernameChars then
    usernameChars = {}
    for i = 1, #username do
      usernameChars[i] = username:sub(i, i)
    end
    return
  end
  local color
  local newName = '['
  local time = world.getTime() * speed
  for i = 1, #username do
    local counter = (time + offset * i) % colorCount
    local counterFloored = floor(counter)
    color = colors[counterFloored] + (colors[counterFloored + 1] - colors[counterFloored]) * (counter - counterFloored)
    newName = newName .. '{"text":"' .. usernameChars[i] .. '","color":"#' .. rgbToHex(
      color
    ) .. '"},'
  end
  if affectFiguraMark then
    avatar:setColor(color)
  end
  newName = newName .. '""]'
  nameplate.ALL:setText(newName)
end
