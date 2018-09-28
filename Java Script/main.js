//create and define variables

var myStr = 'some string content';

console.log(myStr);

myStr = 9879;

console.log(myStr);

var array = ['cat', 'dog'];

console.log(array);

array.push('new content');

console.log(array[0]);

for (var index = 0; index < array.length; index++){
  console.log('index', array[index]);

}

console.log('after', index);

for (var index in array){
  console.log('index', array[index]);

}

for (var thing of array.entries()){  //using method entries
  var index = thing[0];
  var entry = thing[1];
  
  console.log('thing', thing, index, entry);
}

//objects

//age, eyes, height
var person = {
  'age':23,
  'hairColor': 'blue',
  height: 6,
  'eye-color': 'purple',
  key: 'my key'
};
console.log('person age is ', person['age'], 'years old!!!'); //add the properties of the object in [] and string

for(var key in person){
  console.log('key', key); //this is going to print just the key of the object
}

for(var key in person){
  console.log('key', person[key], key); //this is going to print just the key of the object
}                           //this key access the variable and the next, key access the properties.
//undefined is the absence of a value

//functions

function sayHello(name, boolean, age){
  console.log(arguments);
  console.log('Hellooo ', name, 'the boolean is: ', boolean, 'and he is ', age + " years old" );

  return name;
}

console.log ('return content', sayHello('PeterPan', true, 575));

function sayHello(name, ...rest){  //to access the rest parameter you can call it whatever you want, collect the rest of the information
  console.log(rest);
  console.log(person); //access global objects
  console.log('Hellooo ', name );

  return name;
}

console.log ('return content', sayHello('PeterPan', true, 575)); 

//objects
//scoope - visibility of some information
//variables are function scoopes, global scoope, child scoope

console.log(index);
console.log('after', index);

// const is a constant
// let allows to mutate the information

for (let index = 0; index < array.length; index++){
  console.log('index', array[index]);
}
console.log(index);


//var count = 0; //global information you should avoid them

function counter(){  
  var count = 0;

  function childScope(){
    console.log('child called');
    return ++count;
  }
  return childScope;
}
counter = counter ();

console.log(counter());
console.log(counter());

//passing one function to another function, this is nice JavaScript trick, very common take on function and pass it into another function

function anotherFunc(func){
  console.log(func);
}

anotherFunc(counter);


