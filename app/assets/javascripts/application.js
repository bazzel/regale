// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
// require turbolinks
//= require_tree .

// See: https://github.com/patternfly/patternfly/blob/master/QUICKSTART.md#using-patternfly-in-your-application
//
//= require 'jquery/dist/jquery'
//= require 'bootstrap/dist/js/bootstrap'
//= require 'patternfly/dist/js/patternfly'

//= require 'moment/moment'
//= require 'bootstrap-datepicker/dist/js/bootstrap-datepicker'
//= require 'patternfly/node_modules/eonasdan-bootstrap-datetimepicker/src/js/bootstrap-datetimepicker'
//= require cocoon

var ready = function() {
  $('body').tooltip({
        selector: '[data-toggle="tooltip"]'
  });
  //$('[data-toggle="tooltip"]').tooltip();

  $().setupVerticalNavigation(true);
  $('.bootstrap-datetimepicker').datetimepicker({
    allowInputToggle: true,
    showTodayButton: true,
    toolbarPlacement: 'bottom',
    sideBySide: true,
    icons: {
      today: 'today-button-pf'
    }
  });
  $('.bootstrap-datepicker').datepicker({
    autoclose: true,
    todayBtn: "linked",
    todayHighlight: true
  });
}

//$(document).on('turbolinks:load', ready)
$(document).ready(ready)
