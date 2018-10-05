const express = require('express');
app = express();
const bodyParser = require('body-parser');
// Integrate body-parser with our App
app.use(bodyParser.urlencoded({ extended: true }));
// Require path
const path = require('path');
// Setting our Static Folder Directory
app.use(express.static(path.join(__dirname, './static')));
// Setting our Views Folder Directory
app.set('views', __dirname + '/views'); //making files in views folder available for routing
// Setting our View Engine set to EJS
app.set('view engine', 'ejs');
//Allow for session
const session = require('express-session');
app.use(session({
    secret: 'keyboardkitteh',
    resave: false,
    saveUninitialized: true,
    cookie: { maxAge: 60000 }
  }))
//Allow for flash messages
const flash = require('express-flash');
app.use(flash());
// Require mongoose to interact with the MongoDB database
const mongoose = require('mongoose');
mongoose.connect('mongodb://localhost:56596/basic_db',{useNewUrlParser: true});
const {Schema} = mongoose;
const UserSchema = new Schema({
    first_name:{
        type: String,
        required:[true,"First Name required to register"]
    },
    last_name: {
        type: String,
        required:[true,"Last Name required to register"]
    },
    email:{
        type: String,
        required:[true,"Must have a valid email"],
        match: [/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, 'Please fill a valid email address']
    },
    birthday: {
        day:{type: Number,required:[true,"A birth day is required for registration"],min:1,max:31},
        month:{type: Number, required:[true,"A birth month is required for registration"],min:1,max:12},
        year:{type: Number, required:[true,"A birth year is required for registration"],min:1900,max:2018}
    },
    password:{
        type:String,
        required:[true,'A password is required'],
        minlength: 8,
    }
})
mongoose.model('User',UserSchema);
var User = mongoose.model('User');
const bcrypt = require('bcrypt');


app.get('/',function(request,response){
    response.render('index')
})

app.post('/register',function(request,response){
    new User({first_name:request.body.first_name,last_name:request.body.last_name,birthday:{day:request.body.day, month: request.body.month, year: request.body.year},email:request.body.email,password:request.body.password}).validate()
        .then((user)=>{
           bcrypt.hash(user.password,10)
                .then((hashed_pass)=>{
                    user.password = hashed_pass;
                })
                .catch((error)=>{
                    for(var key in error.errors){
                        request.flash('registration', error.errors[key].message);
                    }
                    // redirect the user to an appropriate route
                    response.redirect('/')
                })
            user.save()
                .then((user)=>{
                    response.redirect('/')
                })
                .catch((error)=>{
                    for(var key in error.errors){
                        request.flash('registration', error.errors[key].message);
                    }
                    // redirect the user to an appropriate route
                    response.redirect('/')
                })
        })
        .catch((error)=>{
            for(var key in error.errors){
                request.flash('registration', error.errors[key].message);
            }
            // redirect the user to an appropriate route
            response.redirect('/')
        })
})

app.post('/login',function(request,response){
    User({email:request.body.email,password:request.body.password}).validate()
        .then((user)=>{
            bcrypt.hash(request.body.password,10)
        .then((hashed_pass)=>{
            User.find({email:request.body.email,password: hashed_pass})
                .then((user)=>{
                    request.session = {first_name:user.first_name,last_name:user.last_name,email:user.email,birthday:user.birthday};
                    response.redirect('/dashboard')
                })
                .catch((error)=>{
                    for(var key in error.errors){
                        request.flash('login', error.errors[key].message);
                    }
                    // redirect the user to an appropriate route
                    response.redirect('/')
                })
        })
        .catch((error)=>{
            for(var key in error.errors){
                request.flash('login', error.errors[key].message);
            }
            // redirect the user to an appropriate route
            response.redirect('/')
        })
    })
})

app.listen(8000)