const mongoose = require('mongoose');
const Quote = require('../models/quote.js');
module.exports = {
    index: function(req, res) {
    	res.render('index');
    },
    create: function(req, res) {
      var quote = new Quote({name: req.body.name, quote: req.body.quote});
      quote.save(function(err) {
          if (err)
          {
            console.log(err);
          }
          else{
            res.redirect('/quotes');

          }
        })
  },
    show: function(req, res) {
      Quote.find({}, function(err, quotes) {
       if (err) { console.log(err); }
       res.render('quotes', { quotes: quotes });

        })
    }
};