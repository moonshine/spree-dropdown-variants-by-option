jQuery.ajaxSetup({
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

jQuery.fn.extend( {
  submitWithAjax: function() {
    this.submit(function(e) {
      e.preventDefault();
      $.post(this.action, $(this).serialize(), null, "script");
      return false;
      })
      return this;
    },

    onChangeWithAjax: function() {
      this.change(function(e) {
        e.preventDefault();
        $.post('/products/option_value_changed', $("#cart_form").serialize(), null, "script");
        return false;
      })
      return this;
    }
});


var app =
{
  setupAjaxCallbacks: function () {
    $('body').ajaxStart(function (){
      $("#busy_indicator").show();
    });
    $('body').ajaxStop(function () {
      $("#busy_indicator").hide();
    });
  },

  addToCart: function() {
    $("#cart_form").submitWithAjax();
  },

  optionValueChanged: function() {
    $("select#option_values_select_primary").onChangeWithAjax();
    $("input#option_values_radio_primary").onChangeWithAjax();
  }
}

jQuery( function () {
  app.setupAjaxCallbacks();

  app.addToCart();

  app.optionValueChanged();
});
