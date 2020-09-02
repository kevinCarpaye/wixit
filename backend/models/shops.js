const Sequelize = require('sequelize');
const dbSeq = require('../config/Sequelize');

const Shops = dbSeq.define('shops', {
    //Attributs
    name : {
        type: Sequelize.STRING,
        allowNull: false
    },
    number: {
        type: Sequelize.INTEGER,
        allowNull: false
    },
    adress: {
        type: Sequelize.STRING,
        allowNull: false
    },
    informations: {
        type: Sequelize.STRING,
        allowNull: false
    },
    latitude: {
        type: Sequelize.FLOAT,
        allowNull: false
    },
    longitude: {
        type: Sequelize.FLOAT,
        allowNull: false
    },
    image: {
        type: Sequelize.STRING,
        allowNull: false
    }
})

module.exports = Shops