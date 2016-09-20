$(document).ready(function(){
  var wWidth = $(window).width();
  var wHeight = $(window).height();

  var fixHeight = wHeight;
  if(wWidth <= 1100){
    $('body').addClass('small-screen')
    $('.menu-block').width(wWidth);
  }

  if(wWidth<=640){
    var mobileMiddle = $('main .container')

    mobileMiddle.height(wHeight - 80);
    mobileMiddle.addClass('mobile-scroll')
  }

  $('.js-show-link').on('click touchstart', function(e){
    e.preventDefault();
    if($(this).hasClass('active')){
      $(this).removeClass('active');
      $('.js-fix-height').removeClass('active');
    } else {
      $(this).addClass('active')
      $('.js-fix-height').addClass('active');
    }
  });

  $('.js-fix-height, .js-show-link').height(fixHeight);
  $('#menu').height(fixHeight);

  $('[top-stories-slider]').each(function(){
    $(this).flexslider({
      animation: "fade",
      directionNav: false,
      slideshowSpeed: 3000
    });
  });

  $('.js-menu-link').on('click touchstart', function(e){
    e.preventDefault()
    e.stopPropagation();
    if($('#navigation').hasClass('active')){
      $('#navigation').removeClass('active');
      $('#menu').slideUp();
    } else {
      $('#navigation').addClass('active');
      $('#menu').slideDown();
    }
  });

  $('.with-child').on('click', function(e){
    var link = $(this)
    link.closest('li').find('.subsections').toggleClass('active');
    link.toggleClass('active');
  });

  $('.js-carousel').each(function(){
    var jcarousel = $('.js-carousel');

    jcarousel
      .on('jcarousel:reload jcarousel:create', function () {
        var width = jcarousel.innerWidth();

        if (width >= 600) {
          width = width / 3;
        } else if (width >= 350) {
          width = width / 2;
        }

        jcarousel.jcarousel('items').css('width', width + 'px');
      })
      .jcarousel({
        wrap: 'circular'
      });

    $('.jcarousel-control-prev')
      .jcarouselControl({
        target: '-=1'
      });

    $('.jcarousel-control-next')
      .jcarouselControl({
        target: '+=1'
      });

    $('.jcarousel-pagination')
      .on('jcarouselpagination:active', 'a', function() {
        $(this).addClass('active');
      })
      .on('jcarouselpagination:inactive', 'a', function() {
        $(this).removeClass('active');
      })
      .on('click touchstart', function(e) {
        e.preventDefault();
      })
      .jcarouselPagination({
        perPage: 1,
        item: function(page) {
          return '<a href="#' + page + '">' + page + '</a>';
        }
      });
  });
});

$(window).resize(function(){
  var wWidth = $(window).width();
  var wHeight = $(window).height();


  if(wWidth <= 1100){
    var fixHeight = wHeight - 80;

    $('body').addClass('small-screen');
    $('.menu-block').width(wWidth);
  } else {
    var fixHeight = wHeight - 165;

    $('body').removeClass('small-screen');
    $('.menu-block').width(300);
  }

  $('.js-fix-height, .js-show-link').height(fixHeight);
  $('#menu').height(fixHeight);

})