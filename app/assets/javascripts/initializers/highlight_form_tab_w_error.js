//= require 'jquery/dist/jquery'

var highlightFormTabWithError = function() {
  var id = $('.tab-pane .has-error')
    .closest('.tab-pane')
    .attr('id');
  $('.nav a[href="#' + id + '"]').tab('show');
};

var ready = function() {
  highlightFormTabWithError();
};

$(document).ready(ready);
