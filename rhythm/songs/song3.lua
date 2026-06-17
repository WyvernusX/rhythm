song = love.audio.newSource("assets/song3.mp3")
song3duration = song:getDuration()

return {
  bpm = 150,
  notes = {
    {time = 9.5, offset = 200, type = "speciald", note_duration = 0},   
  }
}
