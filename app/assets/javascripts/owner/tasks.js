document.addEventListener("turbolinks:load", function() {
  var updateTasksBtn = $('.update-tasks-btn');
  var eVerifiedValue;
  var stateVerifiedValue;

  updateTasksBtn.on('click', function() {
    var parentTableRow = $(this).closest('tr');
    var eVerifiedCheckbox = parentTableRow.find('.e-verified-checkbox');
    var stateVerifiedCheckbox = parentTableRow.find('.state-verified-checkbox');

    if (eVerifiedCheckbox.is(':checked')) {
      eVerifiedValue = true;
    } else {
      eVerifiedValue = false;
    }

    if (stateVerifiedCheckbox.is(':checked')) {
      stateVerifiedValue = true;
    } else {
      stateVerifiedValue = false;
    }

    $.ajax({
      type: "POST",
      url: $(this).data('user-id-url'),
      data: {
        _method: 'PATCH',
        user: {
          e_verified: eVerifiedValue,
          state_verified: stateVerifiedValue
        }
      },
      dataType: 'json',
      success: function(data) {
        $('#tasks-flash-messages').append("<div class='alert alert-success alert-dismissible fade show py-1 mb-3' role='alert'>" + data.message + "<i class='fa fa-times pull-right pt-1' data-dismiss='alert' aria-hidden='true'></i></div>");

        if (stateVerifiedValue == true && eVerifiedValue == true) {
          parentTableRow.fadeOut();
          parentTableRow.slideUp();
        }
      },
      error: function(data) {
        $('#tasks-flash-messages').append("<div class='alert alert-error alert-dismissible fade show py-1 mb-3' role='alert'>" + data.messages + "<i class='fa fa-times pull-right pt-1' data-dismiss='alert' aria-hidden='true'></i></div>");
      }
    });
  });
});
