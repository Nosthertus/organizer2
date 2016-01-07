/* jshint indent: 2 */

module.exports = function(sequelize, DataTypes) {
  return sequelize.define('projecttype', {
    id: {
      type: DataTypes.INTEGER(11),
      allowNull: false,
      primaryKey: true,
      autoIncrement: true
    },
    name: {
      type: DataTypes.STRING,
      allowNull: false
    }
  }, {
    tableName: 'projecttype',
    freezeTableName: true,
    timestamps: false
  });
};
