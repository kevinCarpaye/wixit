
const bcrypt = require('bcrypt');
const db = require('./config/db');
const path = require('path');
const fs = require('fs');
const csv = require('csv-parser');
const soughts = [];

const dirnames = {
  sync: "createdDir",
  async: "asyncCreatedDir",
};

function printBoom() {
  console.log("Boom")
}

// fs.mkdirSync(dirnames.sync);

// fs.writeFileSync(`${dirnames.sync}/file.js`,`(${printBoom.toString()}())`);
// Destination pour l'ajout d'article de part les commerciaux
// const storageAddedPicture = multer.diskStorage({
//     destination: './public/images/articlesAddedPicture/',
//     filename: function (req, file, cb) {
//         //cb(null, file.fieldname + '-' + Date.now() + path.extname(file.originalname));
//         cb(null, fileName + path.extname(file.originalname));
//     }
// });

// fs.mkdir("public/images/articlesPicture/dirnames.async", (err) => {
//     if (err) {
//         console.log("Le dossié est déja crée");
//     }
//     else {
//         console.log(`${dirnames.async} created`);
//     }
//  })

// fs.stat('aticlesPicture', function(err) {
//     if (!err) {
//         console.log('file or directory exists');
//     }
//     else if (err.code === 'ENOENT') {
//         console.log('file or directory does not exist');
//     }
// });

//--------------------------------------------------------------------- création du CSV

// db.query('SELECT * from sought', function (err, response, fields) {
//     if (err) throw err;
//     if (response.length > 0) {
//         console.log(response); 
//         response.forEach(element => {
//             soughts.push(element);
//         });
//         const filename = 'output.csv';
//     fs.writeFile(filename, extractAsCSV(soughts), err => {
//       if (err) {
//         console.log('Error writing to csv file', err);
//       } else {
//         console.log(`saved as ${filename}`);
//       }
//     });
//     }
// })

// function extractAsCSV(soughts) {
//   const header = ["Name, Barcode, idUser, soughtAt"];
//   const rows = soughts.map(user =>
//      `${user.name}, ${user.barcode}, ${user.idUser}, ${user.soughtAt}`
//   );
//   return header.concat(rows).join("\n");
// }
//--------------------------------------------------------------------------
// if (! fs.existsSync('public/images/articlesPicture/ff')) {
//     try {
//         fs.mkdirSync('public/images/articlesPicture/ff', { recursive: true });
//     } catch (error) {
//         console.log(error.message);
//     }
// }
// else {
//     console.log("file or directory already exist")
// }

// const mdp = "test";

// bcrypt.hash(mdp, 5, function(err, bcrypted) {
//     if (err) {
//         console.log(err)
//     }
//     if(bcrypted) {
//         console.log(bcrypted)
//     }
// })

const woocommerce = require('./shops/woocommerces/jaquelineHaustant');
//const db = require("../../config/db");
//const shop = { name: "Art'Gil", number: "0696835663", adress: "Quartier Humbert, 97280 Le Vauclin", informations: "Fabrication d'objets décoratifs en céramique, spécialisée dans les crèches et santons antillais.", latitude: 14.5456332, longitude: 60.8413191, image: "https://www.jaquelinehaustant.fr/wp-content/uploads/2020/07/logo-Art-Gil-1-e1594922502703.png", logo: "https://www.jaquelinehaustant.fr/wp-content/uploads/2020/07/logo-Art-Gil-1-e1594922502703.png", createdAt: 2020 - 07 - 17, updatedAt: 2020 - 07 - 17 }

woocommerce.get("products").then((response) => {
  //console.log(response.data);
  response.data.forEach(element => {
    console.log(response.data.length);
    const jht = {
      article: { id: element.id, name: element.name, barcode: "", type: element.type, images: element.images[0].src, description: element.description, createdAt: element.date_created, updatedAt: element.date_modified },
    }
    console.log(jht);
  })
}).catch((error) => {
  console.log(error.response.data);
})
