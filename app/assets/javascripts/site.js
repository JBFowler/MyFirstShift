document.addEventListener("turbolinks:load", function() {
  $('.nav-pills').on('click', 'button', function(event) {
    event.preventDefault();
    $('.nav-pills button.active').removeClass('active');
    $(this).addClass('active');
  });
});
