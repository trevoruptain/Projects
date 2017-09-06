/******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 1);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */,
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const View = __webpack_require__(2);

const $el = $('.game');

const view = new View($el);


/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

const Board = __webpack_require__(3);

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


/***/ }),
/* 3 */
/***/ (function(module, exports) {


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


/***/ })
/******/ ]);