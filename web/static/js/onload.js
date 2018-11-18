$(document).ready(function() {
  $.cloudinary.responsive();

  const home = (window.location.pathname === "/");

  $('.hotspot').hover(function() {
    $( this ).parents('.col-md-6').find('.overlay').stop().fadeToggle('fast', function() {
      if ($(this).is(':visible'))
        $(this).css('display','flex');
    });
  });

  const runAnimation = (mix_env != 'dev');

  TweenLite.set("header", {visibility:"visible"});
  TweenLite.set("main",   {visibility:"visible"});
  TweenLite.set("footer", {visibility:"visible"});

  if (runAnimation) {
    const tl = new TimelineLite({onComplete:startLogoAnimation});
    const t2 = new TimelineMax({repeat:-1, repeatDelay:0.2, yoyo: true, paused: true});

    function startLogoAnimation() {
      t2.staggerTo(".cls-1", 0.1, { cycle: { alpha: [0,1] }, scale:1, ease: Back.easeOut}, 0.1)
      t2.staggerTo(".cls-2", 0.1, { cycle: { alpha: [0,1] }, scale:1, ease: Back.easeOut}, 0.1)
      t2.staggerTo(".cls-11", 0.1, { cycle: { alpha: [0,1] }, scale:1, ease: Back.easeOut}, 0.1)
        .play();
    }

    if (home) {
      tl.to('.home .cenatus', 1, { opacity:1 })
        .from(".home .header ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .from(".home .logo ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.2)
        .staggerFrom(".cls-3", 0.01, {autoAlpha:0, scale:1, ease: Back.easeOut}, 0.03)
        .staggerFrom(".cls-2", 0.01, {autoAlpha:0, scale:1, ease: Back.easeOut }, 0.01)
        .staggerFrom(".cls-1", 0.01, {autoAlpha:0, scale:1, ease: Back.easeOut }, 0.02)
        .staggerFrom(".cls-4", 0.01, {autoAlpha:0, scale:1, ease: Back.easeOut }, 0.03)
        .staggerFrom(".home .category ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .from('.articles', 0.1, { opacity:0 })
        .staggerFrom(".articles .preview", 0.2, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .from(".home .meta ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .staggerFrom(".home .meta aside", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.2)
        .from('.home footer', 1, { opacity:0 })


    } else {
      tl.from('.articles', 0.2, { opacity:0 })
        .from("header ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .staggerFrom(".articles .preview", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .from(".meta ", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.1)
        .staggerFrom(".meta aside", 0.3, { scale:0.8, opacity:0, delay:0.1, ease:Expo.easeOut, force3D:true}, 0.2)
        .from('footer', 1, { opacity:0 })
    }
  }

  const tweets = $('.tweet .text');

  $.each(tweets, function( index, tweet ) {
    $(tweet).html(twitter.autoLink(twitter.htmlEscape($(tweet).text())));
  });
});
