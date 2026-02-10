local game = {}

test1 = love.audio.newSource("assets/main_theme.mp3", "static")
playing = false

function game:enter()
    self.notes = {}
    screenwidth, screenheight = love.graphics.getDimensions()
    
    self.centerY = screenheight / 2 
    
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(20)
    love.window.setTitle("rhythm by wyv")
    
    self.speed = 200
    self.line_x = 110 
    self.spawn_x = screenwidth + 100

    local distance = self.spawn_x - self.line_x
    self.travelTime = distance / self.speed
    
    self.chart = require("songs/song1") 
    self.chartIndex = 1 
    self.musicTime = 0  
end

function game:spawnNote(type, offset)
    local note = {
       xc = self.spawn_x, 
       yc = self.centerY + offset, 
       type = type,
       active = true 
    }
    table.insert(self.notes, note)
end

function game:update(dt)
    if playing then 
        self.musicTime = test1:tell()
    end    

    while self.chartIndex <= #self.chart do
        local nextNote = self.chart[self.chartIndex]
        
        local spawnTime = nextNote.time - self.travelTime

        if self.musicTime >= spawnTime then
            self:spawnNote(nextNote.type, 0)   
            self.chartIndex = self.chartIndex + 1
        else
            break
        end
    end

    for i, note in ipairs(self.notes) do --speed
        note.xc = note.xc - (self.speed * dt)
    end

    for i = #self.notes, 1, -1 do --remove missed notes
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
    love.graphics.print("f = red, j = blue", 10, 10)
    
    for _, note in ipairs(self.notes) do --note maker
        if note.active then
            if note.type == "normalf" then
                love.graphics.setColor(1, 0.5, 0.5) --red
                love.graphics.circle("fill", note.xc, note.yc, 30) 
            elseif note.type == "normalj" then
                love.graphics.setColor(0.5, 0.5, 1) --blue
                love.graphics.circle("fill", note.xc, note.yc, 30) 
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end

function play1()
    love.audio.play(test1)
end

function game:checkHit(keyType)
    local closestDist = 999999
    local closestIndex = -1
    local hitWindow = 50 

    for i, note in ipairs(self.notes) do
        if note.type == keyType then
            local dist = math.abs(note.xc - self.line_x)
            
            if dist < closestDist then
                closestDist = dist
                closestIndex = i
            end
        end
    end

    if closestIndex ~= -1 and closestDist <= hitWindow then
        table.remove(self.notes, closestIndex)
        print("HIT " .. keyType)
    else
        print("MISS " .. keyType)
    end
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
        self:checkHit("normalf")
    elseif key == "j" then
        self:checkHit("normalj")
    end
end

return game