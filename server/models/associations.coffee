module.exports = (m) ->
  # a user has many collections
  m.User.hasMany m.Collection, { as: 'collections', through: 'owner_collections' }
  # a collection has many owners
  m.Collection.hasMany m.User, { as: 'owners', through: 'owner_collections' }
  # a collection has many items
  m.Collection.hasMany m.Item, { as: 'items' }