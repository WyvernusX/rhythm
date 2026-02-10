vah = love.audio.newSource("assets/song1.mp3", "static")
vah:play()

return { --f is red, j is blue
    bpm = 150,
    notes = {
        {time = 11.5, offset = 200, type = "normalj"},
        {time = 12.5, offset = 200, type = "normalj"},
        {time = 13.5, offset = 200, type = "normalj"},
        {time = 15, offset = 200, type = "normalj"},
        {time = 16, offset = 200, type = "normalj"},
        {time = 17.5, offset = 200, type = "normalj"},
        {time = 18.5, offset = 200, type = "normalj"},
        {time = 17, offset = -200, type = "normalf"},
        {time = 20, offset = -80 , type = "normalf"},
        {time = 21, offset = -140 , type = "normalf"},
        {time = 22, offset = -80, type = "normalf"},
        {time = 24, offset = -200, type = "normalj"}, --potenital specials these two below!!
        {time = 25, offset = -140, type = "normalj"},
        {time = 27, offset = -80, type = "normalf"},
        {time = 28, offset = -140, type = "normalf"},
        {time = 29, offset = -80, type = "normalf"},
        {time = 30, offset = -140, type = "normalf"},
        {time = 31, offset = -80, type = "normalj"},
        {time = 31.5, offset = -140, type = "normalj"},
        {time = 32.5, offset = -80, type = "normalj"},


    }
}


--negative is up, down is positive
--2.5 beats per second :o
--collumn things heres