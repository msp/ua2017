$(document).ready(function() {

  // $('.hotspot').hover(
  //   function(event) {
  //     console.log('enter');
  //     event.preventDefault();
  //     $( this ).parents('.col-md-6').find('.overlay').fadeIn();
  //   },
  //   function(event) {
  //     console.log('leave');
  //     event.preventDefault();
  //     $( this ).parents('.col-md-6').find('.overlay').fadeOut();
  //   }
  // );

  $('.hotspot').hover(function() {
    $( this ).parents('.col-md-6').find('.overlay').stop().fadeToggle('fast', function() {
      if ($(this).is(':visible'))
        $(this).css('display','flex');
    });
  });
});
