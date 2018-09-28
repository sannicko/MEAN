
function Person(name) { //Person object is the class
  this.name = name;
}
//method
//adding function using prototype is just an object and add properties and assign values

Person.prototype.sayHello = function() {
  console.log('Hello world, my name is ' + this.name );
};

const person = new Person('Nick');

console.log(person);
person.sayHello();

//inherance in JS
function Parent (name) { // This is the constructor function Parent object is the class, this method only get the properties not the prototype chain
  Person.call(this, name); //person constructor, call the person constructor and pass the parent instance. 
}
//inherance in JS
//get the prototype of the Person and assign to the Parent
Parent.prototype = Object.create(Person.prototype);
Parent.prototype.constructor = Parent;

const parent = new Parent ('Peter Pan'); //creating a new parent

console.log(parent.sayHello());
console.log(parent);

