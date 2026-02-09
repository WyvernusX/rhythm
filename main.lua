statemanager = require("statemanager")
local menu = require("menu")

function love.window()
    statemanager.window()
end

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

function love.keypressed(key)
    if statemanager.current() and statemanager.current().keypressed then
        statemanager.current():keypressed(key)
    end
end