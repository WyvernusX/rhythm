local game = {}

test1 = love.audio.newSource("assets/main_theme.mp3", "static")
playing = false

function game:enter()
    screenwidth, screenheight = love.graphics.getDimensions()
    x = screenwidth / 2
    y = screenheight / 2
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(20)
    love.window.setTitle("rhythm by wyv")
end

function newnotefirst()
    -- code to create a new note
end

function newnotesecond()
    -- code to select a note
end

function specialnoteone()
    -- code for special note one
end

function specialnotetwo()
    -- code for special note two
end

function game:draw()
    love.graphics.setFont(tiny)
    love.window.setTitle("rhythm by wyv")
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 100, screenheight / 2 - 250, 20, 500)
    --love.graphics.line(40, 40, 40, 1000, 60, 1000, 60, 40, 40, 40)
    love.graphics.print("imagine dots here lol", 10, 10)
    love.graphics.circle("fill", 1000, screenheight / 2, 30, 100)
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
        statemanager.pop(require("game"))
        statemanager.switch(require("pause"))
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