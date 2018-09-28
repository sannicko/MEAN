function Person (name){  //creating object object constructor
  this.name = name;  //property name equal to a value

  //adding functions to objects

  Person.prototype.sayHello = function() {
console.log(`Hello, my name is ${ this.name }`);
  };
  
}
const person = new Person('Peter');  //calling the constructure function and giving a name 

console.log(person);  //print the kind of object and the property
person.sayHello();

function Parent (name){  //new class constructor function
  Person.call(this, name); //calling the function inherance
  
}

Parent.prototype = Object.create(Person.prototype);
Parent.prototype.constructor = Parent; //assign the constructor to the object in order to be the correct object Parent. 

Parent.prototype.assignChores = function(child, chore) {
  const payment = random(100);

  return new Promise (function(resolve, reject) {
    setTimeout

  });


}

//creating function random
function random (arrayOrNumber) {
  return Math.floor(
    Math.random() * (Array.isArray(arrayOrNumber) ? arrayOrNumber.length : arrayOrNumber)
  );
}



const parent = new Parent (`Jason`); //creating a new parent object

console.log(parent); //how do you get the prototype change? you have to assign objects in order to do it.
parent.sayHello();


function Child(name){
  Person.call(this, name);

  this.savings = 0;

}

Child.prototype = Object.create(Person.prototype);
Child.prototype.constructor = Child;

//Methods

