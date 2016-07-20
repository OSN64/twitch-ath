_c =
  File: # Resources object
    sound: 0 # audio#follow-audio
    image: 0 # img#follow-image

  Timer:
    AudioMax: 0

$(document).ready ->
  console.info "[!] Starting.."
  authID = location.pathname.split('/').slice(-1).join() || 'none'
  zurl = "http://pe.s.co:50/socket/register" # Init socket connection

  if document.location.hostname is 'localhost'
    console.log "[!] Connecting to localhost, auth ID is %s", authID
    zurl = "http://localhost:50/socket/register" # Yay for all de bugs..
  
  io.sails.connect()
  #io.sails.autoConnect = true

  io.socket.on 'disconnect', ->
    console.warn "[*] Socketio Disconnected."

  io.socket.on 'connect', -> # On socket connection...
    # We prob want to preload/cache resources here?

    io.socket.get zurl, { authID: authID }, (res, raw) ->
      console.log "Got reply for socket register!", res

    # This route could return a html page that includes all the resources this user has defined (images, sounds etc)
    io.socket.get '/socket/follow/preload', (res, raw) ->
      return 0 unless res?

      if res.audio?
        _c.File.sound = $('audio#follow-audio')
        _c.File.sound.setAttribute 'src', res.audio
        _c.File.sound.setAttribute 'autoplay', 'false'
        _c.File.soundMax = res.audioMax ? 8000 # Max duration to play audio

      if res.image?
        _c.File.image = $('img#follow-image')
        _c.File.image.setAttribute 'src', res.image
        _c.File.imageDelay = res.imageDelay ? 8000 # Show img this long before starting fade-out
        _c.File.imageAnimation = res.imageAnimation ? 4200 # Duration fade-out/in takes

  io.socket.on 'new-follow', (data) -> # New follower  
    console.log "[*] Got a new follower", data
    
    if _c.File.sound.paused()
      # Only play audio if not already...
      clearTimeout Timer.AudioMax
      _c.File.sound.play()

    $('#follow').fadeIn _c.File.imageAnimation, ->
      setTimeout( -> # Wait before starting fade-out sequence
        $('#follow').fadeOut _c.File.imageAnimation
      , _c.File.imageDelay)

      Timer.AudioMax = setTimeout(
        _c.File.sound.stop()
      , _c.File.soundMax)
    return
      
  io.socket.on 'zxz', (d) ->
    console.log "[zxz]", d
    #alert d
    return
