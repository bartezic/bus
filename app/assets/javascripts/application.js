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

  $('.flexslider').flexslider({
    controlsContainer: ".flex-container",
    animation: "fade",              //String: Select your animation type, "fade" or "slide"
    slideDirection: "horizontal",   //String: Select the sliding direction, "horizontal" or "vertical"
    slideshow: true,                //Boolean: Animate slider automatically
    slideshowSpeed: 7000,           //Integer: Set the speed of the slideshow cycling, in milliseconds
    animationDuration: 600,         //Integer: Set the speed of animations, in milliseconds
    directionNav: true,             //Boolean: Create navigation for previous/next navigation? (true/false)
    controlNav: true,               //Boolean: Create navigation for paging control of each clide? Note: Leave true for manualControls usage
    keyboardNav: true,              //Boolean: Allow slider navigating via keyboard left/right keys
    mousewheel: false,              //Boolean: Allow slider navigating via mousewheel
    randomize: true,               //Boolean: Randomize slide order
    slideToStart: 0,                //Integer: The slide that the slider should start on. Array notation (0 = first slide)
    animationLoop: true,            //Boolean: Should the animation loop? If false, directionNav will received "disable" classes at either end
    pauseOnAction: true,            //Boolean: Pause the slideshow when interacting with control elements, highly recommended.
    pauseOnHover: true          
  });

  var dates = $( "#date_from, #date_to" ).datepicker({
    minDate: new Date(),
    numberOfMonths: 2,
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
    $("#date_to").val('');
    $("#date_from, #date_to").datepicker('option', {maxDate: null});
    $("label[for=date_to]").toggle();
    var src = ($("#placeholder_img").attr("src") === "http://placehold.it/760x290") ? "http://placehold.it/760x265" : "http://placehold.it/760x290";
    $("#placeholder_img").attr("src",src);
  });

  $('.block2').tooltip({
    selector: "input[rel=tooltip]"
  });

  $("#city_from, #city_to").chosen({no_results_text: "Нічого не знайдено", required: true});

  $('#search_form').validate({
    rules: {
      city_from: "required",
      city_to: "required",
      date_from: "required",
      date_to: "required"
    }
  });

  request = function() {
    $('#emptyPopup').modal('show');

    var dates = $( "#date_from2, #date_to2" ).datepicker({
      minDate: new Date(),
      numberOfMonths: 2,
      onSelect: function( selectedDate ) {
        var option = this.id == "date_from2" ? "minDate" : "maxDate",
        instance = $( this ).data( "datepicker" ),
        date = $.datepicker.parseDate(
          instance.settings.dateFormat ||
          $.datepicker._defaults.dateFormat,
          selectedDate, instance.settings );
        dates.not( this ).datepicker( "option", option, date );
      }
    });

    $("input[name=one_way]").change(function(){
      $(".date_to2").toggle();
      $("#date_to2").val('');
      $("#date_from2, #date_to2").datepicker('option', {maxDate: null});
    });
  }

  reservation = function( price_adult, price_child, 
                    trip_number_from, time_stop_from, place_stop_from, departure_from_id, 
                    trip_number_to, time_stop_to, place_stop_to, departure_to_id) {
    
    $("#price_for_adult").html(price_adult);
    $("#price_for_child").html(price_child);
    price_sum();

    $("#trip_number_from").html(trip_number_from);
    $("#departure_from_id").val(departure_from_id);
    if (time_stop_from == ''){ $("#time_stop_from").html('-'); }
    else { $("#time_stop_from").html(time_stop_from); }
    if (place_stop_from == ''){ $("#place_stop_from").html('-'); }
    else { $("#place_stop_from").html(place_stop_from); }

    $("#trip_number_to").html(trip_number_to);
    $("#departure_to_id").val(departure_to_id);
    if (time_stop_to == ''){ $("#time_stop_to").html('-'); }
    else { $("#time_stop_to").html(time_stop_to); }
    if (place_stop_to == ''){ $("#place_stop_to").html('-'); }
    else { $("#place_stop_to").html(place_stop_to); }

    $('#adult').prop('readonly', true);
    $('#child').prop('readonly', true);
    $("#reservation_form").validate({
      rules: {
        email: {
          required: true,
          email: true
        },
        phone: {
          required: true,
          number: true,
          minlength: 9
        },
        name: {
          required: true,
          minlength: 4
        }
      }
    });
    $('#reservationPopup').modal('show');
  }

  for_delete_county = function(select_list, city_id, index){
    if (city_id != ''){
      el = $('option[value='+city_id+']')[index];
      el.parentNode.disabled = true;
    } else {
      el = $('optgroup').each(function(index){ this.disabled = false });
    }
  }

  plus_adult = function(){
    count = parseInt($('#adult').val())
    if ((count < 0)||(count >= 30)){ $('#adult').val(0) }
    else { $('#adult').val(count+1) }
    price_sum();
  }

  minus_adult = function(){
    count = parseInt($('#adult').val())
    if (count <=0){ $('#adult').val(0) }
    else { $('#adult').val(count-1) }
    price_sum();
  }

  plus_child = function(){
    count = parseInt($('#child').val())
    if ((count < 0)||(count >= 30)){ $('#child').val(0) }
    else { $('#child').val(count+1) }
    price_sum();
  }

  minus_child = function(){
    count = parseInt($('#child').val())
    if (count <=0){ $('#child').val(0)}
    else { $('#child').val(count-1) }
    price_sum();
  }

  price_sum = function(){
    $("#price_sum").html(
      parseInt($('#adult').val()) * parseInt($("#price_for_adult").html()) +
      parseInt($('#child').val()) * parseInt($('#price_for_child').html())
    )
  }
});

