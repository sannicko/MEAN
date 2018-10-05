//1. Setting types
// variable should be a string instead of an integer
var myString: string;
myString = "Bee stinger";
myString = "9";

//2. Setting the types for function parameters
// added both types variables on the parameter string and number
function sayHello(name: string | number){
    return `Hello, ${name}!`;
}
console.log(sayHello("Kermit"));
console.log(sayHello(9));

//3. Optional parameters
// missing the question mark to make middleName optional parameter
function fullName(firstName: string, lastName: string, middleName?: string){
    let fullName = `${firstName} ${middleName} ${lastName}`;
    return fullName;
}
console.log(fullName("Mary", "Moore", "Tyler"));
console.log(fullName("Jimbo", "Jones"));

//4. Interfaces and function parameters
// missing s to the jay belts to keep consitency
interface Student{
    firstName: string;
    lastName: string;
    belts: number;
    
}
function graduate(ninja: Student) {
    return `Congratulations, ${ninja.firstName} ${ninja.lastName}, you earned ${ninja.belts} belts!`;
}
const christine = {
    firstName: "Christine",
    lastName: "Yang",
    belts: 2
}
const jay  = {
    firstName: "Christine",
    lastName: "Yang",
    belts: 4   // missing s
}
console.log(graduate(christine))
console.log(graduate(jay))

//5. Classes and function parameters

class Ninja {
    fullName: string;
    constructor (
        public firstName: string,
        public lastName: string) {
            this.fullName = `${firstName} ${lastName}`;
        }
    debug(){
        console.log("Console.log() is my friend.")
    }
}
// This is not making an instance of Ninja, for some reason:
const shane = new Ninja("Peter","Pan"); //in order to create the object need to add new and add the arguments
// Since I'm having trouble making an instance of Ninja, I decided to do this:
const turing = {
    fullName: "Alan Turing",
    firstName: "Alan",
    lastName: "Turing",
    debug(){
    }
}
// included debug function so that turing would be able to be passed through study().
function study(programmer: Ninja) :string {
    return `Ready to whiteboard an algorithm, ${programmer.fullName}?`
}
console.log(study(turing));

//6.Arrow functions

var increment = x => x + 1;
// This works great:
console.log(increment(3));
var square = x => x * x;
// no need the {}
console.log(square(4));
var multiply = ( x,y ) => x * y;
// need to add () 
var math = (x , y) => {
    let sum = x + y;
    let product = x * y;
    let difference = Math.abs(x-y);
    return [sum, product, difference];
}
// need to add {} when using multiple lines

//7. Arrow functions and 'this'
class Elephant {
    constructor(public age: number) {}
    birthday = age => {
        this.age ++;
    }
}
// need to add the function to elephant class for birthday to increment
const babar = new Elephant(8);
setTimeout(babar.birthday, 1000)
setTimeout(function(){
    console.log(`Babar's age is ${babar.age}.`)
}, 2000)