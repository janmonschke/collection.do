# Configure the app
express = require('express')
config = require('./services_config')
session = require('express-session')
RedisStore = require('connect-redis')(session)
flash = require('connect-flash')
path = require('path')
serveStatic = require('serve-static')
bodyParser = require('body-parser')
cookieParser = require('cookie-parser')
morgan = require('morgan')

module.exports = (app, auth) ->

  app.set('view engine', 'jade')
  app.set('views', path.join(__dirname, '..', 'views'))

  # serve the public folder
  app.use serveStatic 'public'

  # parse bodies
  app.use bodyParser.urlencoded(extended: false)
  app.use bodyParser.json()

  # set up the session store
  app.use session
    store: new RedisStore(
      port: config.redis.port,
      host: config.redis.host,
      pass: config.redis.pass
    ),
    secret: config.sessionSecret,
    resave: true
    saveUninitialized: true
    cookie:
      maxAge: 604800000

  # initialize auth
  app.use(auth.initialize())
  app.use(auth.session())

  # make flashs available
  app.use flash()

  # make the user available
  app.use (req, res, next) ->
    res.locals.user = req.user
    res.locals.errors = req.flash('error')
    next()

  # parse cookies
  app.use cookieParser()

  # log everything
  app.use morgan('dev')

  app.disable('x-powered-by')