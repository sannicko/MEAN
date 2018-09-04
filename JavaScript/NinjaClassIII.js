class Ninja{
  constructor(name){
    this.name = name;
    this.health = 100;
    this.speed = 3;
    this.strength =3;
  }
  sayName(){
    console.log("The ninja's name is: "+this.name);
    return this;
  }
  showStats(){
    console.log("Name: "+this.name+" Health:"+this.health+ " Speed: "+this.speed+" Strength: "+this.strength);
    return this;
  }
  drinkSake(){
    this.health += 10;
    return this;
  }
}

class Sensei extends Ninja{
constructor(name) {
  super(name);
  this.speed = 10;
  this.health = 200;
  this.strength = 10;
  this.wisdom = 10;
  }
  speakWisdom(){
    super.drinkSake();
    console.log("What one programmer can do in one month, two programers can do in two months.")
    return this;
  }
  showStats() {
    console.log(`Name: ${this.name}, Health: ${this.health}, Speed: ${this.speed}, Strength: ${this.strength}, Wisdom: ${this.wisdom}`);
  }
}

const superSensei = new Sensei("Master Splinter");
superSensei.speakWisdom();
superSensei.showStats();