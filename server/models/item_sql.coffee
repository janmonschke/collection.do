module.exports = (sequelize, types) ->
  sequelize.define 'Item',
    title:
      type: types.STRING(1000)
      allowNull: false
    description:
      type: types.STRING(1000)
      allowNull: false
    url:
      type: types.STRING
      allowNull: false
    html:
      type: types.STRING(1000)
    thumbnail_url:
      type: types.STRING
    thumbnail_width:
      type: types.INTEGER
    thumbnail_height:
      type: types.INTEGER