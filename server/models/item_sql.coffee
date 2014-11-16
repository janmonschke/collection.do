module.exports = (sequelize, types) ->
  sequelize.define 'Item',
    title:
      type: types.STRING
      allowNull: false
    description:
      type: types.STRING
      allowNull: false
    url:
      type: types.STRING
      allowNull: false
    html:
      type: types.STRING
    thumbnail_url:
      type: types.STRING
    thumbnail_width:
      type: types.INTEGER
    thumbnail_height:
      type: types.INTEGER