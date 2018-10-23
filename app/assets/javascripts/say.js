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
  if (document.body.scrollTop > 80 || document.documentElement.scrollTop > 80) {
    document.getElementById("navbar").style.padding = "10px 10px";
    document.getElementById("navbar").style.backgroundColor = "#000000";
  } else {
    document.getElementById("navbar").style.padding = "0";
    document.getElementById("navbar").style.backgroundColor = "unset";
  }
}