song = love.audio.newSource("assets/song1.mp3", "static")
song:play()
song1duration = song:getDuration()

return {
    bpm = 67,
    notes = [
       {time = 0, offset = 0, note_type = "normalf", note_duration = 0}
    ]
}