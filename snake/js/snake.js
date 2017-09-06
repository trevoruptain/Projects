
const Snake = function () {
  this.direction = "N";
  this.segments = [[10, 10]];
  this.directions = {
    "N": [0, -1],
    "E": [-1, 0],
    "S": [0, 1],
    "W": [1, 0]
  };
};

Snake.prototype.turn = function (newDir) {
  this.direction = newDir;
};

Snake.prototype.move = function () {
  const newSegments = [];

  let a, b = this.directions[this.direction];
  let x, y = this.segments[0];
  const newX = x + a;
  const newY = y + b;

  newSegments.push([newX, newY]);

  for (let i = 0; i < this.segments.length - 1; i++) {
    newSegments.push(this.segments[i]);
  }

  this.segments = newSegments;
};

Snake.prototype.plus = function() {
  const newSegments = [];

  let a, b = this.directions[this.direction];
  let x, y = this.segments[0];
  const newX = x + a;
  const newY = y + b;

  newSegments.push([newX, newY]);

  for (let i = 0; i < this.segments.length; i++) {
    newSegments.push(this.segments[i]);
  }

  this.segments = newSegments;
};

Snake.prototype.equals = function(pos) {
  const headPos = this.segments[0];

  if (headPos[0] === pos[0] && headPos[1] === pos[1]) {
    return true;
  }

  return false;
};

Snake.prototype.isOpposite = function(direction) {
  if (this.direction === "N" && direction === "S") {
    return true;
  } else if (this.direction === "E" && direction === "W") {
    return true;
  } else if (this.direction === "S" && direction === "N") {
    return true;
  } else if (this.direction === "W" && direction === "E") {
    return true;
  } else {
    return false;
  }
};

const Board = function () {
  this.grid = new Array(15);

  for (var i = 0; i < 15; i++) {
    this.grid[i] = new Array(15);
  }

  this.snake = new Snake();
};

Board.prototype.changeSnakeDirection = function(newDir) {
  this.snake.turn(newDir);
};


module.exports = Board;
