const User = require('../../models/users');
const multer = require('multer');
const path = require('path');
const bcrypt = require('bcrypt');
const db = require('../../config/db');

const storage = multer.diskStorage({
    destination: './public/profilPicture/',
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
    }
});

// Init Upload
const uploadProfilPicture = multer({
    storage: storage,
    limits: { fileSize: 5000000 },
    fileFilter: function (req, file, cb) {
        checkFileType(file, cb);
    }
}).single('profilPicture');

// Check File Type
function checkFileType(file, cb) {
    // Allowed ext
    const filetypes = /jpeg|jpg|png|gif/;
    // Check ext
    const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
    // Check mime
    const mimetype = filetypes.test(file.mimetype);
    if (mimetype && extname) {
        return cb(null, true);
    }
    else {
        cb('Error: Images Only!');
    }
}

module.exports = {

    getUserProfil: function (req, res) {
        let email = req.query.email;

        if (email == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Erreur",
                "response": {
                    'userName': "",
                    'email': "",
                    'city': "",
                    'createdAt': ""
                }
            })
        }

        console.log(email)
        db.query('SELECT userName, email, city, DATE_FORMAT(createdAt, "%Y/%m/%d") as "createdAt" FROM users WHERE email = "' + email + '"', function (err, response, fields) {
            if (err) throw err;
            if (response) {
                if (response.length > 0) {
                    return res.status(201).json({
                        "request": 1,
                        "result": "Found",
                        "response": {
                            'userName': response[0]["userName"],
                            'email': response[0]["email"],
                            'city': response[0]["city"],
                            'createdAt': response[0]["createdAt"]
                        }
                    })
                }
                else {
                    return res.status(404).json({
                        "request": 0,
                        "result": "Email inconnu",
                        "response": {
                            'userName': "",
                            'email': "",
                            'city': "",
                            'createdAt': ""
                        }
                    });
                }
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur interne, veuillez réessayer ultérieurement",
                    "response": {
                        'userName': "",
                        'email': "",
                        'city': "",
                        'createdAt': ""
                    }
                });
            }
        })
        // User.findOne({
        //     attributes: ['userName', 'email', 'city', 'createdAt'],
        //     where: { email: email }
        // })
        //     .then(function (UserFound) {
        //         if (UserFound) {
        //             return res.status(201).json({
        //                 "response": 1,
        //                 "results": {
        //                     'userName': UserFound.userName,
        //                     'email': UserFound.email,
        //                     'city': UserFound.city,
        //                     'createdAt': UserFound.createdAt
        //                 }
        //             })
        //         }
        //         else {
        //             return res.status(404).json({
        //                 "response": 0,
        //                 "results": {
        //                     'userName': "",
        //                     'email': "",
        //                     'city': "",
        //                     'createdAt': ""
        //                 }
        //             });
        //         }
        //     })
        //     .catch(function (err) {
        //         return res.status(500).json({
        //             "response": 0,
        //             "results": {
        //                 'userName': "",
        //                 'email': "",
        //                 'city': "",
        //                 'createdAt': ""
        //             }
        //         });
        //     })
    },

    updateUserProfil: function(req, res) {
        let userName = req.body.userName
        let email = req.body.email
        let city = req.body.city
        let old = req.body.old

        if (userName == null || email == null || city == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Parametre manquant"
            });
        }

        db.query('UPDATE users set userName = "'+ userName +'", email = "'+ email +'", city = "'+ city +'" WHERE email = "'+ old +'"', function(err, response, fields) {
            if (err) throw err;
            if (response.affectedRows > 0) {
                return res.status(201).json({
                    "request": 1,
                    "result": "les informations de votre compte ont bien été modifiés"
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Impossible de modifier les informations du compte, veuillez réessayer ultérieurement"
                })
            }
        })
    },

    updatePassword: function (req, res) {
        let email = req.body.email;
        let password = req.body.password;
        let Cpassword = req.body.Cpassword;

        if (password == null || Cpassword == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Parametre manquant"
            });
        }

        if (password.lenght < 4) {
            return res.status(400).json({
                "requst": 0,
                "result": "Le mot de passe doit contenir au moins 4 caractères"
            });
        }

        if (Cpassword != password) {
            return res.status(400).json({
                "request": 0,
                "result": "Les mots de passe ne correspondent pas"
            });
        }

        bcrypt.hash(password, 5, function (err, bcrypted) {
            db.query('Update users set password = "' + bcrypted + '" WHERE email = "' + email + '"', function (err, response, fields) {
                if (err) throw err;
                if (response.affectedRows == 1) {
                    return res.status(201).json({
                        "request": 1,
                        "result": "Le mot de passe à bien été modifié",
                        response
                    })
                }
                else {
                    return res.status(500).json({
                        "request": 0,
                        "result": "Impossible de modifier le mot de passe veuillez réessayer ultérieurement"
                    })
                    
                }
            })
        })
    },
    setUserProfil: function (req, res) {
        let email = req.body.email;
        let password = req.body.password;
        let Cpassword = req.body.Cpassword;

        if (password == null || Cpassword == null) {
            return res.status(400).json({
                "response": 0,
                "result": "Parametre manquant"
            });
        }

        if (password.lenght < 4) {
            return res.status(400).json({
                "response": 0,
                "results": "Le mot de passe doit contenir au moins 4 caractères"
            });
        }

        if (Cpassword != password) {
            return res.status(400).json({
                "response": 0,
                "results": "Les mots de passe ne correspondent pas"
            });
        }

        bcrypt.hash(password, 5, function (err, bcrypted) {
            User.update({ password: bcrypted }, {
                where: { email: email }
            })
                .then(function (updated) {
                    if (updated) {
                        return res.status(200).json({
                            "response": 1,
                            "results": "Le mot de passe à bien été modifié"
                        })
                    }
                    else {
                        return res.status(500).json({
                            "response": 0,
                            "results": "Impossible de modifier le mot de passe veuillez réessayer ultérieurement"
                        })
                    }
                })
                .catch(function (err) {
                    return res.status(500).json({
                        "response": 0,
                        "results": "Impossible de modifier le mot de passe, veuillez réessayer"
                    })
                })
        })
    }
}