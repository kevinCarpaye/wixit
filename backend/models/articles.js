const Sequelize = require('sequelize');
const dbSeq = require('../config/Sequelize');

const Articles = dbSeq.define('articles', {
    //  attributes
    name: {
        type: Sequelize.STRING,
        allowedNull: false
    },
    barcode: {
        type: Sequelize.INTEGER,
        allowedNull: true
    },
    type: {
        type: Sequelize.STRING,
        allowedNull: false
    },
    image: {
        type: Sequelize.STRING,
        allowedNull: false
    },
    description: {
        type: Sequelize.STRING,
        allowedNull: true
    }
})

module.exports = Articles;