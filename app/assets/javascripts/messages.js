var closeMessage = function() {
  $('.message .close')
    .on('click', function() {
      $(this)
        .closest('.message')
        .remove()
      ;
    })
  ;
}

$(document).ready(function() {
  closeMessage();
});

$(document).on('turbolinks:load', function() {
  closeMessage();
});
