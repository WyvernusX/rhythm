image = love.graphics.newImage("image.png")

function love.draw()
    love.graphics.draw(image, 1, 1)
end

function love.keypressed(key)
    if key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "escape" then
        love.event.quit()
    end
end