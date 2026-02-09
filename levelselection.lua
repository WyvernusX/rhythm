levelselection = {}

function levelselection:enter()
    click = love.audio.newSource("click.mp3", "static")
    love.graphics.setLineStyle("rough")
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.setFont(small)
    screenwidth, screenheight = love.graphics.getDimensions()
    x = screenwidth / 2
    y = screenheight / 2
end

function levelselection:draw()
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setColor(0.2, 0.2, 0.2)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.window.setTitle("rhythm by wyv")
    love.graphics.setColor(1, 1, 1)
    love.graphics.printf("level selection screen",0, 0, 0,"right")
    --love.graphics.printf("level selection screen", x - 250, y - 75, 10,"right")
    love.graphics.setColor(0, 0, 0)
    love.graphics.rectangle("fill", screenwidth - 500, 100, 500, 100)
    --[[ love.graphics.rectangle("fill", screenwidth - 500, 250, 500, 100)
    love.graphics.rectangle("fill", screenwidth - 500, 400, 500, 100)
    love.graphics.rectangle("fill", screenwidth - 500, 550, 500, 100)
    love.graphics.rectangle("fill", screenwidth - 500, 700, 500, 100)
    love.graphics.rectangle("fill", screenwidth - 500, 850, 500, 100)
    love.graphics.rectangle("fill", screenwidth - 500, 1000, 500, 100) ]]--
end

function levelselection:mousepressed(mouseX, mouseY, button, istouch)
    click:play()
    if button == 1 then
        if mouseX >= screenwidth - 500 and mouseX <= screenwidth and mouseY >= 100 and mouseY <= 200 then
            statemanager.pop(require("menu"))
            statemanager.pop(require("levelselection"))
            statemanager.switch(require("game"))
        end
    end
end

function levelselection:keypressed(key)
    if key == "escape" then
        statemanager.pop(require("levelselection"))
        statemanager.switch(require("menu"))
    elseif key == "arrowdown" then
        -- go down
    elseif key == "arrowup" then
        -- go up
    elseif key == "enter" then
        statemanager.switch(require("game"))
        statemanager.pop(require("levelselection"))
        statemanager.pop(require("menu"))
    elseif key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    end
end

return levelselection