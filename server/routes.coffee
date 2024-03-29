UserController = require('./controllers/users_controller')
CollectionController = require('./controllers/collection_controller')
ItemsController = require('./controllers/items_controller')

module.exports = (app, auth) ->
  user = new UserController()
  collection = new CollectionController()
  items = new ItemsController()

  loginIfNotLoggedIn = (req, res, next) ->
    if !req.user
      res.redirect '/'
    else
      next()

  app.get '/', (req, res) -> res.render 'index'

  app.get '/login', (req, res) -> res.render 'login'

  app.get '/logout', (req, res) ->
    req.logout()
    res.redirect('/')

  app.get '/register', (req, res) -> res.render 'register'

  app.post '/register', user.register

  app.post '/login', auth.authenticate 'local',
    successRedirect: '/me',
    failureRedirect: '/login'
    failureFlash: 'The credentials you specified were wrong.'

  app.get '/me', user.me

  app.get '/api/collections', collection.index
  app.post '/api/collections', collection.create

  app.get '/user/:user_id/collection/:collection_id', items.index
  app.post '/user/:user_id/collection/:collection_id/items', items.create