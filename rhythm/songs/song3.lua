song = love.audio.newSource("assets/song3.mp3", "static")
song:play()
song3duration = song:getDuration()

return {
  bpm = 150,
  notes = {
    {time = 3, offset = 200, type = "normalf", note_duration = 0},
    {time = 3, offset = 140, type = "normalj", note_duration = 0},
    {time = 3, offset = 80, type = "speciald", note_duration = 0},
    {time = 3, offset = 20, type = "specialk", note_duration = 0},  
  }
}
