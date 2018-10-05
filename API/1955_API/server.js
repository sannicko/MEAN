var express = require('express');
var app = express();
var path = require('path');
var bodyParser = require('body-parser');
app.use(bodyParser.json());

var mongoose = require('mongoose');
mongoose.connect('mongodb://localhost/1955');
//schema
var PersonSchema = new mongoose.Schema({
    name: {type:String, required: [true, "Name is required!"]}}, {timestamps: true});

   mongoose.model('Person', PersonSchema); // We are setting this Schema in our Models 
   var Person = mongoose.model('Person'); // We are retrieving this Schema from our Models, named 'User'
//route

app.get('/', function(req, res){
    Person.find({})
        .then(person => res.json(person))
        .catch(err => res.json(err));
})

app.get('/new/:name/', function(req,res){
    Person.create(req.params)
        .then(person => res.json(person))
        .catch(err => res.json(err));
})

app.get('/remove/:name/', function(req, res){
    Person.remove(req.params)
        .then(person => res.json(person))
        .catch(err => res.json(err));
})

app.get('/:name', function(req, res){
    Person.findOne(req.params)
        .then(person=> res.json(person))
        .catch(err => res.json(err));
})
mongoose.Promise = global.Promise;

app.listen(8000, function() {
    console.log("listening on port 8000");
})