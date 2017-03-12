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

  var tl = new TimelineLite();

  tl.to('.home .container', 1, { opacity:1 })
    .from(".home .header ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
    .from(".home .logo ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.2)
    .staggerFrom(".home .category ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
    .from('.home .articles', 1, { opacity:0 })
    .staggerFrom(".home .articles .preview", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
    .from(".home .meta ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
    .staggerFrom(".home .meta aside", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.2)
    .from('.home footer', 1, { opacity:0 })

});
