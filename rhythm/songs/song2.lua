song = love.audio.newSource("assets/song2.mp3", "static")
song:play()
song2duration = song:getDuration()

return { --f is red, j is blue, special d and special k
    bpm = 114, --1.9 bps
    notes = {
        {time = 1, offset = 200, type = "speciald", note_duration = 0},
        {time = 1.5, offset = 200, type = "speciald", note_duration = 0},
        {time = 2, offset = -200, type = "normalf", note_duration = 0},
        {time = 2.5, offset = -140, type = "normalj", note_duration = 0},
        {time = 7, offset = 200, type = "speciald", note_duration = 0},
        {time = 8, offset = 200, type = "speciald", note_duration = 0},
        {time = 8.5, offset = -200, type = "normalf", note_duration = 0},
        {time = 9, offset = -140, type = "normalj", note_duration = 0},
        {time = 11, offset = 200, type = "speciald", note_duration = 0},
        {time = 11.5, offset = 200, type = "speciald", note_duration = 0},
        {time = 12, offset = -200, type = "normalf", note_duration = 0},
        {time = 12.5, offset = -140, type = "normalj", note_duration = 0},
        {time = 15.5, offset = -200, type = "speciald", note_duration = 0},
        {time = 16, offset = -140, type = "normalf", note_duration = 0},
        {time = 16.6, offset = -80, type = "normalj", note_duration = 0},
    }
}