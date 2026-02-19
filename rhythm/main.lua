statemanager = require("statemanager")
icon = love.image.newImageData("assets/rhythm.png")
love.window.setIcon(icon)
local menu = require("menu")
local cat = love.graphics.newImage("assets/image.png")
devmode = false

function love.load()
    love.window.setTitle("loading...")
    statemanager.switch(menu)
end

function love.update(dt)
    statemanager.update(dt)
end

function love.draw()
    statemanager.draw()
end

function love.mousepressed(x, y, button)
    statemanager.mousepressed(x, y, button)
end

function love.update(dt)
    statemanager.update(dt)
end

function love.keypressed(key)
    if statemanager.current() and statemanager.current().keypressed then
        statemanager.current():keypressed(key)
    end
end