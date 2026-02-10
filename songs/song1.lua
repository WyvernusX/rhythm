vah = love.audio.newSource("assets/song1.mp3", "static")
vah:play()

return { --f is red, j is blue
    bpm = 150,
    notes = {
        {time = 2, offset = 200, type = "normalj"},
        {time = 5, offset = 200, type = "normalj"},
        {time = 7.5, offset = 200, type = "normalj"},
        {time = 10, offset = 200, type = "normalj"},
        {time = 12.5, offset = 200, type = "normalj"},
        {time = 15, offset = 200, type = "normalj"},
        {time = 17.5, offset = 200, type = "normalj"},
    }
}

--negative is up, down is positive
--2.5 beats per second :o
--collumn things heres