module.exports = function (){
  return {
    add: function(num1, num2) { 
         // add code here
         return num1 + num2; 
    },
    multiply: function(num1, num2) {
         // add code here 
         return num1 * num2;
    },
    square: function(num2) {
         // add code here
         return num2 * num2; 
    },
    random: function(num1, num2) {
         // add code here
         return Math.floor(Math.random()*(num2-num1+2)+ num1);

    }
  }
};
