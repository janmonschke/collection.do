rtg = require('url').parse(process.env.REDISTOGO_URL || '')
rtg.auth = if rtg.auth? then rtg.auth else ''

# PRODUCTION #
prodConfig =
  type: 'production',
  appPort: process.env.PORT,
  redis:
    port: rtg.port,
    host: rtg.hostname,
    pass: rtg.auth.split(':')[1]
  ,
  db:
    admin: process.env.db_admin,
    password: process.env.db_password,
    protocol: 'https',
    host: process.env.db_host,
    port: process.env.db_port,
    name: process.env.db_name
  ,
  salt: process.env.salt,
  sessionSecret: process.env.session_secret

# DEVELOPMENT #
devConfig = {}
try
  devConfig = require('./config')
catch e
  console.info 'Could not find config for dev environment'

# get the node environment from the variable or default to development
node_env = process.env['NODE_ENV'] || 'development'
config = if node_env == 'production' then prodConfig else devConfig

module.exports = config