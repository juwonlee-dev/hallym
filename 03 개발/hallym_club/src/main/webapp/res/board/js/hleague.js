/*심판 관리(출석)*/

$(function () {
  var menuBtn = document.querySelectorAll(".tabBtn a");
  var tabContent = document.querySelectorAll(".content.hleagueTab");

  for (var i = 0; i < menuBtn.length; i++) {
    menuBtn[i].addEventListener("click", function (event) {
      event.preventDefault();
      var orgTarget = event.target.getAttribute("href");
      var tabTarget = orgTarget.replace("#", "");
      for (var j = 0; j < tabContent.length; j++) {
        tabContent[j].style.display = "none";
      }
      for (var k = 0; k < menuBtn.length; k++) {
        menuBtn[k].classList.remove("active");
        this.classList.add("active");
      }
      document.getElementById(tabTarget).style.display = "block";
    });
  }
});
document.querySelector("#jwxe_main_content_attendanceManage").style.display =
  "block";

$(function () {
  $("#checkAll").click(function () {
    if ($("#checkAll").prop("checked")) {
      $("input[type=checkbox]").prop("checked", true);
    } else {
      $("input[type=checkbox]").prop("checked", false);
    }
  });
});

