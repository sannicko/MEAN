const express = require("express");
const path = require("path");
const bodyParser = require('body-parser');
const session = require('express-session');
const app = express();
const axios = require('axios');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, "./static")));
app.use(session({secret: 'keyboardkitteh',   
resave: false,
saveUninitialized: true,
cookie: { maxAge: 60000 }
}));

app.set('views', path.join(__dirname, './views'));
app.set('view engine', 'ejs');
app.get('/', function(req, res) {
 res.render('index');
})
app.get('/people', (req,res) => {
    axios.get('https://swapi.co/api/people')
    .then((data) => {
      console.log("got the data", data.data);
      res.send(data.data);
      })
    .catch((error) => {
      res.json(error);
    });     
  });  
  app.get('/planets', (req,res) => {
    axios.get('https://swapi.co/api/planets')
    .then((data) => {
      console.log("got the data", data.data);
      res.send(data.data);
      })
    .catch((error) => {
      res.json(error);
    });     
  });  
app.listen(8000, function() {
    console.log("listening on port 8000");
});