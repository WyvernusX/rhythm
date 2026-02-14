local pause = {}

function pause:draw()
    love.graphics.setColor(1, 1, 1) 
    love.graphics.printf("paused :o", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
end


function pause:keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "return" then
        statemanager.pop(require("pause"))
        statemanager.switch(require("game"))
        song:play()
    end
end

return pause