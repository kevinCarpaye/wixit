const sequelize = require('sequelize');

module.exports = new sequelize('development_wixit', 'root', 'root', {
    host: 'localhost',
    port: 8889,
    dialect: 'mysql',
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    }
});