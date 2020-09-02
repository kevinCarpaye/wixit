const express = require('express');
const apiRouter = require('./apiRouter').router;
const bodyParser = require('body-parser');
const ejs = require('ejs');
const sequelize = require('./config/Sequelize');
const cors = require('cors');
const helmet = require('helmet');
const compression = require('compression');
const morgan = require('morgan');

const port = process.env.PORT || 4000;

let server = express();

server.use(cors());

server.use(helmet());
server.use(compression());  // Middlewaire de compression si l'hebergeur ne le propose pas de base
server.use(morgan('combined'));

server.set('view engine', 'ejs');

server.use(express.static('./public'));

server.use(bodyParser.urlencoded({extended: false}));
server.use(bodyParser.json());

server.use('/api/', apiRouter);


sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });

server.get('/', function(req, res) {
    res.setHeader('Content-type','text/html');
    res.status(200).send('<H1>Bienvenue sur le server de Wixit</h1>');
});

server.listen(port,  function() {
    console.log('Server en écoute sur le port ' + port)
})

