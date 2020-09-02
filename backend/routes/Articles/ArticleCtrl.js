const Article = require('../../models/articles');
const db = require('../../config/db');
const multer = require('multer');
const path = require('path');
var fileName = "";
var imageDestination = "";
const fs = require('fs');

let idShop = null;
let name = null;
let barcode = "";
let description = "";
let type = null;
let price_base = null;
let stock = null;
let verificationFolder = null;
let image = null;
let pathQuery = null;

// Destination pour l'ajout d'article de part les utilisateurs
const storageAddedPicture = multer.diskStorage({
    destination: './public/images/articlesAddedPicture/',
    filename: function (req, file, cb) {
        //cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
        cb(null, fileName + path.extname(file.originalname));
    }
});

// Init Upload
// Initialisation pour l'ajout d'article de part les utilisateurs
const uploadAddPicture = multer({
    storage: storageAddedPicture,
    limits: { fileSize: 5000000 },
    fileFilter: function (req, file, cb) {
        checkFileType(file, cb);
    }
}).single("file");

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

// Check File Type
// function checkFileType(file, cb) {
//     // Allowed ext
//     const filetypes = /jpeg|jpg|png|gif/;
//     // Check ext
//     const extname = filetypes.test(path.extname(file.originalname).toLowerCase());
//     // Check mime
//     const mimetype = filetypes.test(file.mimetype);
//     if (mimetype && extname) {
//         return cb(null, true);
//     }
//     else {
//         cb('Error: Images Only!');
//     }
// }

module.exports = {

    newArticle: function (req, res) {
        db.query('SELECT articles.name, articles.image FROM articles ORDER BY articles.createdAt DESC LIMIT 15', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                return res.status(200).json({
                    "request": 1,
                    "result": '',
                    "response": {
                        "articles": response
                    }
                })
            }
        })
    },

    SearchArticleWithBarcode: function (req, res) {

        let barcode = req.query.barcode
        let user = req.query.email
        if (barcode == null || barcode.length != 13) {
            return res.status(404).json({
                "request": 0,
                "result": 'Le code barre est incorrect',
                "response": {
                    "article": [{
                        "name": "",
                        "barcode": "",
                        "type": "",
                        "image": "",
                        "description": "",
                        "createdAt": ""
                    }],
                    "shops": [{
                        "name": "",
                        "number": "",
                        "adress": "",
                        "informations": "",
                        "image": "",
                        "logo": "",
                        "price": 0.0,
                        "price_base": 0.0,
                        "link": "",
                        "sale": 0,
                        "stock": 0,
                        "latitude": 0.000,
                        "longitude": 0.000,
                        "date_start": "",
                        "date_end": "",
                        "stock": 0
                    }]
                }
            })
        }

        // Article.findOne({
        //     attributes: ['name', 'barcode', 'type', 'image', 'description', 'createdAt'],
        //     where: {
        //         barcode: barcode
        //     }
        // }).then(function (barcodeFound) {
        //     if (barcodeFound) {
        //         return res.status(201).json({
        //             "request": 1,
        //             "result": 'Reussi',
        //             "response": barcodeFound
        //         })
        //     }
        //     else {
        //         return res.status(400).json({
        //             "request": 0,
        //             "result": "Le code barre ne correspond à aucun article",
        //             "response": {
        //                 "name": "",
        //                 "barcode": "",
        //                 "type": "",
        //                 "image": "",
        //                 "description": "",
        //                 "createdAt": ""
        //             }
        //         })
        //     }
        // })

        db.query('SELECT name, barcode, type, image, description, createdAt FROM articles WHERE articles.barcode = "' + barcode + '"', function (err, response, fields) {
            if (err) throw err;
            console.log("Pahse 1");
            if (response.length > 0) {
                db.query('SELECT id FROM users WHERE email = "' + user + '" ', function (err, response3, fields) {
                    if (err) throw err;
                    console.log("Pahse 2 dans le 1");
                    if (response3.length > 0) {
                        console.log("Pahse 3 dans la 1");
                        db.query('INSERT INTO sought (name, barcode, idUser, soughtAt) VALUES ("' + response[0]["name"] + '", "' + barcode + '", "' + response3[0]["id"] + '", NOW())')
                    }
                    else {
                        console.log("Pahse 3 dans le 1");
                        db.query('INSERT INTO sought (name, barcode, soughtAt) VALUES ("' + response[0]["name"] + '", "' + barcode + '", NOW())')
                    }
                    console.log(response)

                })
            }
            else {
                db.query('SELECT id FROM users WHERE email = "' + user + '" ', function (err, response3, fields) {
                    if (err) throw err;
                    console.log("Pahse 2 dans le 2");
                    if (response3.length > 0) {
                        console.log("Pahse 3 dans le 2");
                        db.query('INSERT INTO unknows (name, barcode, type ,soughtAt) VALUES ("' + response3[0]["name"] + '", "' + barcode + '", "", NOW())')
                    }
                    else {
                        console.log("Pahse 3 dans le 2");
                        db.query('INSERT INTO unknows (barcode, type, soughtAt) VALUES ( "' + barcode + '", "", NOW())')
                    }
                    console.log(response)
                })
            }

            db.query('SElECT shops.name, shops.number, shops.adress, shops.informations, shops.image, shops.logo, shops.latitude, shops.longitude, prices.price_base, prices.link, sales.price, DATE_FORMAT(sales.date_start, "%Y/%m/%d") as "date_start", DATE_FORMAT(sales.date_end, "%Y/%m/%d") as "date_end", prices.stock FROM articles, prices, shops, sales where sales.idSale = prices.idSales AND prices.idShop = shops.idShop AND prices.idArticle = articles.idArticle AND articles.barcode = "' + barcode + '"  AND prices.isActive = true', function (err, response2, fields) {
                if (err) throw err;
                console.log("Pahse 4");
                if (response && response2) {
                    console.log("Pahse 5");
                    if (response[0] != undefined) {
                        console.log("phase 6 dans le if")
                        console.log(response)
                        let date = Date()
                        console.log("La date d'aujourd'hui " + date)
                        return res.status(201).json({
                            "request": 1,
                            "result": "Found",
                            "response": {
                                "article": response,
                                "shops": response2
                            }
                        })
                    }
                    else {
                        console.log("Pahse 6 dans le else");
                        return res.status(404).json({
                            "request": 0,
                            "result": "Le produit scanné n'est pas présent dans la base de données.",
                            "response": {
                                "article": [{
                                    "name": "",
                                    "barcode": "",
                                    "type": "",
                                    "image": "",
                                    "description": "",
                                    "createdAt": "",
                                }],
                                "shops": [{
                                    "name": "",
                                    "number": "",
                                    "adress": "",
                                    "informations": "",
                                    "image": "",
                                    "logo": "",
                                    "price": 0.0,
                                    "price_base": 0.0,
                                    "link": "",
                                    "sale": 0,
                                    "stock": 0,
                                    "latitude": 0.000,
                                    "longitude": 0.000,
                                    "date_start": "",
                                    "date_end": "",
                                    "stock": 0
                                }]
                            }
                        })
                    }
                }
                else {
                    return res.status(500).json({
                        "request": 0,
                        "result": "Problème de connexion veuillez rééssayer ultérieurememt",
                        "response": {
                            "article": [{
                                "name": "",
                                "barcode": "",
                                "type": "",
                                "description": "",
                                "createdAt": ""
                            }],
                            "shops": [{
                                "name": "",
                                "number": "",
                                "adress": "",
                                "informations": "",
                                "image": "",
                                "logo": "",
                                "price": 0.0,
                                "price_base": 0.0,
                                "link": "",
                                "sale": 0,
                                "stock": 0,
                                "latitude": 0.000,
                                "longitude": 0.000,
                                "date_start": "",
                                "date_end": "",
                                "stock": 0
                            }]

                        }
                    })
                }
            })

        })
    },

    SearchArticleWithName: function (req, res) {
        let name = req.query.name
        let user = req.query.email
        console.log("L'email est " + user);
        console.log("Le nom " + name);
        if (name == null) {
            return res.status(404).json({
                "request": 0,
                "result": 'Le nom est incorrect',
                "response": {
                    "article": [{
                        "name": "",
                        "barcode": "",
                        "type": "",
                        "image": "",
                        "description": "",
                        "createdAt": ""
                    }],
                    "shops": [{
                        "name": "",
                        "number": "",
                        "adress": "",
                        "informations": "",
                        "image": "",
                        "logo": "",
                        "price": 0.0,
                        "price_base": 0.0,
                        "link": "",
                        "sale": 0,
                        "stock": 0,
                        "latitude": 0.000,
                        "longitude": 0.000,
                        "date_start": "",
                        "date_end": "",
                        "stock": 0
                    }]
                }
            })
        }

        // Article.findOne({
        //     attributes: ['name', 'barcode', 'type', 'image', 'description', 'createdAt'],
        //     where: {
        //         barcode: barcode
        //     }
        // }).then(function (barcodeFound) {
        //     if (barcodeFound) {
        //         return res.status(201).json({
        //             "request": 1,
        //             "result": 'Reussi',
        //             "response": barcodeFound
        //         })
        //     }
        //     else {
        //         return res.status(400).json({
        //             "request": 0,
        //             "result": "Le code barre ne correspond à aucun article",
        //             "response": {
        //                 "name": "",
        //                 "barcode": "",
        //                 "type": "",
        //                 "image": "",
        //                 "description": "",
        //                 "createdAt": ""
        //             }
        //         })
        //     }
        // })

        db.query('SELECT name, barcode, type, image, description, createdAt FROM articles WHERE articles.name = "' + name + '"', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                db.query('SELECT id FROM users WHERE email = "' + user + '" ', function (err, response3, fields) {
                    if (err) throw err;
                    //console.log("Voici l'user" + response3);
                    if (response3.length > 0) {
                        db.query('INSERT INTO sought (name, idUser, soughtAt) VALUES ("' + response[0]["name"] + '", "' + response3[0]["id"] + '", NOW())')
                    }
                    else {
                        db.query('INSERT INTO sought (name, soughtAt) VALUES ("' + response[0]["name"] + '", NOW())')
                    }
                    //console.log(response)
                })
            }
            else {
                db.query('SELECT id FROM users WHERE email = "' + user + '" ', function (err, response3, fields) {
                    if (err) throw err;
                    if (response.length > 0) {
                        db.query('INSERT INTO unknows (name, idUser, type ,soughtAt) VALUES ("' + name + '", "' + response3[0]["id"] + '", "", NOW())')
                    }
                    else {
                        db.query('INSERT INTO unknows (name, type, soughtAt) VALUES ( "' + name + '", "", NOW())')
                    }
                    //console.log(response)
                })
            }
            db.query('SElECT shops.name, shops.number, shops.adress, shops.informations, shops.image, shops.logo, shops.latitude, shops.longitude, prices.price_base, prices.link, sales.price,  DATE_FORMAT(sales.date_start, "%Y/%m/%d") as "date_start", DATE_FORMAT(sales.date_end, "%Y/%m/%d") as "date_end", prices.stock FROM articles, prices, shops, sales where sales.idSale = prices.idSales AND prices.idShop = shops.idShop AND prices.idArticle = articles.idArticle AND articles.name = "' + name + '" AND prices.isActive = true', function (err, response2, fields) {
                if (err) throw err;
                if (response && response2) {
                    if (response[0] != undefined) {
                        return res.status(201).json({
                            "request": 1,
                            "result": "Found",
                            "response": {
                                "article": response,
                                "shops": response2
                            }
                        })
                    }
                    else {
                        return res.status(404).json({
                            "request": 0,
                            "result": "Le produit recherché n'a pas encore de point de vente connu.",
                            "response": {
                                "article": [{
                                    "name": "",
                                    "barcode": "",
                                    "type": "",
                                    "image": "",
                                    "description": "",
                                    "createdAt": "",
                                }],
                                "shops": [{
                                    "name": "",
                                    "number": "",
                                    "adress": "",
                                    "informations": "",
                                    "image": "",
                                    "logo": "",
                                    "price": 0.0,
                                    "price_base": 0.0,
                                    "link": "",
                                    "sale": 0,
                                    "stock": 0,
                                    "latitude": 0.000,
                                    "longitude": 0.000,
                                    "date_start": "",
                                    "date_end": "",
                                    "stock": 0
                                }]
                            }
                        })
                    }
                }
                else {
                    return res.status(500).json({
                        "request": 0,
                        "result": "Problème de connexion veuillez rééssayer ultérieurememt",
                        "response": {
                            "article": [{
                                "name": "",
                                "barcode": "",
                                "type": "",
                                "description": "",
                                "createdAt": ""
                            }],
                            "shops": [{
                                "name": "",
                                "number": "",
                                "adress": "",
                                "informations": "",
                                "image": "",
                                "logo": "",
                                "price": 0.0,
                                "price_base": 0.0,
                                "link": "",
                                "sale": 0,
                                "stock": 0,
                                "latitude": 0.000,
                                "longitude": 0.000,
                                "date_start": "",
                                "date_end": "",
                                "stock": 0
                            }]

                        }
                    })
                }
            })

        })
    },

    SearchArticleByName: function (req, res) {

        let name = req.query.name;
        let user = req.query.email

        db.query('SELECT name, image from articles WHERE name like "%' + name + '%"', function (err, response, field) {
            if (response.length > 0) {
                db.query('SELECT id FROM users WHERE email = "' + user + '" ', function (err, response3, fields) {
                    if (err) throw err;
                    console.log("Voici l'user" + response3);
                    if (response3.length > 0) {
                        db.query('INSERT INTO sought (name, idUser, soughtAt) VALUES ("' + name + '", "' + response3[0]["id"] + '", NOW())')
                    }
                    else {
                        db.query('INSERT INTO sought (name, soughtAt) VALUES ("' + name + '", NOW())')
                    }
                    console.log(response)
                })
            }
            else {
                db.query('SELECT id FROM users WHERE email = "' + user + '" ', function (err, response3, fields) {
                    if (err) throw err;
                    if (response.length > 0) {
                        db.query('INSERT INTO unknows (name, idUser, type ,soughtAt) VALUES ("' + name + '", "' + response3[0]["id"] + '", "", NOW())')
                    }
                    else {
                        db.query('INSERT INTO unknows (name, type, soughtAt) VALUES ( "' + name + '", "", NOW())')
                    }
                    console.log(response)
                })
            }
            if (err) throw err;
            if (response) {
                if (response[0] != undefined || response.length > 0) {
                    return res.status(201).json({
                        "request": 1,
                        "result": "Found",
                        "response": {
                            "articles": response
                        }
                    })
                }
                else {
                    return res.status(500).json({
                        "request": 0,
                        "result": "Aucun article ne correspond, voulez-vous l'ajouter pour que nous lancions la procédure de répertoriage auprès des commerçants ? (Fortement recommandé pour augmenter les capacités de l'application ",
                        "response": {
                            "articles": [{
                                "image": "",
                                "name": ""
                            }]
                        }
                    })
                }
            }
        })
    },

    fetchType: function (req, res) {

        db.query('SELECT DISTINCT(articles.type) FROM articles ORDER BY Concat(type)', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    response
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur interne Veuillez réessayer ultérieurement. Si le problème persiste veuillez contacter les developpeurs sur la page dédié.",
                    "response": {
                        "type": ""
                    }
                })
            }
        })
    },

    AddArticleWithBarCode: function (req, res) {

        let name = req.body.name
        let barcode = req.body.barcode
        let type = req.body.type
        let user = req.body.email

        console.log(name)
        console.log(barcode)
        console.log(type)

        if (user == undefined) {
            user = 0;
        }

        let imageUrl = "";

        if (barcode) {
            imageUrl = "/images/articlesAddedPicture/" + name + ".jpeg"
            if (name == null || barcode == null || barcode.length != 13 || type == null) {
                return res.status(400).json({
                    "request": 0,
                    "result": 'Informations manquantes, vérifiez votre requête'
                })
            }
        }
        else {
            imageUrl = "/images/articlesAddedPicture/" + barcode + ".jpeg"
            if (name == null || type == null) {
                console.log(name)
                console.log(type)
                return res.status(400).json({
                    "request": 0,
                    "result": 'Informations manquantes, vérifiez votre requête'
                })
            }
        }

        db.query('INSERT INTO unknows (name, barcode, type, picture, idUser, soughtAt) VALUES ("' + name + '", "' + barcode + '", "' + type + '", "' + imageUrl + '", "' + user + '", NOW())', function (err, response, fields) {
            if (err) throw err;
            console.log("Reponse:   " + response)
            if (response) {
                fileName = name
                return res.status(201).json({
                    "request": 1,
                    "result": "L'article a été ajouté, il sera vérifié pour garantir sa pérénité."
                })
            }
            else {
                return res.status(400).json({
                    "request": 0,
                    "result": "L'article n'a pas été ajouté, veuillez réessayer."
                })
            }
        })


        // Article.create({
        //     name: name,
        //     barcode: barcode,
        //     type: type,
        //     image: 'null',
        //     description: 'null'
        // }).then(function (create) {
        //     if (create) {
        //         fileName = name
        //         Barcode = barcode
        //         return res.status(201).json({
        //             "request": 1,
        //             "result": "L'article a été ajouté, il sera vérifié pour garantir sa pérénité."
        //         })
        //     }
        //     else {
        //         return res.status(400).json({
        //             "request": 0,
        //             "result": "L'article n'a pas été ajouté, veuillez réessayer."
        //         })
        //     }
        // }).catch(function (err) {
        //     return res.status(500).json({
        //         "request": 0,
        //         "result": "Erreur connexion serveur, réessayer ultérieurement."
        //     })
        // })
    },

    UploadAddedPicture: function (req, res) {
        // Article.update({ image: fileName }, {
        //     where: { barcode: Barcode }
        // })
        uploadAddPicture(req, res, err => {
            //console.log(fileName)
            if (err) {
                // res.render('index', {
                //     msg: err
                // }),
                console.log(err);
                res.status(500).json({ 'erreur': err });
            } else {
                if (req.file == undefined) {
                    // res.render('index', {
                    //     msg: 'Error: No File Selected!'
                    // }),
                    res.status(500).json({ 'erreur': 'No file Selected' });;
                } else {
                    res.status(200).json({
                        msg: 'File Uploaded!',
                        file: `${req.file.filename}`
                    });
                }
            }
        });
    },

    UploadPictureByShop: function (req, res) {
        // Article.update({ image: fileName }, {
        //     where: { barcode: Barcode }
        // })
        // Destination pour l'ajout d'article de part les magasins
        verificationFolder = './public/images/articlesPicture/' + type;
        image = '/images/articlesPicture/' + type;
        pathQuery = "";
        //console.log(name + "        " + name2);

        if (!fs.existsSync(verificationFolder)) {
            try {
                fs.mkdirSync(verificationFolder, { recursive: true });
            } catch (error) {
                console.log(error.message);
            }
        }
        else {
            console.log("file or directory already exist")
        }

        const storageAddedPicture2 = multer.diskStorage({
            destination: verificationFolder,
            filename: function (req, file, cb) {
                //cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
                cb(null, name + path.extname(file.originalname));
                pathQuery = image + "/" + name + path.extname(file.originalname);
            }
        });

        // Init Upload
        // Initialisation pour l'ajout d'article de part les magasins
        const uploadPicture = multer({
            storage: storageAddedPicture2,
            limits: { fileSize: 5000000 },
            fileFilter: function (req, file, cb) {
                checkFileType(file, cb);
            }
        }).single("file");
        uploadPicture(req, res, err => {
            //console.log(fileName)
            if (err) {
                // res.render('index', {
                //     msg: err
                // }),
                console.log(err);
                res.status(500).json({
                    'request': 0,
                    'result': err
                });
            } else {

                console.log("Le req.file =     :" + req.body.file)
                if (req.file == undefined) {
                    // res.render('index', {
                    //     msg: 'Error: No File Selected!'
                    // }),
                    res.status(500).json({
                        'request': 0,
                        'result': 'Aucun fichier sélectionnné'
                    });;
                } else {
                    console.log("Destination:   " + verificationFolder)
                    console.log("RequeteSQL:   " + pathQuery)
                    db.query('INSERT INTO articles (name, barcode, description, type, image, createdAt, updatedAt) VALUES ("' + name + '", "' + barcode + '", "' + description + '", "' + type + '", "' + pathQuery + '", now(), now())', function (err, response, fields) {
                        if (err) throw err;
                        if (response) {
                            db.query('SELECT idArticle FROM articles WHERE articles.name = "' + name + '"', function (err, response2, fields) {
                                if (err) throw err
                                if (response2) {
                                    db.query('INSERT INTO prices (idArticle, idShop, price_base, stock, idSales, createdAt, updatedAt, isActive) VALUES ("' + response2[0]["idArticle"] + '","' + idShop + '", round( "' + price_base + '", 2), "' + stock + '", 0, now(), now()), true', function (err, response3, fields) {
                                        if (err) throw err
                                        if (response3) {
                                            res.status(200).json({
                                                'request': 1,
                                                'result': "Produit ajouté !",
                                                //file: `${req.file.filename}`
                                            });
                                        }
                                        else {
                                            res.status(500).json({
                                                'request': 0,
                                                'result': "Erreur l'article n'a pas pu être ajouté, veuillez réésayer.",
                                                //file: `${req.file.filename}`
                                            });
                                        }
                                    })
                                }
                                else {
                                    res.status(500).json({
                                        'request': 0,
                                        'result': "Erreur l'article n'a pas pu être ajouté, veuillez réésayer.",
                                        //file: `${req.file.filename}`
                                    });
                                }
                            })

                        }
                        else {
                            res.status(500).json({
                                'request': 0,
                                'result': "Erreur l'article n'a pas pu être ajouté, veuillez réésayer.",
                                //file: `${req.file.filename}`
                            });
                        }
                    })
                }
            }
        });
    },

    ListShopSearchWithBarcode: function (req, res) {

        let barcode = req.body.barcode

        if (barcode == null || barcode.length != 13) {
            return res.status(400).json({
                "request": 0,
                "result": "Le code Barre est incorrect",
                "response": {
                    "name": "",
                    "description": "",
                    "type": "",
                    "image": ""
                }
            })
        }

        // Article.findOne({
        //     attributes: ['name', 'description', 'type', 'image'],
        //     where: { barcode: barcode }
        // }).then(function (barcodeFound) {
        //     if (barcodeFound) {
        //         return res.status(201).json({
        //             "request": 1,
        //             "result": "Found",
        //             "response": {
        //                 "name": barcodeFound.name,
        //                 "description": barcodeFound.description,
        //                 "type": barcodeFound.type,
        //                 "image": barcodeFound.image
        //             }
        //         })
        //     }
        //     else {
        //         return res.status(400).json({
        //             "request": 0,
        //             "result": "Le codeBarre est inconnu",
        //             "response": {
        //                 "name": "",
        //                 "description": "",
        //                 "type": "",
        //                 "image": ""
        //             }
        //         })
        //     }
        // }).catch(function (err) {
        //     return res.status(500).json({
        //         "request": 0,
        //         "result": "Problème de connexion veuillez rééssayer ultérieurememt",
        //         "response": {
        //             "name": "",
        //             "description": "",
        //             "type": "",
        //             "image": ""
        //         }
        //     })
        // })
        db.query('SELECT name, description, type, image FROM articles WHERE articles.barcode = "' + barcode + '"', function (err, response, fields) {
            if (err) throw err;
            if (response) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "response": response
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Problème de connexion veuillez rééssayer ultérieurememt",
                    "response": {
                        "name": "",
                        "description": "",
                        "type": "",
                        "image": ""
                    }
                })
            }
        })
    },

    allArticlesByShop: function (req, res) {


        let id = req.body.id
        if (id == undefined) {
            id = req.query.id
        }

        db.query('SELECT articles.name, articles.barcode, articles.image, articles.description, articles.type, prices.idPrice, prices.price_base, prices.stock, DATE_FORMAT(articles.createdAt, "%Y/%m/%d") as "createdAt", DATE_FORMAT(articles.updatedAt, "%Y/%m/%d") as "updatedAt" FROM shops, articles, prices, shopUsers WHERE prices.idShop = shops.idShop AND prices.idArticle = articles.idArticle AND shopUsers.idShop = shops.idShop AND shopUsers.identifier = "' + id + '" AND prices.isActive = true', function (err, articles, fields) {
            if (err) throw err;
            if (articles.length > 0) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "resp:": articles
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur interne, veuillez réessayer ultérieurement",
                    "resp:": {
                        "name": "",
                        "barcode": "",
                        "image": "/",
                        "description": "",
                        "type": "",
                        "idPrice": 0,
                        "price_base": 0,
                        "stock": 0,
                        "createdAt": "",
                        "updatedAt": ""
                    }
                })
            }
        })
    },

    addArticleByShop: function (req, res) {

        idShop = req.body.idShop
        name = req.body.name;
        barcode = req.body.barcode;
        description = req.body.description;
        type = req.body.type;
        price_base = req.body.price_base;
        if (req.body.stock == "") {
            stock = -1;
        }

        //console.log(req)
        console.log("idShop : " + idShop);
        console.log("name : " + name);
        console.log("barcode : " + barcode);
        console.log("descrption : " + description);
        console.log("type : " + type);
        console.log("price_base : " + price_base);
        console.log("stock : " + stock);
        //console.log("-------------------------")
        //console.log("Composition du body    :" + req.body)
        //res.end( JSON.stringify(req.body));

        if (name == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Le nom est obligatoire"
            })
        }

        if (type == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Le type est obligatoire"
            })
        }

        if (price_base == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Le prix est obligatoire"
            })
        }
        return res.status(200).json({
            "request": 1,
            "result": "Paramètres obligatoires renseignés"
        })
        // fs.mkdir(imageDestination, (err) => {
        //     if (err) {
        //         console.log(err)
        //         console.log("Le dossié est déja crée");
        //         db.query('INSERT INTO articles (name, barcode, description, type, image, createdAt, updatedAt) VALUES ("' + name + '", "' + barcode + '", "' + description + '", "' + type + '", "' + fileName2 + '", now(), now())')
        //     }
        //     else {
        //         console.log(`fichier, dossier created`);
        //         db.query('INSERT INTO articles (name, barcode, description, type, image, createdAt, updatedAt) VALUES ("' + name + '", "' + barcode + '", "' + description + '", "' + type + '", "' + fileName2 + '", now(), now())')
        //     }
        // })
        // fs.stat(path, function(err) {
        //     if (!err) {
        //         console.log('Fichier ou dossier existant');
        //         db.query('INSERT INTO articles (name, barcode, description, type, image) VALUES ("'+ name +'", "'+ barcode +'", "'+ description +'", "'+ type +'", "'+ fileName +'")')
        //     }
        //     else if (err.code === 'ENOENT') {
        //         console.log('file or directory does not exist');
        //         fs.mkdir(this.fileName, (err) => {
        //             if (err) {
        //                 console.log("Le dossié est déja crée");

        //             }
        //             else {
        //                 console.log(` directory created`);
        //                 db.query('INSERT INTO articles (name, barcode, description, type, image) VALUES ("'+ name +'", "'+ barcode +'", "'+ description +'", "'+ type +'", "'+ fileName +'")')
        //             }
        //         })
        //     }
        // });


        //db.query('INSERT INTO articles (name, barcode, description, type, image) VALUES ("'+ name +'", "'+ barcode +'", "'+ description +'", "'+ type +'", "'+  +'")')

        //db.query('INSERT INTO article')


    },

    updateArticleByShop: function (req, res) {
        const idShop = req.body.idShop;
        const idPrice = req.body.idPrice;
        const price_base = req.body.price_base;
        const stock = req.body.stock;

        if (price_base == null || price_base == "") {
            return res.status(400).json({
                "request": 0,
                "result": "Le prix est obligatoire"
            })
        }

        console.log("idshop : " + idShop);
        console.log("idPrice : " + idPrice);
        console.log("prix de base : " + price_base);
        console.log("stock : " + stock);

        // db.query('SELECT idArticle from articles WHERE articles.name = "' + name + '"', function (err, response, fields) {
        //     if (err) throw err;
        //     if (response.length > 0) {
        //         db.query('UPDATE prices SET price_base = "' + price_base + '", stock = "' + stock + '" WHERE prices.idArticle = "'+ response[0]["idArticle"] +'" AND prices.idShop = "'+ idShop +'"', function (err, response2, fields) {
        //             if (err) throw err;
        //             if (response2) {
        //                 return res.status(201).json({
        //                     "request": 1,
        //                     "result": "Les informations relatifs à l'article ont été modifiées"
        //                 })
        //             }
        //             else {
        //                 return res.status(500).json({
        //                     "request": 0,
        //                     "result": "Erreur, veuillez réessayer ulterieurement"
        //                 })
        //             }
        //         })
        //     }
        //     else {
        //         return res.status(500).json({
        //             "request": 0,
        //             "result": "Erreur, veuillez réessayer ulterieurement"
        //         })
        //     }
        // })
        db.query('UPDATE prices SET price_base = "' + price_base + '", stock = "' + stock + '" WHERE idPrice = "' + idPrice + '"', function (err, response2, fields) {
            if (err) throw err;
            if (response2) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Les informations relatifs à l'article ont été modifiées"
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur, veuillez réessayer ulterieurement"
                })
            }
        })
    },

    deleteArticleByShop: function (req, res) {

        const id = req.body.idPrice
        const idPrice = parseInt(id);
        console.log(req.query.idPrice);

        // db.query('SELECT idArticle from articles WHERE articles.name = "' + name + '"', function (err, response, fields) {
        //     if (err) throw err;
        //     if (response.length > 0) {
        //         bd.query('DELETE FFROM prices WHERE prices.idArticle = "'+ response[0]["idArticle"] +'" AND prices.idShop = "'+ idShop +'"', function (err, response2, fields) {
        //             if (err) throw err;
        //             if (response2) {
        //                 return res.status(201).json({
        //                     "request": 1,
        //                     "result": "Les informations relatifs à l'article ont été modifiées"
        //                 })
        //             }
        //             else {
        //                 return res.status(500).json({
        //                     "request": 0,
        //                     "result": "Erreur, veuillez réessayer ulterieurement"
        //                 })
        //             }
        //         })
        //     }
        //     else {
        //         return res.status(500).json({
        //             "request": 0,
        //             "result": "Erreur, veuillez réessayer ulterieurement"
        //         })
        //     }
        // })
        db.query('UPDATE prices set prices.isActive = false WHERE prices.idPrice = "' + idPrice + '"', function (err, response2, fields) {
            if (err) throw err;
            if (response2) {
                return res.status(201).json({
                    "request": 1,
                    "result": "L'article a été supprimé de la liste"
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur, veuillez réessayer ulterieurement."
                })
            }
        })
    },

    currentSales: function (req, res) {
        let id = req.body.id
        if (id == undefined) {
            id = req.query.id
        }
        console.log(id)
        db.query('SELECT articles.image, articles.name, articles.type, prices.price_base, sales.idSale, sales.price, DATE_FORMAT(sales.date_start, "%Y/%m/%d") as "date_start", DATE_FORMAT(sales.date_end, "%Y/%m/%d") as "date_end"  FROM sales, prices, articles, shops, shopUsers WHERE prices.idSales = sales.idSale AND prices.idShop = shops.idShop  AND prices.idArticle = articles.idArticle and shops.idShop = shopUsers.idShop and shopUsers.identifier = "' + id + '" AND now() < sales.date_end AND prices.idSales > 0 AND prices.isActive = true AND sales.isActive = true', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "response": response
                })
            }
            else {
                return res.status(400).json({
                    "request": 0,
                    "result": "Aucune promotion en cours",
                    "response": {
                        "image": "",
                        "name": "",
                        "type": "",
                        "price_base": 0,
                        "idSale": 0,
                        "price": 0,
                        "date_start": "",
                        "date_end": ""
                    }
                })
            }
        })
    },

    oldSales: function (req, res) {
        let id = req.body.id
        if (id == undefined) {
            id = req.query.id
        }
        console.log(id)
        db.query('SELECT articles.image, articles.name, articles.type, prices.price_base, sales.idSale, sales.price, DATE_FORMAT(sales.date_start, "%Y/%m/%d") as "date_start", DATE_FORMAT(sales.date_end, "%Y/%m/%d") as "date_end"  FROM sales, prices, articles, shops, shopUsers WHERE prices.idSales = sales.idSale AND prices.idShop = shops.idShop  AND prices.idArticle = articles.idArticle and shops.idShop = shopUsers.idShop and shopUsers.identifier = "' + id + '" AND now() > sales.date_end AND prices.idSales > 0 AND prices.isActive = true AND sales.isActive = true', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "response": response
                })
            }
            else {
                return res.status(400).json({
                    "request": 0,
                    "result": "Aucune promotion en cours",
                    "response": {
                        "image": "",
                        "name": "",
                        "type": "",
                        "price_base": 0,
                        "idSale": 0,
                        "price": 0,
                        "date_start": "",
                        "date_end": ""
                    }
                })
            }
        })
    },

    addSale: function (req, res) {
        const idPrice = req.body.idPrice;
        const price = req.body.price;
        const date_start = req.body.date_start;
        const date_end = req.body.date_end;

        const dateStart = Date.parse(date_start);
        const dateEnd = Date.parse(date_end);
        const now = Date.parse("2020-05-28:23:59:59");
        const difference = now - dateStart;
        console.log(now)
        console.log(dateStart)
        console.log(now - dateStart)
        console.log(req.body.idPrice);
        if (idPrice == undefined) {
            return res.status(400).json({
                "request": 0,
                "result": "L'article à promotionner n'a pas été selectionné"
            })
        }

        if (price == undefined || date_start == undefined || date_end == undefined) {
            return res.status(400).json({
                "request": 0,
                "result": "Paramètre manquant"
            })
        }

        if (difference > 79199000) {
            return res.status(400).json({
                "request": 0,
                "result": "La date de début ne peut pas être antérieur à la date d'aujourd'hui"
            })
        }

        if (dateEnd < dateStart) {
            return res.status(400).json({
                "request": 0,
                "result": "La date de fin ne peut pas être antérieur à la date de début"
            })
        }

        db.query('INSERT INTO sales (price, date_start, date_end, idPrice, createdAt, updatedAt, isActive) VALUES ("' + price + '", "' + date_start + '", "' + date_end + '", "' + idPrice + '", now(), now(), true);', function (err, response, fields) {
            if (err) throw err;
            if (response) {
                db.query('SELECT last_insert_id() as "id"', function (err, response2, fields) {
                    if (err) throw err;
                    if (response2.length > 0) {
                        console.log(response2[0]["id"]);
                        const id = parseInt(response2[0]["id"]);
                        db.query('UPDATE prices set idSales = "' + id + '" WHERE idPrice = "' + idPrice + '"', function (err, response3, fields) {
                            if (err) throw err;
                            if (response3) {
                                return res.status(201).json({
                                    "request": 1,
                                    "result": "La promotion à été enregistrée"
                                })
                            }
                            else {
                                return res.status(500).json({
                                    "request": 0,
                                    "result": "Erreur, veuillez reessayer ulterieurement"
                                })
                            }
                        })
                    }
                    else {
                        return res.status(500).json({
                            "request": 0,
                            "result": "L'id de la promotion lors de sa creation n'a pas été retourné"
                        })
                    }
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur, veuiller réessayer ultérieurement"
                })
            }
        })

    },

    updateSale: function (req, res) {

        let idSale = req.body.idSale;
        let price = req.body.price;
        let date_start = req.body.date_start;
        let date_end = req.body.date_end;

        console.log("idSale : " + idSale);
        console.log("price : " + price);
        console.log("date_start : " + date_start);
        console.log("date_end : " + date_end);

        if (price == null || date_start == null || date_end == null) {
            return res.status(500).json({
                "request": 0,
                "result": "Paramètre manquant"
            })
        }

        db.query('UPDATE sales set price = "' + price + '", date_start = "' + date_start + '", date_end = "' + date_end + '", updatedAt = now() WHERE sales.idSale = "' + idSale + '"', function (err, response, fields) {
            if (err) throw err;
            if (response) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Promotion modifié"
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur, veuiller réessayer ultérieurement"
                })
            }
        })
    },

    deleteSale: function (req, res) {

        let idSale = req.body.idSale

        if (idSale == undefined) {
            idSale = req.query.idSale
        }

        db.query('UPDATE sales set sales.isActive = false WHERE sales.idSale = "' + idSale + '"', function (err, response2, fields) {
            if (err) throw err;
            if (response2) {
                return res.status(201).json({
                    "request": 1,
                    "result": "La promotion a été supprimé de la liste"
                })
            }
            else {
                return res.status(500).json({
                    "request": 0,
                    "result": "Erreur, veuillez réessayer ulterieurement."
                })
            }
        })
    }
}