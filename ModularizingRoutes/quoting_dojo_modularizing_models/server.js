const express = require('express');
const app = express();
const bodyParser = require('body-parser');

const path = require('path');

app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, './static')));
app.set('views', path.join(__dirname, './views'));
app.set('view engine', 'ejs');

require('../server/config/mongoose.js');
require('./server/config/routes.js')(app)

app.listen(8000, function() {
    console.log("listening on port 8000");
})