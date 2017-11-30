document.addEventListener("turbolinks:load", function() {
  var finishBtn = $("#finish-btn");
  var firstDayDiv = $("#first-day");
  var firstDayTab = $('#first-day-tab');
  var completeTab = $('#complete-tab');
  var readyToStartDiv = $("#ready-to-start-div");

  finishBtn.on('click', function(e) {
    e.preventDefault();
    firstDayTab.removeClass('active');
    firstDayTab.append(" <i class='fa fa-check-circle'></i>");
    completeTab.addClass('active');
    completeTab.click(false);
    firstDayDiv.slideUp(function() {
      readyToStartDiv.fadeIn();
    });
  });
});
