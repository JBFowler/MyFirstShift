document.addEventListener("turbolinks:load", function() {
  var updateWagesBtn = $('#update-wages-btn');
  var wageField = $('#add-wage-field');

  updateWagesBtn.on('click', function() {
    debugger;

    $.ajax({
      type: "POST",
      url: $(this).data('wage-url'),
      data: {
        _method: 'PATCH',
        organization: {
          wage: wageField.val()
        }
      },
      dataType: 'json',
      success: function(data) {
        // $('#tasks-flash-messages').append("<div class='alert alert-success alert-dismissible fade show py-1 mb-3' role='alert'>" + data.message + "<i class='fa fa-times pull-right pt-1' data-dismiss='alert' aria-hidden='true'></i></div>");

        // if (stateVerifiedValue == true && eVerifiedValue == true) {
        //   parentTableRow.fadeOut();
        //   parentTableRow.slideUp();
        // }
      },
      error: function(data) {
        // $('#tasks-flash-messages').append("<div class='alert alert-error alert-dismissible fade show py-1 mb-3' role='alert'>" + data.messages + "<i class='fa fa-times pull-right pt-1' data-dismiss='alert' aria-hidden='true'></i></div>");
      }
    });
  });
});
