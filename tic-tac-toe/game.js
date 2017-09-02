const Board = require("./board");

class Game {
  constructor() {
    this.board = new Board();
    this.currentPlayer = 1;
  }

  gameOver() {
    return true;
  }

  play() {
    const gameWon = false;
    while (!gameWon) {}
  }
}
