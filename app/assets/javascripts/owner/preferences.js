document.addEventListener("turbolinks:load", function() {
  var itemDescriptionsDiv = $('#item-descriptions-div');
  var additionalItemDescription = $('#additional-item-description');
  var addItemDescriptionLink = $('#add-item-description-link');


  addItemDescriptionLink.on('click', function(e) {
    e.preventDefault();
    itemDescriptionsDiv.append(additionalItemDescription.data('f-field'));
  });
});
