// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require_tree .

$(function () {
  var dates = $( "#date_from, #date_to" ).datepicker({
    defaultDate: "+1w",
    onSelect: function( selectedDate ) {
      var option = this.id == "date_from" ? "minDate" : "maxDate",
      instance = $( this ).data( "datepicker" ),
      date = $.datepicker.parseDate(
        instance.settings.dateFormat ||
        $.datepicker._defaults.dateFormat,
        selectedDate, instance.settings );
      dates.not( this ).datepicker( "option", option, date );
    }
  });
  $("input[name=one_way]").change(function(){
    $("#date_to").toggle();
    $("label[for=date_to]").hide()
  });
  $('.block2').tooltip({
    selector: "input[rel=tooltip]"
  });
  $(".well").validate()
  order = function(ticket_id, trip_number, time_stop, place_stop) {
    $("#trip_number").html(trip_number);

    if (time_stop == ''){ $("#time_stop").html('-'); }
    else { $("#time_stop").html(time_stop); }

    if (place_stop == ''){ $("#place_stop").html('-'); }
    else { $("#place_stop").html(place_stop); }

    $('#orderPopup').modal('show');
  }
});

