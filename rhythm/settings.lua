local settings = {}
setting_music = love.audio.newSource("assets/settings.mp3", "static")
setting_music:setLooping(true)
setting_music:play()
scrollspeed = 2

function settings:draw()
    love.graphics.setFont(small)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight()) 
    love.graphics.setColor(1, 1, 1)
    love.graphics.print("settings", 0, 0)
    love.graphics.setFont(tiny)
    love.graphics.print("scroll speed", 0, 100) --//TODO add buttons eventually
    love.graphics.print("developer mode", 0, 150)
    love.graphics.print("keybinds", 0, 200) --//TODO  button with listener i think
    love.graphics.setColor(0, 0, 0)
    love.graphics.print(scrollspeed, 280, 100)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 220, 100, 40, 40)
    love.graphics.rectangle("fill", 280, 100, 60, 40)
    love.graphics.rectangle("fill", 360, 100, 40, 40)
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

function settings:mousepressed(mouseX, mouseY, button, istouch)
    love.audio.play(click) 
    if mouseX >= x - 220 and mouseX <= x + 220 and
       mouseY >= y - 100 and mouseY <= y then
        scrollspeed = scrollspeed + 0.1
    elseif mouseX >= 280 and mouseX <= x + 280 and
        mouseY >= y -100 and mouseY <= y then
        scrollspeed = scrollspeed - 0.1
    end
end

return settings
