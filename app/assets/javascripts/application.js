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
//= require jquery3
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require popper
//= require bootstrap-sprockets
//= require jquery.tablesorter.min
//= require all

jQuery(function() {
  return $('.datepicker').datepicker();
});

$(document).ready(function() {
  $("[id$=table-sortable]").tablesorter();
});

$("#release_start_date").datepicker({
  numberOfMonths: 1,
  onSelect: function(selected) {
    $("#release_end_date").datepicker("option","minDate", selected)
  }
});

$("#release_end_date").datepicker({
  numberOfMonths: 1,
  onSelect: function(selected) {
     $("#release_start_date").datepicker("option","maxDate", selected)
  }
});

$("#received_start_date").datepicker({
  numberOfMonths: 1,
  onSelect: function(selected) {
    $("#received_end_date").datepicker("option","minDate", selected)
  }
});

$("#received_end_date").datepicker({
  numberOfMonths: 1,
  onSelect: function(selected) {
     $("#received_start_date").datepicker("option","maxDate", selected)
  }
});
$("#release_start_date").datepicker({
  numberOfMonths: 1,
  onSelect: function(selected) {
    $("#release_end_date").datepicker("option","minDate", selected)
  }
});

$("#release_end_date").datepicker({ 
  numberOfMonths: 1,
  onSelect: function(selected) {
     $("#release_start_date").datepicker("option","maxDate", selected)
  }
});

$("#received_start_date").datepicker({
  numberOfMonths: 1,
  onSelect: function(selected) {
    $("#received_end_date").datepicker("option","minDate", selected)
  }
});

$("#received_end_date").datepicker({ 
  numberOfMonths: 1,
  onSelect: function(selected) {
     $("#received_start_date").datepicker("option","maxDate", selected)
  }
});