document.addEventListener("turbolinks:load", function() {
  var firstDayAdditionalItemsBtn = $("#first-day-additional-items-btn");
  var firstDayBackToVideosBtn = $("#first-day-back-to-videos-btn");
  var finishBtn = $("#finish-btn");
  var onboadingFirstDayVideosDiv = $("#onboarding-first-day-videos-div");
  var onboadingFirstDayItemsDiv = $("#onboarding-first-day-items-div");

  firstDayAdditionalItemsBtn.on('click', function(e) {
    e.preventDefault();
    $(this).hide();
    finishBtn.show();
    firstDayBackToVideosBtn.show();
    onboadingFirstDayVideosDiv.slideUp();
    onboadingFirstDayItemsDiv.slideDown();
  });

  firstDayBackToVideosBtn.on('click', function(e) {
    e.preventDefault();
    $(this).hide();
    finishBtn.hide();
    firstDayAdditionalItemsBtn.show();
    onboadingFirstDayVideosDiv.slideDown();
    onboadingFirstDayItemsDiv.slideUp();
  });
});
