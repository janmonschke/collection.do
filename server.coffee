http = require('http')
express = require('express')
socketIO = require('socket.io')
db = require('./server/db')

console.log 'connecting to database'

db.connection.sync().complete (err) ->
  return console.log('could not connect to database', err) if err

  # db.models.Collection.findAll({include: [{ model: db.models.User, as: 'owners'}]}).success (collections) ->
  #   console.log JSON.stringify collections

  # db.models.User.create()
  # db.models.User.find(1, {include: db.models.Collection}).success (user) ->
  #   user.createCollection({})
  # #   # db.models.Collection.create().success (c) ->
  # #   #   console.log(user.addCollection(c));return
  #   user.getCollections().success (collections) ->
  #     console.log collections.length
  #   # db.models.Collection.find(1).success (collection) ->
  #   #   user.addCollection collection
  #     # console.log collections[0].id

  console.log 'successfully connected to the database'

  app = express()
  httpServer = http.Server(app)
  io = socketIO(httpServer)

  auth = require('./server/config/auth_config');

  # configure the server
  require('./server/config/app_config')(app, auth)

  # set up the routes
  require('./server/routes')(app, auth)

  # set up the realtime module
  # require('./server/realtime.coffee')(io)

  # start the server
  port = process.env.port or 8080
  httpServer.listen port

  console.log "Server started at port #{port}"