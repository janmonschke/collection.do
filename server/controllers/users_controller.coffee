Controller = require('./controller')
User = require('../models/user')
Collection = require('../models/collection')

class UserController extends Controller
  before: ->
    'me' : @loginIfNotLoggedIn

  register: (req, res) ->
    data =
      username: req.body.username,
      email: req.body.email

    password = req.body.password

    User.createWithPassword data, password, (err, user) ->
      # something went wrong
      if err or !user
        res.redirect('/register')
      else
        # user successfully created, log it in and redirect
        req.login user, (err) ->
          return res.redirect('/register') if err
          res.redirect('/me')

  me: (req, res) ->
    res.render 'user'

module.exports = UserController