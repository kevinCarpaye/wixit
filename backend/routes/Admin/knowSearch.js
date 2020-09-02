const db = require('../../config/db');
const path = require('path');
const fs = require('fs');
const csv = require('csv-parser');

// module.exports = {

//     testcsv: function(req, res) {
//         db.query('SELECT * from sought', function(err, response, fields) {
//             if (err) throw err;
//             if (response.length > 0) {
//                 console.log(response);
//             }
//         })
//     }

// }