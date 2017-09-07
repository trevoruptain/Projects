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
