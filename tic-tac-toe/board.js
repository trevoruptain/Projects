class Board {
  constructor() {
    this.grid = [[[], [], []], [[], [], []], [[], [], []]];
  }

  renderGrid() {
    this.grid.forEach(row => {
      console.log(row);
    });
  }
}

module.exports = Board;
