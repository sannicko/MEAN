/* console.log(this);

// the naming convention for Classes and Object Constructors is that they're capitalized and singular
function Person(name, age) {
    var privateVariable = "This variable is private";
    var privateMethod = function() {
        console.log(this);
    }
    this.name = name;
    this.age = age;
    this.greet = function() {
        console.log("Hello my name is " + this.name + " and I am " + this.age + " years old!");
    }
}
var eliza = new Person("Eliza", 48);
console.log(eliza.privateVariable);
// undefined!

function Person(name, age, sex) {
    var privateVariable = "This variable is private";
    var privateMethod = function() {
        console.log(this);
    }
    this.name = name;
    this.age = age;
    this.sex = sex;
    this.greet = function() {
        console.log("Hello my name is " + this.name + " and I am " + this.age + " years old!" + " I am also a " + this.sex + " ");
        // we can access our attributes within the constructor!
        console.log("Also my privateVariable says: " + privateVariable)
        // we can access our methods within the constructor!
        privateMethod();
    }
}
var joe = new Person("Joe", 23, "Male");
//joe.greet();

//This is the 'this' problem workaround//

function Person(name, age, from) {
    // create a private variable that stores a reference to the new object we create
    var self = this;
    var privateVariable = "This variable is private";
    var privateMethod = function() {
        console.log("this is a private method for " + self.name);
        console.log(self);
    }
    this.name = name;
    this.age = age;
    this.from = from;
    this.greet = function() {
        console.log("Hello my name is " + this.name + " and I am " + this.age + " years old!" + " I am from " + this.from );
        // we can access our attributes within the constructor!
        console.log("Also my privateVariable says: " + privateVariable)
        // we can access our methods within the constructor!
        privateMethod();
    }
}
var joe = new Person("Joe", 23, "USA");
//joe.greet();


//.prototype //

var MyObjConstructor = function(name) {
    var myPrivateVar = "Hello"; // just to show that it is difficult to see this private var
    this.name = name; // but you can see the name!
    this.method = function() {
      console.log( "I am a method");
    };
  }
  var obj1 = new MyObjConstructor('object1');
  var obj2 = new MyObjConstructor('object2');
  console.log(obj1);

  obj1.newProperty = "newProperty!";
obj1.__proto__.anotherProperty = "anotherProperty!";
console.log(obj1.anotherProperty); // anotherProperty!
console.log(obj1.newProperty); // newProperty!
// What about obj2?
console.log(obj2.newProperty); // undefined
console.log(obj2.anotherProperty); // anotherProperty! <= THIS IS THE COOL PART!

function Cat(catName) {
    var name = catName;
    this.getName = function() {
      return name;
    };
  }
  //adding a method to the cat prototype
  Cat.prototype.sayHi = function() {
    console.log('meow');
  };
  //adding properties to the cat prototype
  Cat.prototype.numLegs = 4;
  var muffin = new Cat('muffin');
  var biscuit = new Cat('biscuit');
  console.log(muffin, biscuit);
  //we access prototype properties the same way as we would access 'own' properties
  muffin.sayHi();
  biscuit.sayHi();
  console.log(muffin.numLegs);
  console.log(biscuit.numLegs);
  // we may change an instance's attributes rather than keeping the value set by prototype
  muffin.numLegs = 3;
  biscuit.numLegs = 5;
  console.log(biscuit.numLegs);
  // poor mutant cats: muffin.__proto__.numLegs ++;
  // doing this to muffin will cause all the cats to have 5 legs, but muffin will still have 3 legs  */


// OOP ES5
  // Define the object constructor
/*function Person(name, age) {
    this.name = name;
    this.age = age;
}
// Attach class methods using .prototype
Person.prototype.greet = function() {
    console.log("Hello my name is " + this.name + " and I am " + this.age + " years old!");
    return this;
};
// Create new instances with the new keyword
var amelia = new Person('Amelia', 36);
// Create instance methods by attaching the function directly to an instance
amelia.sing = function() {
    console.log("Lalalala!");
};
console.log(amelia.sing); */

// Private variables are scoped to the constructor with the 'var' keyword
function Car(make, model) {
    var odometer = 0;
    this.make = make;
    this.model = model;
    
    // To make functions private, we scope them to the constructor
    function updateOdometer(distance) {
        odometer += distance;
    };
    
    // 'Getter' functions help us read private variables
    this.readOdometer = function() {
      return odometer;
    }
    
    // 'Setter' functions help us update private variables
    this.drive = function(distance) {
      updateOdometer(distance);
      // return this will allow us to chain methods
      return this;
    }
}
var myCarInstance = new Car("Chevy", "Camaro");
// by returning this, we can chain drive()
myCarInstance.drive(50).drive(90); 
// private variable is undefined
console.log(myCarInstance.odometer);
// but we can read it with our getter function
console.log(myCarInstance.readOdometer());