const express = require('express');
const app = express();

var bodyParser = require('body-parser');
app.use(bodyParser.urlencoded({extended: true}));

app.set('views', __dirname + '/views'); 
app.set('view engine', 'ejs');

const server = app.listen(8000);
const io = require('socket.io')(server);
io.on('connection', socket => { 
  console.log('incoming socket connection');
    
  socket.on('posting_form', function(data){
    var random_number = Math.floor(Math.random()*1000 + 1);
    socket.emit('updated_message',{response: data});
    socket.emit('random_number',{response:  random_number});
  });
});
app.get('/',function(req,res){
    res.render('main.ejs');
})