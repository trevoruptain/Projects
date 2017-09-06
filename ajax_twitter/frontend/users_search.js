const APIUtil = require('./api_util.js');
const FollowToggle = require('./follow-toggle.js');

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
