levelselection = {}

function levelselection:enter()
    love.graphics.setLineStyle("rough")
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(small)
end

function levelselection:draw()
    love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.rectangle("fill", 0, 0, love.graphics.getWidth(), love.graphics.getHeight())
    love.window.setTitle("rhythm by wyv")
    love.graphics.print("level selection screen", 10, 10)
end

function levelselection:keypressed(key)
    if key == "escape" then
        statemanager.pop(require("levelselection"))
        statemanager.switch(require("menu"))
    end
end

return levelselection