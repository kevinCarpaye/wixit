const Sequelize = require('sequelize');
const dbSeq = require('../config/Sequelize');

const Users = dbSeq.define('users', {
    //  attributes
    userName: {
        type: Sequelize.STRING,
        allowNull: false
    },
    email: {
        type: Sequelize.STRING,
        allowNull: false
    },
    password: {
        type: Sequelize.STRING,
        allowNull: false
    },
    city: {
        type: Sequelize.STRING,
        allowNull: false
    },
    // profilPicture: {
    //     type: Sequelize.STRING,
    //     allowNull: true
    // },
    isAdmin: {
        type: Sequelize.BOOLEAN,
        allowNull: true
    }
})

module.exports = Users;