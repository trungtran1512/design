$("logo-item").hover(
  function () {
    $(this).addClass('hover');
  }, 
  function () {
    $(this).removeClass('hover');
  }
  );


window.onscroll = function() {scrollFunction()};
function scrollFunction() {
  if (document.body.scrollTop > 50 || document.documentElement.scrollTop > 50) {
    document.getElementById("navbar").style.padding = "9px 16px";
    document.getElementById("navbar").style.backgroundColor = "#000000";
  } else {
    document.getElementById("navbar").style.padding = "8px 16px";
    document.getElementById("navbar").style.backgroundColor = "unset";
  }
}


// var $grid = $('.grid').masonry({
//   itemSelector: '.grid-item',
//   percentPosition: true,
//   columnWidth: '.grid-sizer'
// });
// // layout Masonry after each image loads
// $grid.imagesLoaded().progress( function() {
//   $grid.masonry();
// });  

