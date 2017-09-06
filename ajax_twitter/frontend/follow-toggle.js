const APIUtil = require('./api_util.js');

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
