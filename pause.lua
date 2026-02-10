local pause = {}

function pause:draw()
    love.graphics.setColor(1, 1, 1) 
    love.graphics.printf("paused :o", 0, love.graphics.getHeight() / 2 - 20, love.graphics.getWidth(), "center")
end


function pause:keypressed(key)
    if key == "escape" then
        love.event.quit()
    elseif key == "return" then
        statemanager.pop(require("pause"))
        statemanager.switch(require("game"))
        vah:play()
    end
end

return pause