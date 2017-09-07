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

const FollowToggle = __webpack_require__(1);
const UsersSearch = __webpack_require__(3);
const TweetCompose = __webpack_require__(4);

$(() => {
  const $buttons = $('.follow-toggle');

  $buttons.each(function(index, button) {
    new FollowToggle($(button));
  });

  new UsersSearch($('.users-search'));

  new TweetCompose($('.tweet-compose'));
});


/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class FollowToggle {
  constructor(el, options) {
    this.userId = el.data("user-id") || options.userId;
    this.followState = (el.data("initial-follow-state") ||
                        options.followState);
    this.el = $(el);
    this.render();
    this.handleClick();
    this.handleSuccess = this.handleSuccess.bind(this);
  }

  render() {
    if (this.followState === "following" || this.followState === "unfollowing") {
      this.el.prop("disabled", true);
    } else if (this.followState === "unfollowed") {
      this.el.text("Follow!").prop("disabled", false);
    } else {
      this.el.text("Unfollow!").prop("disabled", false);
    }
  }

  handleClick() {
    const that = this;

    this.el.on("click", function(evt) {
      evt.preventDefault();

      if (that.followState === "followed") {
        that.followState = "following";
        that.render();
        APIUtil.unfollowUser(that.userId)
        .then(that.handleSuccess);
      } else {
        that.followState = "unfollowing";
        that.render();
        APIUtil.followUser(that.userId)
        .then(that.handleSuccess);
      }

    });

  }

  handleSuccess() {
    this.toggleFollowState();
    this.render();
  }

  toggleFollowState() {
    if (this.followState === "followed" || this.followState === "following") {
      this.followState = "unfollowed";
    } else {
      this.followState = "followed";
    }
  }
}

module.exports = FollowToggle;


/***/ }),
/* 2 */
/***/ (function(module, exports) {

const APIUtil = {
  followUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'POST',
      dataType: "json",
    });
  },

  unfollowUser: id => {
    return $.ajax({
      url: `/users/${id}/follow`,
      method: 'DELETE',
      dataType: "json",
    });
  },

  searchUsers: (queryVal, success) => {
    return $.ajax({
      url: `/users/search?query=${queryVal}`,
      method: 'GET',
      dataType: "json",
      success(data) {
        success(data);
      }
    });
  },

  createTweet: (tweetData, success) => {
    return $.ajax({
      url: "/tweets",
      method: 'POST',
      dataType: "json",
      data: tweetData,
      success(data) {
        success(data);
      }
    });
  }
};

module.exports = APIUtil;


/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);
const FollowToggle = __webpack_require__(1);

class UsersSearch {
  constructor(el) {
    this.$el = $(el);
    this.$input = this.$el.find('input');
    this.$ul = $('.users');
    this.handleInput();
  }

  handleInput() {
    const that = this;

    this.$input.on("input", function() {
      APIUtil.searchUsers(that.$input.val(), that.renderResults.bind(that));
    });
  }

  renderResults($matchingUsers) {
    const that = this;
    this.$ul.empty();

    $matchingUsers.forEach(function(user) {
      const $a = $("<a>").attr("href", `/users/${user.id}`).append(user.username);
      const $button = $("<button>").addClass("follow-toggle");
      const followState = user.followed ? "followed" : "unfollowed";
      const $toggle = new FollowToggle($button, {userId: user.id, followState: followState});
      const $li = $("<li>").append($a).append($button);
      that.$ul.append($li);
      that.$ul.append($toggle);
    });
  }
}

module.exports = UsersSearch;


/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

const APIUtil = __webpack_require__(2);

class TweetCompose {
  constructor(el) {
    this.$el = $(el);
    this.handleSubmit();
  }

  handleSubmit() {
    const that = this;

    this.$el.on("submit", event => {
      event.preventDefault();
      const $data = that.$el.serializeJSON();
      $(":input").prop("disabled", true);

      APIUtil.createTweet($data, that.handleSuccess.bind(this));
    });
  }

  clearInput() {
    $(':input[type="text"]').attr("value", "");
  }

  handleSuccess(data) {
    this.clearInput();
    $(":input").prop("disabled", false);
    const selector = this.$el.data("tweets-ul");
    const $ul = $(selector);
    const $li = $("<li>");
    $li.append(`${data.content} -- `);
    $li.append(data.user.username);
    $li.append(` ${data.created_at} `);
    console.log(data);
    $li.append(data.mentions[0].user.username);
    $ul.prepend($li);
  }
}

module.exports = TweetCompose;


/***/ })
/******/ ]);
//# sourceMappingURL=bundle.js.map