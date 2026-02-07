image = love.graphics.newImage("image.png")
test1 = love.audio.newSource("music.mp3", "static")
playing = false

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

function play1()
    love.audio.play(test1)
end

function love.keypressed(key)
    if key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "escape" then
        love.event.quit()
    elseif key == "space" then
        if playing ~= true then
            play1()
            playing = true
        else
            love.audio.stop(test1)
            playing = false
        end
    end
end