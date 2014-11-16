Controller = require('./controller')
User = require('../db').models.User
Collection = require('../models/collection')

class UserController extends Controller
  before: ->
    'me' : @loginIfNotLoggedIn

  register: (req, res) ->
    data =
      name: req.body.username,
      email: req.body.email

    password = req.body.password
    create = User.createWithPassword(data, password)

    create.error (user) ->
      # something went wrong
      res.redirect('/register')

    create.then (user) ->
      # user successfully created, log it in and redirect
      req.login user, (err) ->
        return res.redirect('/register') if err
        res.redirect('/me')

  me: (req, res) ->
    res.render 'user'

module.exports = UserController