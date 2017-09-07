const APIUtil = require('./api_util.js');

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
