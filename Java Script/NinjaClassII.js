function Ninja (name, health) {
  var speed = 3
  var strength = 100
  this.name = name
  this.health = 100

  this.showStats = function () {
    console.log(' Name: ' + this.name + ' Health: ' + this.health + ' Speed ' + speed + ' Strength: ' + strength)
    return this
  }
}
Ninja.prototype.sayName = function () {
  console.log('My name is ' + this.name)
  return this
}

Ninja.prototype.drinkSake = function () {
  this.health += 10
  return this
}

Ninja.prototype.punch = function () {
  this.health -= 5
  console.log(', was punched by' + redNinja + ' and lost 5 points health!')
  return this
}

Ninja.prototype.kick = function (){
  const damage = 15* blueNinja.strength;
  console.log(redNinja + ' was kicked by' + blueNinja + 'and lost' + damage + ' health')

  var blueNinja = new Ninja( 'Goemon');
  var redNinja = new Ninja( 'Bill Gates');
  redNinja.punch(blueNinja);
  redNinja.kick(blueNinja);