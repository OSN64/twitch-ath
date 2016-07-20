

module.exports = (req, res, next) ->

    if req.isSocket
        return next()
    else
        return res.notSocket()
