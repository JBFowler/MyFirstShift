document.addEventListener("turbolinks:load", function() {
  var meetManagersBtn = $("#meet-managers-btn");
  var backToVideosBtn = $("#back-to-videos-btn");
  var toUserInfoBtn = $("#to-user-info-btn");
  var introManagersDiv = $("#intro-managers-div");
  var introVideosDiv = $("#intro-videos-div");

  meetManagersBtn.on('click', function(e) {
    e.preventDefault();
    $(this).hide();
    toUserInfoBtn.show();
    backToVideosBtn.show();
    introVideosDiv.slideUp();
    introManagersDiv.slideDown();
  });

  backToVideosBtn.on('click', function(e) {
    e.preventDefault();
    $(this).hide();
    toUserInfoBtn.hide();
    meetManagersBtn.show();
    introVideosDiv.slideDown();
    introManagersDiv.slideUp();
  });
});
