const FollowToggle = require('./follow-toggle.js');
const UsersSearch = require('./users_search.js');

$(() => {
  const $buttons = $('.follow-toggle');

  $buttons.each(function(index, button) {
    new FollowToggle($(button));
  });

  new UsersSearch($('.users-search'));
});
