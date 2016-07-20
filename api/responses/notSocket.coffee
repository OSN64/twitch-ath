
 # 403 (Forbidden) Handler
 #
 # Usage:
 # return res.forbidden()
 # return res.forbidden(err)
 # return res.forbidden(err, 'some/specific/forbidden/view')
 #
 # e.g.:
 # ```
 # return res.forbidden('Access denied.')
 # ```

module.exports = notSocket = (data, options) ->

    # Get access to `req`, `res`, & `sails`
    req = this.req
    res = this.res
    sails = req._sails

    # Set status code
    res.status(400)

    # Log error to console
    if data != undefined
        sails.log.verbose('Sending ("Not socket") response: \n',data)

    else
        sails.log.verbose('Sending ("Not socket") response')

    # TODO convert
    # options = (typeof options === 'string') ? { view: options } : options || {}
    options = options || {}

    if options.view
        return res.view options.view, { data: data }
    else
        return res.view 'notSocket', { data: data }, (err, html) ->

    # If a view error occured, fall back to JSON(P).
            if err
                #
                # Additionally:
                # • If the view was missing, ignore the error but provide a verbose log.
                if err.code == 'E_VIEW_FAILED'
                    sails.log.verbose('res.forbidden() :: Could not locate view for error page (sending JSON instead).  Details: ',err)

                # Otherwise, if this was a more serious error, log to the console with the details.
                else
                    sails.log.warn('res.forbidden() :: When attempting to render error page view, an error occured (sending JSON instead).  Details: ', err)

                return res.jsonx(data)

            return res.send(html)
