image = love.graphics.newImage("image.png")

function love.load()
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(20)
end

function love.draw()
    love.window.setTitle("rhythm by wyv")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.line(40, 40, 40, 1000, 60, 1000, 60, 40, 40, 40)
    love.graphics.print("Press F to toggle fullscreen, ESC to quit.", 10, 10)
    -- love.graphics.draw(image, 100, 100)
end

function love.keypressed(key)
    if key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "escape" then
        love.event.quit()
    end
end