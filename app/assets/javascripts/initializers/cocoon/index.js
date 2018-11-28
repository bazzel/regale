//= require 'jquery/dist/jquery'
//= require 'cocoon'

var ready = function() {
  $('.simple_form').on('cocoon:after-insert', (e, $insertedItem) => {
    $insertedItem.find('input')[0].focus();
  })
}

$(document).ready(ready)

