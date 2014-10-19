http = require('http')
express = require('express')
socketIO = require('socket.io')

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