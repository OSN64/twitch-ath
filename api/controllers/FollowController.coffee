
module.exports =

    index: (req, res) ->
      User.findOne(
        authID: req.param('authID')
      ).then((user) ->
          return res.redirect('/') if _.isEmpty(user)

          res.view '',
              layout: false

      ).catch(res.serverError)

     preload: (req, res) ->
        res.json
            # audio: 'httopsad'
            audioMax: 10000
            # image: '/path/img'
            imageDelay: 1000
            imageAnimation: 1000
