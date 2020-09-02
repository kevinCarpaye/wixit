const Shop = require('../../models/shops');
const db = require('../../config/db');
const bcrypt = require('bcrypt');

module.exports = {

    shopsList: function (req, res) {

        db.query('SELECT name, number, adress, informations, latitude, longitude, image, logo FROM shops', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "shop": response
                })
            }
            else {
                return res.status(404).json({
                    "request": 0,
                    "result": "Found",
                    "shop": {
                        "name": "",
                        "number": '',
                        "adress": "",
                        "informations": '',
                        "latitude": 0.0,
                        "longitude": 0.0,
                        "image": 'images/shopsPicture/auchan_logo.png',
                        "logo": "",
                    }
                })
            }
        })

        // Shop.findAll({
        //     attributes: ['name', 'number', 'adress', 'informations', 'latitude', 'longitude', 'image', 'logo']
        // }).then(function (shopFound) {
        //     if (shopFound) {
        //         return res.status(201).json({
        //             "request": 1,
        //             "result": "Found",
        //             "shop": shopFound
        //         })
        //     }
        //     else {
        //         return res.status(404).json({
        //             "request": 0,
        //             "result": "Found",
        //             "shop": {
        //                 "name": "",
        //                 "number": '',
        //                 "adress": "",
        //                 "informations": '',
        //                 "latitude": 0.0,
        //                 "longitude": 0.0,
        //                 "image": 'images/shopsPicture/auchan_logo.png',
        //                 "logo": "",
        //             }
        //         })
        //     }

        // })
    },

    shopsListFetch: function (req, res) {

        let name = req.query.name;

        db.query('SELECT shops.name, shops.number, shops.adress, shops.informations, shops.latitude, shops.longitude, shops.image, shops.logo FROM shops WHERE name like "%' + name + '%"', function (err, response, fields) {
            if (err) throw err;
            if (response) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "shop": response
                })
            }
            else {
                return res.status(404).json({
                    "request": 0,
                    "result": "Found",
                    "shop": {
                        "name": "",
                        "number": '',
                        "adress": "",
                        "informations": '',
                        "latitude": 0.0,
                        "longitude": 0.0,
                        "image": 'images/shopsPicture/auchan_logo.png',
                        "logo": "",
                    }
                })
            }
        })

        Shop.findAll({
            attributes: ['name', 'number', 'adress', 'informations', 'latitude', 'longitude', 'image']
        }).then(function (shopFound) {
            if (shopFound) {
                return res.status(201).json({
                    "request": 1,
                    "result": "Found",
                    "shop": shopFound
                })
            }
            else {
                return res.status(404).json({
                    "request": 0,
                    "result": "Found",
                    "shop": {
                        "name": "",
                        "number": '',
                        "adress": "",
                        "informations": '',
                        "latitude": 0.0,
                        "longitude": 0.0,
                        "image": 'images/shopsPicture/auchan_logo.png'
                    }
                })
            }

        })
    },

    shopLogin: function (req, res) {

        let id = req.body.id;
        let password = req.body.password;

        if (id == undefined || password == undefined) {
            id = req.query.id;
            password = req.query.password;
        }

        if (id == null || password == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Veuillez remplir les deux champs",
                "response": {
                    "identifier": "",
                    "name": "",
                    "image": ""
                }
            })
        }

        db.query('SELECT shopUsers.identifier, shops.idShop, shops.name, shops.image, shops.adress, shops.logo, shops.informations, shops.longitude, shops.latitude, shops.number, shopUsers.password FROM shops, shopUsers WHERE shopUsers.idShop = shops.idShop AND shopUsers.identifier = "' + id + '"', function (err, response, field) {
            if (err) throw err;
            if (response.length > 0) {
                bcrypt.compare(password, response[0]["password"], function (errBycrypt, resBycript) {
                    console.log(response[0]["password"])
                    if (resBycript) {
                        return res.status(201).json({
                            "request": 1,
                            "result": "Found",
                            "response": {
                                "identifier": response[0]["identifier"],
                                "idShop": response[0]["idShop"],
                                "name": response[0]["name"],
                                "image": response[0]["image"],
                                "adress": response[0]["adress"],
                                "number": response[0]["number"],
                                "logo": response[0]["logo"],
                                "informations": response[0]["informations"],
                                "latitude": response[0]["latitude"],
                                "longitude": response[0]["longitude"],
                            }
                        })
                    }
                    else {
                        return res.status(400).json({
                            "request": 0,
                            "result": "Identifiants inconnus",
                            "response": {
                                "identifier": "",
                                "name": "",
                                "image": ""
                            }
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
    },
    dashboard: function (req, res) {
        let id = req.body.id

        if (id == undefined) {
            id = req.query.id
        }

        if (id == null) {
            return res.status(400).json({
                "request": 0,
                "result": "Aucun identifiant trouvé",
                "response": {
                    "number_articles": 0,
                    "number_sales": 0,
                    "number_current_sales": 0
                }
            })
        }

        db.query('SELECT COUNT(sales.idSale) as "number_sales" FROM sales, prices, shops, shopUsers WHERE prices.idPrice = sales.idPrice AND prices.idShop = shops.idShop and shops.idShop = shopUsers.idShop and shopUsers.identifier = "' + id + '"', function (err, response, fields) {
            if (err) throw err;
            //if (nbArticles) {
            db.query('SELECT COUNT(prices.idPrice) as "number_articles" FROM prices, shops, shopUsers WHERE prices.idShop = shops.idShop and shops.idShop = shopUsers.idShop and shopUsers.identifier = "' + id + '"', function (err, response2, fields) {
                if (err) throw err;
                db.query('SELECT COUNT(sales.idSale) as "number_current_sales" FROM sales, prices, shops, shopUsers WHERE prices.idSales = sales.idSale AND prices.idShop = shops.idShop and shops.idShop = shopUsers.idShop AND sales.date_end > now() AND shopUsers.identifier = "' + id + '"', function (err, response3, fields) {
                    if (err) throw err;
                    db.query('SELECT COUNT(*) AS "redirection" FROM analytics, shops, shopUsers WHERE shops.idShop = shopUsers.idShop AND action = "site" AND shopUsers.identifier = "' + id + '"', function (err, response4, fields) {
                        if (err) throw err;
                        db.query('SELECT COUNT(*) AS "save" FROM analytics, shops, shopUsers WHERE shops.idShop = shopUsers.idShop AND action = "save" AND shopUsers.identifier = "' + id + '"', function (err, response5, fields) {
                            if (err) throw err;
                            db.query('SELECT COUNT(*) AS "route" FROM analytics, shops, shopUsers WHERE shops.idShop = shopUsers.idShop AND action = "route" AND shopUsers.identifier = "' + id + '"', function (err, response6, fields) {
                                if (err) throw err;
                                if (response.length > 0 && response2.length > 0 && response3.length > 0 && response4.length > 0 && response5.length > 0 && response6.length > 0) {
                                    //console.log(response4[0]["redirection"])
                                    return res.status(201).json({
                                        "request": 1,
                                        "result": "",
                                        "response": {
                                            "number_articles": response2[0]["number_articles"],
                                            "number_sales": response[0]["number_sales"],
                                            "number_current_sales": response3[0]["number_current_sales"],
                                            "redirection": response4[0]["redirection"],
                                            "save": response5[0]["save"],
                                            "route": response6[0]["route"]
                                        }
                                    })
                                }
                                else {
                                    return res.status(400).json({
                                        "request": 0,
                                        "result": "Aucun article présent dans la base de données",
                                        "response": {
                                            "number_articles": 0,
                                            "number_sales": 0,
                                            "number_current_sales": 0,
                                            "redirection": 0,
                                            "save": 0,
                                            "route": 0
                                        }
                                    })
                                }
                            })
                        })
                    })
                })

            })

            //}
            //     else {
            //         return res.status(500).json({
            //             "request": 0,
            //             "result": "Erreur interne veuillez réessayer ultérieurement",
            //             "response": {
            //                 "number_article": 0
            //             }
            //         })
            //     }
        })
    },

    analytics: function (req, res) {

        let shopName = req.body.shopName;
        let action = req.body.action;

        db.query('SELECT idShop FROM shops WHERE name = "' + shopName + '"', function (err, response, fields) {
            if (err) throw err;
            if (response.length > 0) {
                idShop = response[0]["idShop"];
                db.query('INSERT INTO analytics (idShop, action, searchedAt) VALUES ("' + idShop + '", "' + action + '", now())')
            }
        })
        //db.query('INSERT INTO analytics (idShop, action, searchedAt) VALUES ()')
    }
}