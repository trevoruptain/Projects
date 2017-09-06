class View {
  constructor(game, $el) {
    this.setupBoard();
    this.game = game;
    this.el = $el;
    this.bindEvents();
  }

  bindEvents() {
    const moves = [];

    $('li').on("click", (e) => {
      const $square = $(e.currentTarget);
      const pos = $square.data("position");

      if (!moves.includes(pos)) {
        this.game.playMove(pos);
        this.makeMove($square);
        moves.push(pos);
        console.log(moves);
      } else {
        alert(`${pos} taken`);
      }
    });
  }

  makeMove($square) {
    $square.append(this.game.currentPlayer);
    $square.addClass("whitebg");

    if (this.game.currentPlayer === "o") {
      $square.css("color", "green");
    } else {
      $square.css("color", "red");
    }

    const winner = this.game.winner();

    if (winner) {
      alert(`${this.game.currentPlayer} wins!`);
    }
  }

  setupBoard() {
    const $el = $('.ttt');
    const ul = $('<ul>').addClass("ul");
    for (let i = 0; i < 9; i++) {
      let row;

      if ([0, 1, 2].includes(i)) {
        row = 0;
      } else if ([3, 4, 5].includes(i)) {
        row = 1;
      } else {
        row = 2;
      }

      const col = i % 3;
      const pos = [row, col];

      let li = $('<li>').addClass("li").on("mouseover", (e) => {
        const $square = $(e.currentTarget);
        $square.css("background-color", "turquoise");
        $square.css("transition", "background-color 2s");
      });
      li.on("mouseleave", (e) => {
        const $square = $(e.currentTarget);
        $square.css("background-color", "grey");
      });

      li.data("position", pos);

      ul.append(li);
    }
    $el.append(ul);
  }

}

module.exports = View;
