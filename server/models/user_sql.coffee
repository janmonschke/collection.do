Promise = require('bluebird')
bcrypt = require('bcrypt')

module.exports = (sequelize, types) ->
  User = sequelize.define 'User',
    name:
      type: types.STRING
      allowNull: false
      unique: true
    email:
      type: types.STRING
      allowNull: false
      unique: true
    pwhash:
      type: types.STRING
      allowNull: false
  ,
    classMethods:
      findByName: (name) ->
        User.find where: {name: name}

      createWithPassword: (data, pw, cb) ->
        promise = new Promise (resolve, reject) ->
          # hash the password and create the user
          bcrypt.hash pw, 10, (err, hash) =>
            User.create({
              name: data.name,
              email: data.email,
              pwhash: hash
            }).complete (err, user) ->
              resolve(user)

        promise