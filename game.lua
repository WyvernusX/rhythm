local game = {}

test1 = love.audio.newSource("main_theme.mp3", "static")
playing = false

function game:enter()
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(20)
end

function game:draw()
    love.graphics.setFont(tiny)
    love.window.setTitle("rhythm by wyv")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 40, 40, 20, 500)
    --love.graphics.line(40, 40, 40, 1000, 60, 1000, 60, 40, 40, 40)
    love.graphics.print("imagine dots here lol", 10, 10)
    -- love.graphics.draw(image, 100, 100)
end

function play1()
    love.audio.play(test1)
end

function game:keypressed(key)
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

return game