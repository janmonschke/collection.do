module.exports = (sequelize, types) ->
  sequelize.define 'Collection',
    title:
      type: types.STRING
      allowNull: false