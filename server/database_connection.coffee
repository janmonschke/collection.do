cradle = require('cradle')
config = require('./config/services_config')

setup =
  raw: false,
  cache: false,
  host: config.db.host,
  protocol: config.db.protocol,
  port: config.db.port,
  auth:
    username: config.db.admin,
    password: config.db.password

cradle.setup setup

module.exports = -> new(cradle.Connection)()