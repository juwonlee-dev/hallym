const hclublogo = document.getElementsByClassName("hclublist_logo1");
const hclubtext = document.getElementsByClassName("hclublist_logo1_text");

function showText(i) {
  if(hclublogo[i].classList.contains("oneElement")) {
    hclubtext[i].style.right = "-10px";
  }
  hclubtext[i].classList.add("active");
}
function hideText(i) {
  hclubtext[i].classList.remove("active");
}

$(hclublogo).on("mouseenter", function () {
  showText($(hclublogo).index(this));
});
$(hclublogo).on("mouseleave", function () {
  hideText($(hclublogo).index(this));
});
