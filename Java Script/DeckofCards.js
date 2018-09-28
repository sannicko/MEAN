class Cards{
  constructor(suit, sval, ival ){
    this.suit = suit;
    this.sval = sval;
    this.ival = ival;
  }
  show(){
    console.log(sval +" of "+suit + " " + ival );
  }
}

class Deck{
  constructor(){
    this.deck = [];
  }
  shuffle(){
    var card = this.deck.length, t, i;

  while (card) {

    i = Math.floor(Math.random() * card--);

    t = this.deck[card];
    this.deck[card] = this.deck[i];
    this.deck[i] = t;
  }
    return this;
  }

  reset(){
    this.deck=[];
    const suits = ['Clubs','Hearts','Diamonds','Spades'];
    const values = ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King'];
    for (const suit of suits) {
                    for (const value of values) {
                        this.deck.push(`${ value } of ${ suit }`);
                    }
                }
                return this;
  }

  deal(){
    return this.deck.pop();
  }

}

class Player{
  constructor(playerName){
    this.playerName = playerName;
    this.hand =[];
  }
  draw(deck){
    this.hand.push(deck.deal());
    return this;
  }
  discard(){
    this.hand.pop();
    return this;
  }
}

const deck1 = new Deck();
deck1.reset().shuffle();
console.log(deck1);

const player1 =  new Player("Peter");
player1.draw(deck1).draw(deck1).draw(deck1);
console.log(player1.hand);
console.log(deck1);

const deck2 = new Deck();
deck1.reset().shuffle();
console.log(deck1);

const player2 =  new Player("Pan");
player2.draw(deck2).draw(deck2).draw(deck2);
console.log(player2.hand);
console.log(deck2);