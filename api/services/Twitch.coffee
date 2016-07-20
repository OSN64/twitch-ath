
twitchTimers = {}
debugTick = 0
module.exports =

    callback: (user) ->

        # sails.sockets.broadcast sails.sockets.getId(req), 'MSG'

        startTimer = (time, obj) =>
            followers = 0
            interval = setInterval () =>
                console.log('runing interval')
                # new followers
                sails.sockets.broadcast obj.user.authID, 'zxz', a: 'Testing coffee'
                # return unless debugTick < 3

                sails.twitch.getChannelFollows(obj.user.twitchJson.display_name, {limit: 30}, (err, data) ->
                  return console.log(err) if err
                  # debug
                #   data._total = followers + 5
                #   data.follows = []
                #   for  in [start..finish] by step
                    # body...

                  console.log(followers, data)
                  if data._total isnt followers# and followers > 0
                    #   sails.sockets.broadcast obj.user.authID, 'zxz', a: 'Testing coffee'
                      newFollowers = data._total - followers
                      if newFollowers > 0
                          sails.sockets.broadcast obj.user.authID, 'new-follow', users: data.follows.slice(0, newFollowers)

                  followers = data._total
                #   followers++ # DEBUG
                )
                # sails.twitch.getChannelStream(obj.user.twitchJson.display_name, (err, stream) ->
                #     return if err
                    # if streaming lastStream == null
                    # if not straeaming check if lastStream != null check if the current time is 1 hour > stream
                    #     kill self
                    # else if lastStream is empty then last stream == now
                    # if
                    # console.log(arguments)
                # )
                # if user is not streaming kill interval
                return interval

                # subscribers timer for new subs
            , time

        twitchTimers[user.id] ?= {}
        twitchTimers[user.id]['followers'] = startTimer( 15000 , {
            user: user
        })
