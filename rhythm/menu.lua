local menu = {}
local cat = love.graphics.newImage("assets/image.png")

function menu:enter()
    love.keyboard.setTextInput(false) 
    love.window.setIcon(icon)
    screenwidth, screenheight = love.graphics.getDimensions()
    x = screenwidth / 2
    y = screenheight / 2
    main_theme = love.audio.newSource("assets/main_theme.mp3", "static")
    love.window.setTitle("rhythm by wyv")
    large = love.graphics.newFont("assets/font2.ttf", 100)
    medium = love.graphics.newFont("assets/font2.ttf", 80)
    small = love.graphics.newFont("assets/font2.ttf", 50)
    tiny = love.graphics.newFont("assets/font2.ttf", 30)
    background = love.graphics.newImage("assets/climb.jpg")
    love.audio.play(main_theme)
    love.audio.setVolume(0.25)
    playing = true
    click = love.audio.newSource("assets/click.mp3", "static")
    hover = love.audio.newSource("assets/hover.wav", "static")
    main_theme:setLooping(true)
    self.hovered = nil
end 

function menu:mousemoved(mx, my, dx, dy, istouch)
    local previous = self.hovered

    if mx >= x - 350 and mx <= x - 350 + 400 and
           my >= y - 100 and my <= y then
        self.hovered = 1
    elseif mx >= x - 350 and mx <= x - 350 + 400 and
            my >= y + 20 and my <= y + 20 + 100 then
        self.hovered = 2
    elseif mx >= x - 350 and mx <= x - 350 + 400 and
            my >= y + 140 and my <= y + 140 + 100 then
        self.hovered = 3
    else
        self.hovered = nil
    end

    if self.hovered ~= previous and self.hovered ~= nil then
        hover:setPitch(0.95 + math.random() * 0.1)
        hover:stop()
        hover:seek(0)
        hover:play()
    end
end

function menu:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setFont(medium)
    love.graphics.draw(background, 0, 0)
    love.graphics.setColor(56/255, 186/255, 238/255)
    love.graphics.printf('rhythm', 47, 40, screenwidth, 'left')
    love.graphics.setFont(tiny)
    love.graphics.setColor(0, 0, 0)
    love.graphics.printf("by wyv", 50, 130, screenwidth, "left")
    love.graphics.rectangle("fill", x - 350, y - 100, 400, 100)
    love.graphics.rectangle("fill", x - 350, y + 20, 400, 100)
    love.graphics.rectangle("fill", x - 350, y + 140, 400, 100)

    if self.hovered == 1 then
        love.graphics.setColor(56/255, 186/255, 238/255)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.rectangle("fill", x - 320, y - 80, 20, 60)

    if self.hovered == 2 then
        love.graphics.setColor(56/255, 186/255, 238/255)
    else
        love.graphics.setColor(1, 1, 1)
    end
    love.graphics.rectangle("fill", x - 320, y + 40, 20, 60)

    if self.hovered == 3 then
        love.graphics.setColor(56/255, 186/255, 238/255)
    else
        love.graphics.setColor(1, 1, 1)
    end

    love.graphics.rectangle("fill", x - 320, y + 160, 20, 60)
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(small)
    love.graphics.printf('play', x - 250, y - 85, 500, 'left')
    love.graphics.printf('settings', x - 250, y + 40, 500, 'left')
    love.graphics.printf('exit', x - 250, y + 160, 500, 'left')
end

function menu:keypressed(key)
    if key == "escape" then
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
        if mouseX >= x - 350 and mouseX <= x - 350 + 400 and
           mouseY >= y - 100 and mouseY <= y then
            statemanager.pop(require("menu"))
            statemanager.switch(require("levelselection"))
            main_theme:stop()
        elseif mouseX >= x - 350 and mouseX <= x - 350 + 400 and
               mouseY >= y + 20 and mouseY <= y + 20 + 100 then
            statemanager.pop(require("menu"))
            statemanager.switch(require("settings"))
            main_theme:stop()
        elseif mouseX >= x - 350 and mouseX <= x - 350 + 400 and
               mouseY >= y + 140 and mouseY <= y + 140 + 100 then
            love.event.quit()
        end
    end
end

return menu
