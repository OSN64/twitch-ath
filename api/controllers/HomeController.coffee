 # HomeController
 #
 # @description :: Server-side logic for managing homes
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers
 #

module.exports =

  index: (req, res) ->
    res.view('homepage')
