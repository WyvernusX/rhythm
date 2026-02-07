function love.load()
    screenwidth, screenheight = love.graphics.getDimensions()
    x = screenwidth / 2
    y = screenheight / 2
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setColor(1, 1, 1)
    main_theme = love.audio.newSource("main_theme.mp3", "static")
    love.window.setTitle("rhythm by wyv")
    test1 = love.audio.newSource("music.mp3", "static")
    large = love.graphics.newFont("font1.otf", 100)
    medium = love.graphics.newFont("font1.otf", 80)
    small = love.graphics.newFont("font1.otf", 50)
    tiny = love.graphics.newFont("font1.otf", 30)
end    

function play1()
    love.audio.play(main_theme)
end

function love.draw()
    play1()
    love.graphics.setFont(medium)
    love.graphics.printf('rhythm', 10, 40, screenwidth, 'center')
    love.graphics.setFont(tiny)
    love.graphics.printf('by wyv', 10, 135, screenwidth, 'center')
    love.graphics.rectangle("fill", x - 250, y - 100, 500, 100)
    love.graphics.rectangle("fill", x - 250, y + 20, 500, 100)
    love.graphics.rectangle("fill", x - 250, y + 140, 500, 100)
end

function love.keypressed(key)
    if key == "f" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "escape" then
        love.event.quit()
    --[[ elseif key == "space" then
        if playing ~= true then
            play1()
            playing = true
        else
            love.audio.stop(test1)
            playing = false
        end --]]
    end
end