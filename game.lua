local game = {}

test1 = love.audio.newSource("assets/main_theme.mp3", "static")

function game:enter()
    self.notes = {}
    screenwidth, screenheight = love.graphics.getDimensions()
    
    self.centerY = screenheight / 2 
    
    love.graphics.setLineStyle("rough")
    love.graphics.setLineWidth(20)
    love.window.setTitle("rhythm by wyv")

    local chartData = require("songs/song1")
    self.bpm = chartData.bpm
    self.chart = chartData.notes
    self.chartIndex = 1
    self.secondsPerBeat = 60/ self.bpm
    
    self.speed = 400
    self.line_x = 110 
    self.spawn_x = screenwidth + 100

    local distance = self.spawn_x - self.line_x
    self.travelTime = distance / self.speed
    self.timer = 0
end

function game:spawnNote(type, offset)
    local safeOffset = offset or 0
    
    local note = {
       xc = self.spawn_x, 
       yc = self.centerY + safeOffset,
       type = type,
       active = true 
    }
    table.insert(self.notes, note)
end

function game:update(dt)

    self.timer = self.timer + dt

    while self.chartIndex <= #self.chart do
        local nextNote = self.chart[self.chartIndex]
        local noteTime = nextNote.time * self.secondsPerBeat

        local spawnTime = noteTime - self.travelTime
        if self.timer >= spawnTime then
            self:spawnNote(nextNote.type, nextNote.offset)
            self.chartIndex = self.chartIndex + 1
        else
            break
        end
    end

    for i, note in ipairs(self.notes) do 
        note.xc = note.xc - (self.speed * dt)
    end

    for i = #self.notes, 1, -1 do 
        if self.notes[i].xc < -50 then
            table.remove(self.notes, i)
            --miss
        end
    end
end

function game:draw()
    love.graphics.setFont(tiny)
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 100, screenheight / 2 - 250, 20, 500)
    love.graphics.print("d = green, f = red, j = blue, k = yellow", 10, 10)
    
    for _, note in ipairs(self.notes) do 
        if note.active then
            if note.type == "normalf" then
                love.graphics.setColor(1, 0.5, 0.5) -- red
            elseif note.type == "normalj" then
                love.graphics.setColor(0.5, 0.5, 1) -- blue
            elseif note.type == "speciald" then
                love.graphics.setColor(0.5, 1, 0.5) -- green
            elseif note.type == "specialk" then
                love.graphics.setColor(1, 1, 0.5) -- yellow
            end
            
            love.graphics.circle("fill", note.xc, note.yc, 30) 
        end
    end
    love.graphics.setColor(1, 1, 1)
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
        --hit
    else
        --miss
    end
end

function game:keypressed(key)
    if key == "backspace" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
        
    elseif key == "escape" then
        if statemanager then
            statemanager.pop() 
            vah:stop()
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
    elseif key == "d" then
        self:checkHit("speciald")
    elseif key == "k" then
        self:checkHit("specialk")
    end
end

return game