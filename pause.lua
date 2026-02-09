local pause = {}

function pause:keypressed(key)
    if key == "escape" then
        love.event.quit()
    end
end

return pause