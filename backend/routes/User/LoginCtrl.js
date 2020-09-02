const User = require('../../models/users');
const bcrypt = require('bcrypt');
const db = require('../../config/db');

const emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;

module.exports = {

    login: function (req, res) {
        let email = req.query.email;
        let password = req.query.password

        if (email == null || password == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Paramètres manquants",
                "response": [{
                    "name": "",
                    "email": ""
                }]
            })
        }

        if (!emailRegex.test(email)) {
            return res.status(400).json({
                "request": 0,
                "result": "Email incorrect",
                "response": [{
                    "name": "",
                    "email": ""
                }]
            });
        }

        db.query('SELECT userName, email, password FROM users WHERE email = "' + email + '"', function (err, response, field) {
            if (err) throw err;
            if (response.length > 0) {
                bcrypt.compare(password, response[0]["password"], function (errBycrypt, resBycript) {
                    if (resBycript) {
                        return res.status(201).json({
                            "request": 1,
                            "result": "Found",
                            "response": [{
                                "name": response[0]["userName"],
                                "email": response[0]["email"]
                            }]
                        })
                    }
                    else {
                        return res.status(400).json({
                            "request": 0,
                            "result": "Identifiants inconnus",
                            "response": [{
                                "name": "",
                                "email": ""
                            }]
                        })
                    }
                })
            }
            else {
                return res.status(400).json({
                    "request": 0,
                    "result": "Identifiants inconnus",
                    "response": [{
                        "name": "",
                        "email": ""
                    }]
                })
            }
        })

        // User.findOne({
        //     attributes: ["userName", 'email', 'password'],
        //     where: { email: email }
        // }).then(function (emailFound) {
        //     if (emailFound) {
        //         bcrypt.compare(password, emailFound.password, function (errBycrypt, resBycript) {
        //             console.log(emailFound.password)
        //             if (resBycript) {
        //                 return res.status(201).json({
        //                     "request": 1,
        //                     "result": "Found",
        //                     "response": [{
        //                         "name": emailFound.userName,
        //                         "email": emailFound.email
        //                     }]
        //                 })
        //             }
        //             else {
        //                 return res.status(400).json({
        //                     "request": 0,
        //                     "result": "Identifiants inconnus",
        //                     "response": [{
        //                         "name": "",
        //                         "email": ""
        //                     }]
        //                 })
        //             }
        //         })
        //     }
        //     else {
        //         return res.status(400).json({
        //             "request": 0,
        //             "result": "Identifiants inconnus",
        //             "response": [{
        //                 "name": "",
        //                 "email": ""
        //             }]
        //         })
        //     }
        // })
        //     .catch(function (err) {
        //         console.log(err)
        //         return res.status(500).json({
        //             "request": 0,
        //             'result': 'Veuillez essayer ultérieurement',
        //             "response": [{
        //                 "name": "",
        //                 "email": ""
        //             }]
        //         })
        //     })
    }

}