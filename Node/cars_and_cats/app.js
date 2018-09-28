var mathlib = require('./mathlib')();
const num1 = 10;
const num2 = 20;

console.log("Adding two numbers the answer is:", mathlib.add(num1,num2));
console.log("Multiply two numbers the answer is:", mathlib.multiply(num1,num2));
console.log("Square a number the answer is:", mathlib.square(num2));
console.log("Return a random number between two numbers" + num1 + "and" + num2 + "is:", mathlib.random(num1, num2));

