local settings = {}
setting_music = love.audio.newSource("assets/settings.mp3", "static")
setting_music:setLooping(true)
setting_music:play()

function settings:draw()
    love.graphics.setFont(small)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) 
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("settings", 0, 0)
    love.graphics.setFont(tiny)
    love.graphics.print("scroll speed", 0, 100) --//TODO add buttons eventually
    love.graphics.print("developer mode", 0, 150)
    love.graphics.print("keybinds", 0, 200)
end

function settings:keypressed(key) 
    if key == "escape" then
        statemanager.pop(require("settings"))
        statemanager.switch(require("menu"))
        setting_music:stop()
    elseif key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    end
end

return settings