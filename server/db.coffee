path = require('path')
Sequelize = require('sequelize')
config = require('./config/services_config')

# create the connection
connection = new Sequelize config.db.name, config.db.admin, config.db.password,
  dialect: 'mysql'
  port: 3306
  logging: false

# load all models
models = {}
models.User = connection.import path.join(__dirname, 'models', 'user_sql')
models.Collection = connection.import path.join(__dirname, 'models', 'collection_sql')
models.Item = connection.import path.join(__dirname, 'models', 'item_sql')

# execute associations
associate = require('./models/associations')(models)

module.exports =
  connection: connection
  models: models