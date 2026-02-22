local endscreen = {}

function endscreen:draw()
    love.window.setTitle('rhythm by wyv')
end

function endscreen:draw()
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(tiny)
    love.graphics.printf("placeholder", screenwidth / 2 - 100, screenheight / 2 - 20, 500, "center")
end

return endscreen