// Art'Gil972
const woocommerce = require('../../shops/woocommerces/frecinette');
const db = require("../../config/db");

woocommerce.get("products", { "per_page": 100, "page": 1 }).then((response) => {
  //console.log(response.data);
  let nombre = 0;
  var totalPage = response.headers['x-wp-totalpages'];
  console.log("Nombre total de page:", response.headers['x-wp-totalpages']);
  const shop = { name: "Frecinette", number: "0596725859", adress: "370 Rue Léon Gontran Damas, Cité Dillon, Fort-de-France 97200, Martinique", website: "", informations: "", latitude: 14.6081, longitude: -61.0489, image: "/images/shopsPicture/frecinette.jpg", logo: "/images/shopLogo/frecinette_logo.png", createdAt: "2020-08-04", updatedAt: "2020-08-04" }
  db.query('INSERT INTO shops (name, number, adress, website, informations, latitude, longitude, image, logo, createdAt, updatedAt) VALUES ("' + shop.name + '", "' + shop.number + '", "' + shop.adress + '", "' + shop.website + '", "' + shop.informations + '","' + shop.latitude + '", "' + shop.longitude + '", "' + shop.image + '", "' + shop.logo + '", "' + shop.createdAt + '", "' + shop.updatedAt + '")')
  let idShop = 0;
  let idArticle = 0;
  db.query('SELECT last_insert_id() as "id"', function (err, response, fields) {
    if (err) throw err;
    if (response.length > 0 && response != undefined) {
      idShop = response[0]["id"];
      for (let i = 1; i <= totalPage; i++) {
        let array = [];
        woocommerce.get("products", { "per_page": 100, "page": i }).then((response) => {
          response.data.forEach(element => {
            //console.log(response.data);
            let price = 0;
            element.price > 0 ? price = element.price : price = 0
            const product = {
              product: { id: element.id, name: element.name, barcode: "", type: element.categories[0].name, image: element.images[0].src, description: element.short_description /*createdAt: element.date_created, updatedAt: element.date_modified */ },
              price: { idArticle: 0, idShop: 0, price_base: price  , stock: -1, idSales: 0, link : element.permalink  }, // createdAt and updatedAt by my database server
              sale: { price: element.sale_price, date_start: element.date_on_sale_from, date_end: element.date_on_sale_to }
            }
            array.push(product);
            nombre++;
            //console.log("Son id: " + product.product.id + "|| Son rang : " + nombre);
            //console.log(product);
          })
        }).then(result => {
          console.log(array.length)
          // db.query('SELECT last_insert_id() as "id"', function (err, response, fields) {
          //   if (err) throw err;
          console.log("ID du magasin : " + response[0]["id"]);
          for (let i = 0; i < array.length; i++) {
            db.query('INSERT INTO articles (name, barcode, type, image, description, createdAt, updatedAt) VALUES ("' + array[i].product.name + '", "' + array[i].product.barcode + '", "' + array[i].product.type + '", "' + array[i].product.image + '", "", NOW(), NOW())')
            db.query('SELECT last_insert_id() as "id"', function (err, response, fields) {
              if (err) throw err;
              if (response.length > 0 && response[0]["id"] != undefined) {
                idArticle = response[0]["id"];
                console.log("ID du produit : " + response[0]["id"]);
                db.query('INSERT INTO prices (idArticle, idShop, price_base, stock, idSales, link, createdAt, updatedAt, isActive) VALUES ("' + idArticle + '", "' + idShop + '", round("' + array[i].price.price_base + '", 2), "' + array[i].price.stock + '", "' + array[i].price.idSales + '", "'+array[i].price.link+'", NOW(), NOW(), true)')
                db.query('SELECT last_insert_id() as "id"', function (err, response1, fields) {
                  console.log("ID du prix : " + response1[0]["id"])
                  if (err) throw err;
                  if (response1.length > 0 && response1[0]["id"] != undefined) {
                    let idPrice = response1[0]["id"];
                    if (array[i].sale.price > 0) {
                      db.query('INSERT INTO sales (price, date_start, date_end, idPrice, createdAt, updatedAt, isActive) VALUES (round("' + array[i].sale.price + '", 2), "' + array[i].sale.date_start + '", "' + array[i].sale.date_end + '", "' + idPrice + '", NOW(), NOW(), true)', function (err, response, fields) {
                        if (err) throw err;
                        if (response) {
                          db.query('SELECT last_insert_id() as "id"', function (err, response2, fields) {
                            if (err) throw err;
                            if (response2.length > 0 && response2[0]["id"] != undefined) {
                              let idSale = response2[0]["id"];
                              db.query('UPDATE prices set idSales = "' + idSale + '" WHERE idPrice = "' + idPrice + '"', function (err, response3, fields) {
                                if (err) throw err;
                                if (response3) {
                                  // return res.status(201).json({
                                  //   "request": 1,
                                  //   "result": "L'article a bien été enregistré"
                                  // })
                                }
                                else {
                                  // return res.status(400).json({
                                  //   "request": 0,
                                  //   "result": "Erreur, veuillez reessayer ulterieurement"
                                  // })
                                }
                              })
                            }
                          })
                        }
                      })
                    }
                    else {
                      // return res.status(400).json({ 
                      //   "": "" })
                    }
                  }
                  else {
                    // return res.status(400).json({
                    //   "request": 0,
                    //   "result": "Problème lors de la création du prix de l'article en base de données"
                    // });
                  }
                })
              }
              else {
                // return res.status(400).json({
                //   "request": 0,
                //   "result": "Problème lors de l'article en base de données"
                // });
              }
            })
          }
          // })
        })
      }
    }
    else {
      return res.status(400).json({
        "request": 0,
        "result": "Problème lors de la création de magasin en base de données"
      });
    }
  })
}).catch((error) => {
  console.log(error.response.data);
});

