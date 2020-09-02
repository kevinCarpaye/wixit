const multer = require('multer');
const path = require('path');
const User = require('../../models/users');
const bcrypt = require('bcrypt');
const db = require('../../config/db');

const emailRegex = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
const passwordRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[-+!*$@%_])([-+!*$@%_\w]{8,15})$/;


const storage = multer.diskStorage({
    destination: './public/profilPicture/',
    filename: function (req, file, cb) {
        cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
        console.log(file.fieldname)
    }
});

// Init Upload
const uploadProfilPicture = multer({
    storage: storage,
    limits: { fileSize: 5000000 },
    fileFilter: function (req, file, cb) {
        checkFileType(file, cb);
    }
}).single('myImage');

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
    createUserWithProfilPicture: function (req, res) {

        //     let username = req.body.username;
        //     let email = req.body.email;
        //     let password = req.body.password;
        //     let Cpassword = req.body.Cpassword;
        //     let city = req.body.city

        //     if (username == null || email == null || password == null | Cpassword == null || city == null) {
        //         console.log(username + " " + email + " " + password + " " + Cpassword + " " + city)
        //         return res.status(400).json({ 'erreur': 'Paramètres manquants' })
        //     }

        //     if (!emailRegex.test(email)) {
        //         return res.status(400).json({ 'erreur': "L'email est invalide" });
        //     }

        //     // if (!passwordRegex.test(password)) {
        //     //     return res.status(400).json({ 'erreur': 'password invalid (must length 8-15 characters include at least : 1 uppercase, 1 lowercase, 1 number and 1 special character' });
        //     // }

        //     if (Cpassword != password) {
        //         return res.status(400).json({ 'erreur': 'Les mots de passe ne correspondent pas ' })
        //     }

        //     User.findOne({
        //         attributes: ['email'],
        //         where: {
        //             email: email
        //         }
        // }).then(function (userFound) {
        //     if (!userFound) {
        //         uploadProfilPicture(req, res, err => {
        //             if (err) {
        //                 res.render('index', {
        //                     msg: err
        //                 });
        //             } else {
        //                 if (req.file == undefined) {
        //                     res.render('index', {
        //                         msg: 'Error: No File Selected!'
        //                     });
        //                 } else {
        //                     res.render('index', {
        //                         msg: 'File Uploaded!',
        //                         file: `profilPicture/${req.file.filename}`
        //                     });
        //                 }
        //             }
        //         }).then(function (uploaded) {
        //             if (uploaded) {
        //                 console.log("--------------------------------------------")
        //                 console.log(req.file.filename)
        //                 console.log("--------------------------------------------")
        //                 bcrypt.hash(password, 5, function (err, bcrypted) {
        //                     User.create({
        //                         userName: username,
        //                         email: email,
        //                         password: bcrypted,
        //                         city: city,
        //                         isAdmin: false
        //                     })
        //                 })
        //             }
        //         }).catch((err) => {
        //             return res.status(500).json({ 'erreur': 'Veuillez réesayer ultérieurement' })
        //         });
        //     }
        // }).catch(function (err) {
        //     return res.status(500).json({ 'erreur': err })

        // })
        // .then(function (userFound) {
        //     if (!userFound) {
        //         bcrypt.hash(password, 5, function (err, bcrypted) {
        //             User.create({
        //                 userName: username,
        //                 email: email,
        //                 password: bcrypted,
        //                 city: city,
        //                 isAdmin: false
        //             }).then(function () {
        //                 console.log(req.file.filename)
        //                 uploadProfilPicture(req, res, err => {
        //                     if (err) {
        //                         res.render('index', {
        //                             msg: err
        //                         });
        //                     } else {
        //                         if (req.file == undefined) {
        //                             res.render('index', {
        //                                 msg: 'Error: No File Selected!'
        //                             });
        //                         } else {
        //                             res.render('index', {
        //                                 msg: 'File Uploaded!',
        //                                 file: `profilPicture/${req.file.filename}`
        //                             });
        //                         }
        //                     }
        //                 }).then( function (uploaded) {
        //                     if (uploaded) {
        //                         return res.status(201).json({ 'success': 'Votre compte à bien été créé' })
        //                     }
        //                 }).catch(function(err) {
        //                     return res.status(500).json({'erreur': err})
        //                 })
        //             }).catch(function (err) {
        //                 return res.status(500).json({ 'erreur': err })
        //             })
        //         })
        //     }
        //     else {
        //         return res.status(400).json({ 'erreur': 'Un compte est déja associé à cet email' })
        //     }
        // }).catch((err) => {
        //     return res.status(500).json({ 'erreur': 'Veuillez réesayer ultérieurement' })
        // });
    },

    createUserWithoutProfilPicture: function (req, res) {

        let username = req.body.userName;
        let email = req.body.email;
        let password = req.body.password;
        let Cpassword = req.body.Cpassword;
        let city = req.body.city
        let isAdmin = 0;
        let createdAt = Date();
        let updatedAt = Date();

        // if (username == null || email == null || password == null | Cpassword == null || city == null) {
        //     return res.status(400).json({ 
        //         'request': 0,
        //         'result': 'Paramètres manquants' })
        // }

        if (!emailRegex.test(email)) {
            return res.status(400).json({
                'request': 0,
                'result': "L'email est invalide"
            });
        }

        // if (!passwordRegex.test(password)) {
        //     return res.status(400).json({ 'erreur': 'password invalid (must length 8-15 characters include at least : 1 uppercase, 1 lowercase, 1 number and 1 special character' });
        // }

        if (Cpassword != password) {
            return res.status(400).json({
                'request': 0,
                'result': 'Les mots de passe ne correspondent pas '
            })
        }

        db.query('SELECT email FROM users WHERE email = "' + email + '"', function (err, response, fields) {
            if (err) throw err;
            if (response.length == 0) {
                bcrypt.hash(password, 5, function (err, bcrypted) {
                    db.query('INSERT INTO users (userName, email, password, city, isAmin, createdAt, updatedAt) VALUES ("' + username + '","' + email + '", "' + bcrypted + '", "' + city + '", "'+ isAdmin +'", DATE(NOW()),  DATE(NOW()) )', function (err, request, field) {
                        if (err) throw err;
                        if (request) {
                            return res.status(200).json({
                                'request': 1,
                                'result': 'Votre compte a bien été crée'
                            })
                        }
                        else {
                            return res.stuatus(200).json({
                                'request': 0,
                                'result': 'Erreur interne, veuillez reessayer ultérieurement'
                            })
                        }
                    })
                })
            }
            else {
                return res.status(201).json({
                    'request': 0,
                    'result': 'Cet email est déjà associé à un compte',
                    "response": response,
                })
            }
        })

        // User.findOne({
        //     attributes: ['email'],
        //     where: {
        //         email: email
        //     }
        // }).then(function (userFound) {
        //     if (!userFound) {
        //         bcrypt.hash(password, 5, function (err, bcrypted) {
        //             User.create({
        //                 userName: username,
        //                 email: email,
        //                 password: bcrypted,
        //                 city: city,
        //                 isAdmin: false
        //             }).then(function () {
        //                 return res.status(201).json({ 
        //                     'request': 1,
        //                     'result': 'Votre compte à bien été créé'
        //                  })
        //             }).catch(function (err) {
        //                 return res.status(500).json({ 
        //                     'request': 0,
        //                     'result': err
        //                  })
        //             })
        //         })
        //     }
        //     else {
        //         return res.status(400).json({
        //             'request': 0, 
        //             'result': 'Un compte est déja associé à cet email'
        //          })
        //     }
        // }).catch((err) => {
        //     return res.status(500).json({ 
        //         'request': 0,
        //         'result': 'Veuillez réesayer ultérieurement'
        //      })
        // });
    },

    // upload: function (req, res) {
    //     uploadProfilPicture(req, res, err => {
    //         if (err) {
    //             // res.render('index', {
    //             //     msg: err
    //             // }),
    //             res.status(500).json({ 'erreur': err });
    //         } else {
    //             if (req.file == undefined) {
    //                 // res.render('index', {
    //                 //     msg: 'Error: No File Selected!'
    //                 // }),
    //                 res.status(500).json({ 'erreur': 'No file Selected' });;
    //             } else {
    //                 res.status(200).json({
    //                     msg: 'File Uploaded!',
    //                     //file: `profilPicture/${req.file.filename}`
    //                 });
    //             }
    //         }
    //     });
    // },

    // vUpload: function (req, res) {
    //     res.render('index');
    //     res.setHeader('Content-type', 'text/html');
    //     res.status(200).send('<H1>Bjguhjokoihuhijt</h1>');
    // }

}


