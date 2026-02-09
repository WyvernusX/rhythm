local menu = {}
local cat = love.graphics.newImage("assets/image.png")

function menu:enter()
    screenwidth, screenheight = love.graphics.getDimensions()
    x = screenwidth / 2
    y = screenheight / 2
    main_theme = love.audio.newSource("assets/main_theme.mp3", "static")
    love.window.setTitle("rhythm by wyv")
    large = love.graphics.newFont("assets/font1.otf", 100)
    medium = love.graphics.newFont("assets/font1.otf", 80)
    small = love.graphics.newFont("assets/font1.otf", 50)
    tiny = love.graphics.newFont("assets/font1.otf", 30)
    love.audio.play(main_theme)
    love.audio.setVolume(0.25)
    playing = true
    click = love.audio.newSource("assets/click.mp3", "static")
    main_theme:setLooping(true)
end 

function menu:draw()
    local text = "by wyv"
    local rotation = math.rad(-20)
    local textWidth = tiny:getWidth(text)
    local textHeight = tiny:getHeight()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setFont(medium)
    love.graphics.printf('rhythm', 10, 40, screenwidth, 'center')
    love.graphics.setFont(tiny)
    love.graphics.print(text, x + 200, 160, rotation, 1, 1, textWidth / 2, textHeight / 2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", x - 250, y - 100, 500, 100)
    love.graphics.rectangle("fill", x - 250, y + 20, 500, 100)
    love.graphics.rectangle("fill", x - 250, y + 140, 500, 100)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(small)
    love.graphics.printf('play', x - 250, y - 75, 500, 'center')
    love.graphics.printf('settings', x - 250, y + 45, 500, 'center')
    love.graphics.printf('exit', x - 250, y + 165, 500, 'center')
end

function menu:keypressed(key)
    if key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "escape" then
        love.event.quit()
    elseif key == "space" then
        if playing ~= true then
            love.audio.play(main_theme)
            playing = true
        else
            love.audio.pause(main_theme)
            playing = false
        end
    end
end

function menu:mousepressed(mouseX, mouseY, button, istouch)
    if button == 1 then 
        love.audio.play(click) 
        if mouseX >= x - 250 and mouseX <= x + 250 and
           mouseY >= y - 100 and mouseY <= y then
            statemanager.pop(require("menu"))      
            statemanager.switch(require("levelselection"))
            main_theme:stop()
        elseif mouseX >= x - 250 and mouseX <= x + 250 and
               mouseY >= y + 20 and mouseY <= y + 120 then
            statemanager.pop(require("menu"))
            statemanager.switch(require("settings"))
        elseif mouseX >= x - 250 and mouseX <= x + 250 and 
               mouseY >= y + 140 and mouseY <= y + 240 then
            love.event.quit()
        end
    end
end

return menu