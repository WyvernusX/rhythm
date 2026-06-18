song = love.audio.newSource("assets/song3.mp3", "static")
song:play()
song3duration = song:getDuration()

return {
  bpm = 150,
  notes = {
    {time = 3, offset = 200, type = "normalf", note_duration = 0},
  }
}
