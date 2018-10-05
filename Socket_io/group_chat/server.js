var express = require("express");
var path = require("path");
var bodyParser = require('body-parser');
var session = require('express-session');
var id = 0;
// create the express app
var app = express();
app.use(bodyParser.urlencoded());
// static content
app.use(express.static(path.join(__dirname, "./static")));
// setting up ejs and our views folder
app.set('views', path.join(__dirname, './views'));
app.set('view engine', 'ejs');
const server = app.listen(8000); 
var io = require('socket.io')(server);
var users = [];
var posts = [];

io.sockets.on('connection',function(socket){
    socket.emit('connected',{msg: 'You are connected to a socket.'})
    socket.on('got_new_user',function(data){
        id += 1
        session = {user: data.name, id: id };
        var other_users = users;
        socket.emit('other_users',{users: other_users})
        users.push(session);
        console.log(users)
        io.emit('new_user',{data: session})
        io.emit('all_posts',{previous_posts:posts})
    })
    socket.on('disconnect',function(data){
        for(let i = 0; i < users.length; i++){
            if (users[i].id == session.id){
                var trash = users.splice(i,1);
                console.log(trash)
                console.log(users)
            }
        }
    })
    socket.on('new_post',function(data){
        let new_post = {user:session, post:data};
        posts.push(new_post);
        socket.emit('recieved_new_post',{post:new_post});
    })
})
app.get('/',function(req,res){
    res.render('index')
})