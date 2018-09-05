// get the http module:
var http = require('http');
// fs module allows us to read and write content for responses!!
var fs = require('fs');
   //creating a server using http module:
var server = http.createServer(function (request, response){

    console.log('client request URL: ', request.url);
    // this is how we do routing:
    if(request.url === '/') {
        fs.readFile('index.html', 'utf8', function (errors, contents){
            response.writeHead(200, {'Content-Type': 'text/html'});
            response.write(contents);
            response.end();
        });
    }
    else if (request.url === "/ninjas.html") { 
        fs.readFile('ninjas.html', 'utf8', function (errors, contents){
            response.writeHead(200, {'Content-type': 'text/html'});
            response.write(contents); 
            response.end();
        });
    }
    else if (request.url === "/dojos.html") {
         fs.readFile('dojos.html', 'utf8', function (errors, contents){
             response.writeHead(200, {'Content-type': 'text/html'});
             response.write(contents); 
             response.end();
         });
    }
});
server.listen(6789);
console.log("Running in localhost at port 6789");