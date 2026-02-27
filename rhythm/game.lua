local game = {}

function game:enter()
    self.notes = {}
    screenwidth, screenheight = love.graphics.getDimensions()
    self.centerY = screenheight / 2 
    local chartData = require("songs/song1") --//TODO change this to scale based off level selected, w a variable AND the pause menu
    self.bpm = chartData.bpm 
    self.chart = chartData.notes
    self.chartIndex = 1
    self.secondsPerBeat = 60 / self.bpm
    self.line_x = 110 
    self.spawn_x = screenwidth + 100
    local distance = self.spawn_x - self.line_x
    local approachTime = scrollspeed  -- base speed
    self.speed = distance / approachTime --scroll speed
    self.travelTime = distance / self.speed --dont touch this or your die
    self.timer = -self.travelTime
    self.musicStarted = false
    self.duration = 0
    self.isHeld = false
    local printb = 0
end

function game:spawnNote(type, offset, note_duration)
    local safeOffset = offset or 0
    local note = {
       xc = self.spawn_x, 
       yc = self.centerY + safeOffset,
       type = type,
       note_duration = hold_time,
       active = true --//TODO add long note tails eventually
    }
    table.insert(self.notes, note)
end

function game:update(dt)
    if song:tell() >= song:duration + 10 then
        statemanager.pop("game")
        statemanager.switch(require("endscreen"))
        song:stop()
    end 
    if not self.musicStarted then
        self.timer = self.timer + dt
        if self.timer >= 0 then
            self.musicStarted = true
        end
    else
        self.timer = song:tell() 
    end

    while self.chartIndex <= #self.chart do
        local nextNote = self.chart[self.chartIndex]
        local noteTime = nextNote.time * self.secondsPerBeat
        local spawnTime = noteTime - self.travelTime
        
        if self.timer >= spawnTime then
            self:spawnNote(nextNote.type, nextNote.offset, nextNote.duration)
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
        end
    end

    if love.keyboard.isDown("f", "j") then
        self.duration = self.duration + dt
    else 
        self.duration = 0
    end
end

function game:draw()
    love.graphics.setFont(tiny)
    love.graphics.setBackgroundColor(0.2, 0.2, 0.2)
    
    love.graphics.setColor(1, 1, 1)
    love.graphics.rectangle("fill", 100, screenheight / 2 - 250, 20, 500)
    love.graphics.print("d = green, f = red, j = blue, k = yellow", 10, 10)
    love.graphics.print(song:tell(), 500, 550)
    --[[while true do
        love.timer.sleep(1)
        printb = printb + 2.5
    end]]--
    --//TODO finish this stuff
    love.graphics.print('bpm', 10, 550)
    --love.graphics.print(self.duration, 10, 50)
    
    for _, note in ipairs(self.notes) do 
        if note.active then
            if note.type ~= "holdf" and note.type ~= "holdj" then 
                if note.type == "normalf" then
                    love.graphics.setColor(1, 0.5, 0.5) -- red
                    love.graphics.circle("fill", note.xc, note.yc, 30) 
                elseif note.type == "normalj" then
                    love.graphics.setColor(0.5, 0.5, 1) -- blue
                    love.graphics.circle("fill", note.xc, note.yc, 30) 
                elseif note.type == "speciald" then
                    love.graphics.setColor(0.5, 1, 0.5) -- green
                    love.graphics.circle("fill", note.xc, note.yc, 30) 
                elseif note.type == "specialk" then
                    love.graphics.setColor(1, 1, 0.5) -- yellow
                    love.graphics.circle("fill", note.xc, note.yc, 30) 
                end
            elseif note.type == "holdf" or note.type == "holdj" then
                if note.type == "holdf" then
                    love.graphics.setColor(1, 0.5, 0.5) -- red
                    love.graphics.circle("fill", note.xc, note.yc, 30) 
                    --love.graphics.circle("line", note.xc, note.yc + note.hold_time * 2.5, 30) 
                elseif note.type == "holdj" then
                    love.graphics.setColor(0.5, 0.5, 1) -- blue
                    love.graphics.circle("fill", note.xc, note.yc, 30) 
                    --love.graphics.circle("line", note.xc, note.yc + note.hold_time * 2.5, 30)  --EVENTUALLY DIFFERENTIATE BETWEEN THE HOLD NAMES!!!!
                end
            end
        end
    end
    love.graphics.setColor(1, 1, 1)
end

function game:checkHit(keyType)
    local closestDist = 999999
    local closestIndex = -1 -- range is ~900 or 800 idk twin, add formula maybe??
    if self.speed >= 850 then --if u delete ts then ts breaks
        hitWindow = 150 
    else
         hitWindow = 50 
    end

    for i, note in ipairs(self.notes) do
        if note.type == keyType then
            local dist = math.abs(note.xc - self.line_x)
            if dist < closestDist then
                closestDist = dist
                closestIndex = i
            end
        end
    end

    if closestIndex ~= -1 and closestDist <= hitWindow then --get rid of old notes
        local hitNote = self.notes[closestIndex]
        
        if hitNote.type == "holdf" or hitNote.type == "holdj" then
            self.isHeld = true
            hitNote.xc = self.line_x
            if self.duration == hitNote.hold_time then
                self.isHeld = true
                table.remove(self.notes, closestIndex) 
                self.isHeld = false --//FIXME make this work :/
            end
        else
            table.remove(self.notes, closestIndex) 
        end
    end
end

function game:keypressed(key)
    if key == "backspace" then
        local isFullscreen = love.window.getFullscreen()
        love.window.setFullscreen(not isFullscreen, "desktop")
    elseif key == "escape" then
        if statemanager then
            statemanager.pop() 
            love.audio.stop(song)
            statemanager.switch(require("pause"))
        end 
    elseif key == "1" then
        --if devmode == true then
            song:seek(song:tell() - 5)
        --end
    elseif key == "2" then
        --if devmode == true then
            song:seek(song:tell() + 5)
        --end
    elseif key == "f" then
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
