const Board = require('./snake.js');

class View {
  constructor(el) {
    this.board = new Board;
    this.setupBoard();
    this.bindListener(el);
    setInterval(this.step(), 500);
    this.el = el;
  }

  bindListener(el) {
    el.on("keydown", (e) => {
      if (this.handleKeyEvent(e)) {
        this.board.changeSnakeDirection(this.handleKeyEvent(e));
      }
    });
  }

  handleKeyEvent(event) {
    if (event.keyCode === 37) {
      return "W";
    } else if (event.keyCode === 38) {
      return "N";
    } else if (event.keyCode === 39) {
      return "E";
    } else if (event.keyCode === 40) {
      return "S";
    } else {
      return null;
    }
  }

  setupBoard() {
    const $el = $('.game');
    let ul = $('<ul>');

    for (let i = 0; i < 15; i++) {
      for (let j = 0; j < 15; j++) {
        let li = $('<li>');
        // li.data("pos", [i, j]);
        ul.append(li);
      }
    }

    debugger;
    $el.append(ul);
  }

  step() {
    this.board.snake.move();
    // this.renderBoard();
  }
}

// View.prototype.renderBoard = function () {
//
// };

module.exports = View;
