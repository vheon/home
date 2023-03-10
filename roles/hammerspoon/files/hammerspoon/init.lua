--- Spoons ---
hs.loadSpoon("SpoonInstall")
spoon.SpoonInstall:andUse("EmmyLua")

--[[
-- when iTerm2 window is moved:
--   if changed monitor:
--     set proper font size
--     set proper window dimention
--
-- when number of monitor changes:
--   if "microsoft rdp" are present in spaces:
--     made them windowed and then in fullscreen them in the bigger screen possible
--]]

-- local iTerm2 = {
--   bundleID = "com.googlecode.iterm2"
-- }

-- -- first check if the app is already up and running
-- local apps = hs.application.applicationsForBundleID(iTerm2.bundleID)
-- if #apps > 0 then
--   -- use only the first one
--   if #apps > 1 then
--     apps = apps[1]
--   end
--   -- already found iTerm2 running
--   iTerm2.app = apps
--   iTerm2.observer = hs.axuielement.observer.new(apps:pid())
-- end

local hyper = { "cmd", "option", "ctrl", "shift" }

hs.hotkey.bind(hyper, "m", function()
  local win = hs.window.focusedWindow()
  local app = win:application()
  local screen = win:screen()
  if app and app:bundleID() == "com.googlecode.iterm2" then

    local fontSize = 13
    local fullFrame = screen:fullFrame()
    if fullFrame.h == 1440 then
      fontSize = 15
    elseif fullFrame.h == 1080 then
      fontSize = 14
    end
    hs.task.new('/Applications/iTerm.app/Contents/Resources/it2run', nil, function()end, {'adjust_font_size.py', '--size', tostring(fontSize)}):start():waitUntilExit()
  end
  win:setFrame(screen:frame(), 0)
end)



-- hs.application.watcher.new(function(_, event, app)
--   if app:bundleID() ~= iTerm2.bundleID then
--     return
--   end

--   if event == hs.application.watcher.launching then
--     return
--   end

--   if event == hs.application.watcher.terminated then
--     if iTerm2.observer ~= nil then
--       iTerm2.observer:stop()
--       iTerm2.observer = nil
--     end
--     iTerm2.app = nil
--     return
--   end

--   if iTerm2.app == nil then
--     local ax = hs.axuielement.applicationElement(app)
--     if not ax:isValid() then
--       return
--     end


--     -- What we should/could do is:
--     -- * On mouse down start this observer
--     -- * in the callback simply store the screen of the window that is moving
--     -- * On mouse up stop the observer and check if the screen changed and if so change the font and resize the window
--     local observer = hs.axuielement.observer.new(app:pid())
--     observer:addWatcher(ax, hs.axuielement.observer.notifications.windowMoved)
--     observer:callback(function(_, axel, notif, _notifData)
--       local win = axel:asHSWindow()
--       print(hs.inspect(notif))
--       print(hs.inspect(_notifData))
--       print(hs.inspect(win))
--     end)
--     observer:start()

--     iTerm2.app = app
--     iTerm2.observer = observer
--   end

-- end):start()
