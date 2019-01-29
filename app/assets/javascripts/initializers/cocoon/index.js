//= require 'jquery/dist/jquery'
//= require 'cocoon'

var focusOnFirstInputAfterInsert = function() {
  $('.simple_form').on('cocoon:after-insert', (e, $insertedItem) => {
    $insertedItem.find('input')[0].focus();
  });
};

var ready = function() {
  focusOnFirstInputAfterInsert();
};

$(document).ready(ready);
