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
    document.getElementById("navbar").style.backgroundColor = "#000000";
  } else {
    document.getElementById("navbar").style.backgroundColor = "unset";
  }
}
