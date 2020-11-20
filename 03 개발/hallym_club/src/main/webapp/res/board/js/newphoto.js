const newBox = document.getElementsByClassName("newbox-hover");
const box01 = document.getElementsByClassName("b-box01");
const box02 = document.getElementsByClassName("b-box02");
const newBoxText = document.getElementsByClassName("newbox-text");
const newBoxFooter = document.getElementsByClassName("newbox-footer");

function showNotice(i) {
  newBox[i].classList.add("hover");
  box01[i].classList.add("active");
  box02[i].classList.add("active");
  newBoxText[i].classList.add("show");
  newBoxFooter[i].classList.add("show");
}
function hideNotice(i) {
  newBox[i].classList.remove("hover");
  box01[i].classList.remove("active");
  box02[i].classList.remove("active");
  newBoxText[i].classList.remove("show");
  newBoxFooter[i].classList.remove("show");
}

$(".newbox-hover").on("mouseenter", function () {
  showNotice($(".newbox-hover").index(this));
});

$(".newbox-hover").on("mouseleave", function () {
  hideNotice($(".newbox-hover").index(this));
});
