const express = require('express');
const app = express();
const bodyParser = require('body-parser');

const path = require('path');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, './static')));
app.set('views', path.join(__dirname, './views'));
app.set('view engine', 'ejs');


const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/basic_mongoose');

var UserQuoteSchema = new mongoose.Schema({
  name:  { type: String, required: true, minlength: 6},
  quote: { type: String, required: true},
}, {timestamps: true });

//store schema:

mongoose.model('UserQuote', UserQuoteSchema);
var UserQuote = mongoose.model('UserQuote');

require('./server/config/routes.js')(app)

app.listen(8000, function() {
    console.log("listening on port 8000");
})