const mongoose = require('mongoose');
const quotes = require('../controllers/quotes.js');
module.exports = function (app){
    app.get('/', function(req, res) {
        quotes.index(req,res);
    })

    app.post('/quotes', function (req, res){
      quotes.create(req, res);

    })
    app.get('/quotes',function(req,res){
       quotes.show(req, res);
    })

  };