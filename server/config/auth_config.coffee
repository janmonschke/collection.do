bcrypt = require('bcrypt')
passport = require('passport')
LocalStrategy = require('passport-local').Strategy

User = require('../models/user')

checkPassword = (user, pw, cb) ->
  bcrypt.compare(pw, user.pwhash, cb)

authenticate = (username, pw, done) ->
  User.findByName username, (err, user) ->
    # if there has been an error or the user could not be found, return the error
    if(err || !user)
      return done(err, null)
    else
      # check the password if there was no error
      checkPassword user, pw, (err, passwordCorrect) ->
        # return an error when the password is not correct
        if(err || !passwordCorrect)
          return done(null, null, err)
        else
          # if all went ell, the user is can be authenticated
          done(null, user)

serializeUser = (user, done) ->
  if(user.id)
    done(null, user.id)
  else
    done(null, user._id)

deserializeUser = (id, done) ->
  User.get id, (err, user) ->
    if(err || !user)
      return done(null, null, null)
    done(null, user)

# make passport use the above defined methods
passport.serializeUser(serializeUser)
passport.deserializeUser(deserializeUser)

# use the standard password procedure
passport.use(new LocalStrategy(
  usernameField: 'username',
  passwordField: 'password'
, authenticate))

module.exports = passport