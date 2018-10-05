// require express
const express = require("express");
// path module -- try to figure out where and why we use this
const path = require("path");
// create the express app
const app = express();
var bodyParser = require('body-parser');
var session = require('express-session');

//use it!
app.use(bodyParser.urlencoded({ extended: true }));
// static content
app.use(express.static(path.join(__dirname, "./static")));
// setting up ejs and our views folder
app.set('views', path.join(__dirname, './views'));
app.set('view engine', 'ejs');
const server = app.listen(8000); 
const io = require('socket.io')(server);
var times = 0;
io.sockets.on('connection',function(socket){
    socket.emit('greeting', { msg: 'Greetings, from server Node, brought to you by Sockets! -Server' }); //3
    socket.emit('new_number',{times: times})
    socket.on('epic_button',function(){
        times += 1;
        socket.emit('new_number',{times: times})
    })
    socket.on('reset',function(){
        times = 0;
        socket.emit('new_number',{times: times})
    })
})
app.get('/',function(req,res){
    res.render('index')
})

// tell the express app to listen on port 8000
//app.listen(8000, function() {
//    console.log("listening on port 8000");
//   });