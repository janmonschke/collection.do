class Controller
  before: -> {}

  constructor: ->
    # set up the before filters
    for method, filter of @before()
      @_createFilter method, filter

  _createFilter: (method, filter) ->
    original = @[method]
    @[method] = (req, res, next) ->
      # the filter's next function will be the original function
      _next = ->
        original req, res, next
      filter req, res, _next

  # fails if user is not logged in
  ensureAuthenticated: (req, res, next) =>
    if req.isAuthenticated()
      next()
    else
      @['401'](req, res)

  # redirects to login if user is not logged in
  loginIfNotLoggedIn: (req, res, next) ->
    if req.isAuthenticated()
      next()
    else
      res.redirect('/login')

  401: (req, res) ->
    if req.xhr
      res.json {error: 'Not authorized'}, 401
    else
      res.render 'errors/401', 401

  404: (req, res) ->
      if req.xhr
        res.json {error: 'Not found'}, 404
      else
        res.render 'errors/404', 404

  500: (req, res, error) ->
    console.error error
    if req.xhr
      res.json {error: 'Internal server error', errorObject: error}, 500
    else
      res.render 'errors/500', 500

module.exports = Controller