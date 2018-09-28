var express = require("express");
var app = express();

app.use(express.static(__dirname + "/static"));

app.set('views', __dirname + '/views');

app.set('view engine', 'ejs');

app.get('/cars',function(request,response){
  response.render('cars.ejs');
})
app.get('/cats',function(request,response){
  response.render('cats.ejs');
})
app.get('/cats/1',function(request,response){
  var catInfo = {'name': 'Ugly Cat', 'favorite_food': "Rice", 'age': 1, "sleeping_spots":['bed'], 
  'img_url': "/images/Cat1.jpeg" }
  response.render("details.ejs",{'data':catInfo})
})
app.get('/cats/2',function(request,response){
  var catInfo = {'name': 'Fancy Cat', 'favorite_food': "Pasta", 'age':2, "sleeping_spots":['bed',],
  'img_url': "/images/Cat2.jpeg" }
  response.render("details.ejs",{'data':catInfo})
})
app.get('/cats/3',function(request,response){
  var catInfo = {'name': 'Pretty Cat', 'favorite_food': "Tofu", 'age': 3,"sleeping_spots":['bed',], 
  'img_url': "/images/Cat3.jpeg" }
  response.render("details.ejs",{'data':catInfo})
})
  app.get('/form',function(request,response){
    response.render('form.ejs');
})
app.listen(8000, function(){
    console.log("listening on port 8000");
});