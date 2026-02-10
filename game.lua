local game = {}

test1 = love.audio.newSource("assets/main_theme.mp3", "static")
playing = false

function game:enter()
    self.notes = {}
    screenwidth, screenheight = love.graphics.getDimensions()
    
    x = screenwidth / 2
    y = screenheight / 2
    
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(20)
    love.window.setTitle("rhythm by wyv")

    self.speed = 200
    
    self.line_x = 110 
    
    self:spawnNote("first", 0)
end

function game:spawnNote(type, offset)
    local note = {
       xc = screenwidth + 100, 
       yc = (y / 2) + offset, 
       type = type,
       active = true 
    }
    table.insert(self.notes, note)
end

function game:update(dt)
    for i, note in ipairs(self.notes) do
        note.xc = note.xc - (self.speed * dt)
    end

    for i = #self.notes, 1, -1 do --the missed note remove here!
        if self.notes[i].xc < -50 then
            table.remove(self.notes, i)
            print("Missed note (went off screen)")
        end
    end
end

function game:draw()
    love.graphics.setFont(tiny)
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 100, screenheight / 2 - 250, 20, 500)
    love.graphics.print("Press F to hit!", 10, 10)
    for _, note in ipairs(self.notes) do
        if note.active then
            love.graphics.setColor(0.5, 0.5, 1) 
            love.graphics.circle("fill", note.xc, note.yc, 30)
        end
    end
    love.graphics.setColor(1, 1, 1)
end

function play1()
    love.audio.play(test1)
end

function game:keypressed(key)
    if key == "backspace" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
        
    elseif key == "escape" then
        if statemanager then
            statemanager.pop() 
            statemanager.switch(require("pause"))
        end
        
    elseif key == "space" then
        if playing ~= true then
            play1()
            playing = true
        else
            love.audio.stop(test1)
            playing = false
        end
    end


    if key == "f" then
        local closestDist = 999999
        local closestIndex = -1
        local hitWindow = 50 


        for i, note in ipairs(self.notes) do
            local dist = math.abs(note.xc - self.line_x)
            
            if dist < closestDist then
                closestDist = dist
                closestIndex = i
            end
        end


        if closestIndex ~= -1 and closestDist <= hitWindow then
            --success!!
            table.remove(self.notes, closestIndex)
            self:spawnNote("random", 0) 
        else
            --miss go here
        end
    end
end

return game