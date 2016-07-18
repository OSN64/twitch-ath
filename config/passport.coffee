
 # Passport configuration
 #
 # This is the configuration for your Passport.js setup and it where you'd
 # define the authentication strategies you want your application to employ.
 #
 # Authentication scopes can be set through the `scope` property.
 #
 # For more information on the available providers, check out:
 # http://passportjs.org/guide/providers/

module.exports.passport =
    local:
        strategy: require('passport-local').Strategy

    twitch:
        name: 'twitch'
        protocol: 'oauth2'
        strategy: require('passport-twitch').Strategy
        options:
            clientID: 'XXXX'
            clientSecret: 'XXXXX'
            callbackURL: "http://example.com/auth/twitch/callback"
            scope: "user_read"
