function Ninja (name, health) {
  var speed = 3
  var strength = 100
  this.name = name
  this.health = health

  this.showStats = function () {
    console.log(' Name: ' + this.name + ' Health: ' + this.health + ' Speed ' + speed + ' Strength: ' + strength)
    return this
  }
}
Ninja.prototype.sayName = function () {
  console.log('My name is ' + this.name)
}

Ninja.prototype.drinkSake = function () {
  this.health += 10
  return this
}
const ninja1 = new Ninja('Hyabusa')
ninja1.sayName()
ninja1.showStats()
ninja1.drinkSake()

const ninja2 = new Ninja('Dex', 30)
ninja2.sayName()
ninja2.showStats()
ninja2.drinkSake()