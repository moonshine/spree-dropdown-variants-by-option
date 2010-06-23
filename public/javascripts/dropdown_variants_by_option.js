jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.submitWithAjax = function() {
  this.submit(function(e) {
    e.preventDefault();
    $.post(this.action, $(this).serialize(), null, "script");
    return false;
  })
  return this;
};


$(document).ready(function() {
  $("#cart_form").submitWithAjax();
  $('body').ajaxStart(function () {
    $("#busy_indicator").show();
  });
  $('body').ajaxStop(function () {
    $("#busy_indicator").hide();
  });
})
