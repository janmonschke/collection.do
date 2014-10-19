bcrypt = require('bcrypt')
connection = require('../database_connection')()
db = connection.database('collection-data')

module.exports = class User
  @get: (id, cb) ->
    db.get(String(id), cb)

  @findByName: (name, cb) ->
    db.view 'user/byUsername', { key: name }, (err, res) ->
      if err? or res.length == 0
        return cb(null, null)
      cb(null, res[0].value)

  @create: (data, cb) ->
    # don't allow to set an id
    delete data._id
    delete data.id

    data.type = 'user'

    # save the date of creation
    data.created_at = Date.now()

    db.save data, (err, res) ->
      return cb(err) if err?

      data._rev = res.rev
      data._id = res.id

      cb(null, data)

  @createWithPassword: (data, pw, cb) ->
    User.findByName data.username, (err, user) ->
      return done({message: 'Username already taken'}) if user?

      # hash the password and create the user
      bcrypt.hash pw, 10, (err, hash) ->
        User.create
          username: data.username,
          email: data.email,
          pwhash: hash
        , cb
