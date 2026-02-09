local settings = {}

function settings:draw()
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
end

function settings:keypressed(key) 
    if key == "escape" then
        statemanager.pop(require("settings"))
        statemanager.switch(require("menu"))
    elseif key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    end
end

return settings