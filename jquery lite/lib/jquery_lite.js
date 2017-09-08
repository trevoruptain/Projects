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
/******/ 	return __webpack_require__(__webpack_require__.s = 0);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

const DOMNodeCollection = __webpack_require__(1);

window.$l = (arg) => {
  const functionQueue = [];

  if (typeof arg === "function") {
    if (document.readyState === 'complete') {
      arg();
    } else {
      functionQueue.push(arg);
    }
  } else if (arg instanceof HTMLElement) {
    return new DOMNodeCollection([arg]);
  } else {
    const objs = document.querySelectorAll(arg);
    const objArray = Array.from(objs);
    return new DOMNodeCollection(objArray);
  }

  document.addEventListener("DOMContentLoaded", function(e) {
    functionQueue.forEach(func => {
      func();
    });
  });
};


/***/ }),
/* 1 */
/***/ (function(module, exports) {

class DOMNodeCollection {
  constructor(array) {
    this.array = array;
    this.callbacks = {};
  }

  html(string=null) {
    if (string) {
      this.array.forEach(el => {
        el.innerHTML = string;
      });
    } else {
      return this.array[0].innerHTML;
    }
  }

  empty() {
    this.array.forEach(el => {
      el.innerHTML = "";
    });
  }

  append(arg) {
    this.array.forEach(el => {
      el.innerHTML += arg;
    });
  }

  attr(key, value=null) {
    if (value) {
      this.array.forEach(el => {
        el.setAttribute(key, value);
      });
    } else {
      this.array.forEach(el => {
        console.log(el.getAttribute(key));
        return el.getAttribute(key);
      });
    }
  }

  addClass(className) {
    this.array.forEach(el => {
      el.classList.add(className);
    });
  }

  removeClass(className) {
    this.array.forEach(el => {
      el.classList.remove(className);
    });
  }

  children() {
    const kids = [];

    this.array.forEach(el => {
      kids.push(el.children);
    });
    return new DOMNodeCollection(kids);
  }

  parent() {
    const adults = [];

    this.array.forEach(el => {
      adults.push(el.parentElement);
    });
    return new DOMNodeCollection(adults);
  }

  find(selector) {
    let found = [];

    this.array.forEach(el => {
      const list = el.querySelectorAll(selector);
      found = found.concat(list);
    });

    return new DOMNodeCollection(found);
  }

  remove() {
    this.array.forEach(el => {
      el.innerHTML = "";
    });

    this.array = [];
  }

  on(e, callback) {
    this.array.forEach(el => {
      this.callbacks.e = callback;
      el.addEventListener(e, callback);
    });
  }

  off(e) {
    this.array.forEach(el => {
      el.removeEventListener(e, this.callbacks.e);
    });
  }

  extend(...objs) {
    return Object.assign(objs);
  }
}

module.exports = DOMNodeCollection;


/***/ })
/******/ ]);