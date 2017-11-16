document.addEventListener("turbolinks:load", function() {
  var pendingInvitesNavBtn = $('#pending-invites-nav-btn');
  var acceptedInvitesNavBtn = $('#accepted-invites-nav-btn');
  var pendingInvitesList = $('#pending-invites-list');
  var acceptedInvitesList = $('#accepted-invites-list')

  pendingInvitesNavBtn.on('click', function() {
    acceptedInvitesList.hide();
    pendingInvitesList.show();
  });

  acceptedInvitesNavBtn.on('click', function() {
    pendingInvitesList.hide();
    acceptedInvitesList.show();
  });
});
