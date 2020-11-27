/*동아리 목록 리스트*/

$(function () {
  const hclublogo = document.getElementsByClassName("hclublist_logo1");
  const hclubtext = document.getElementsByClassName("hclublist_logo1_text");

  function showText(i) {
    if (hclublogo[i].classList.contains("oneElement")) {
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
});
$(function () {
  $(document).ready(function () {
    $(".newclubList_list-right-bottom").each(function () {
      var content = $(this).children(".bottom-content");
      var content_txt = content.text();
      var content_txt_short = content_txt.substring(0, 70) + "...";
      var btn_more = $('<a href="javascript:void(0)" class="more">더보기</a>');

      $(this).append(btn_more);

      if (content_txt.length >= 100) {
        content.html(content_txt_short);
      } else {
        btn_more.hide();
      }

      btn_more.click(toggle_content);

      function toggle_content() {
        if ($(this).hasClass("short")) {
          // 접기 상태
          $(this).html("더보기");
          content.html(content_txt_short);
          $(this).removeClass("short");
        } else {
          // 더보기 상태
          $(this).html("접기");
          content.html(content_txt);
          $(this).addClass("short");
        }
      }
    });
  });
});
/*동아리 커뮤니티 - 물품목록*/
$(function () {
  $("#checkArticle").click(function () {
    if ($("#checkArticle").prop("checked")) {
      $("input[type=checkbox]").prop("checked", true);
    } else {
      $("input[type=checkbox]").prop("checked", false);
    }
  });
});
/*동아리 커뮤니티 - 물품목록*/
$(function () {
  $("#checkArticle2").click(function () {
    if ($("#checkArticle2").prop("checked")) {
      $("input[type=checkbox]").prop("checked", true);
    } else {
      $("input[type=checkbox]").prop("checked", false);
    }
  });
});
$(function () {
  $("#checkArticle3").click(function () {
    if ($("#checkArticle2").prop("checked")) {
      $("input[type=checkbox]").prop("checked", true);
    } else {
      $("input[type=checkbox]").prop("checked", false);
    }
  });
});
/*동아리 커뮤니티 - 예산*/
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
document.querySelector("#jwxe_main_content_incomeList").style.display = "block";

$(function () {
  $("#moneyAdd2").click(function () {
    maxCount += 1;
    $("#contentTable2").append(
      "<tr><td><input type='checkbox'></td>" +
        "<td><input title='시작 날짜' class='clubda' id='cluber" +
        maxCount +
        "' type='text' maxlength='10' readonly='readonly' value='' data-valid-title='공지시작일'></td>" +
        "<td><input type='text'></td>" +
        "<td><input type='text'></td></tr>"
    );
    $(function () {
      $("input[id^='cluber']").each(function () {
        var _this = this.id;

        $("#" + _this).datepicker({
          dateFormat: "yy/mm/dd",
          buttonImage: "images/calendar.png",

          buttonImageOnly: true,

          changeYear: true,

          changeMonth: true,
          dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],

          monthNames: [
            "1월",
            "2월",
            "3월",
            "4월",
            "5월",
            "6월",
            "7월",
            "8월",
            "9월",
            "10월",
            "11월",
            "12월",
          ],

          monthNamesShort: [
            "1월",
            "2월",
            "3월",
            "4월",
            "5월",
            "6월",
            "7월",
            "8월",
            "9월",
            "10월",
            "11월",
            "12월",
          ],
        });
      });
    });
  });

  $("#moneyDel2").click(function () {
    $("#contentTable2 tbody input[type='checkbox']:checked")
      .parent()
      .parent()
      .remove();
  });
});

$(function () {
  $("#moneyAdd3").click(function () {
    maxCount += 1;
    $("#contentTable3").append(
      "<tr><td><input type='checkbox'></td>" +
        "<td><input title='시작 날짜' class='clubda' id='cluber" +
        maxCount +
        "' type='text' maxlength='10' readonly='readonly' value='' data-valid-title='공지시작일'></td>" +
        "<td><input type='text'></td>" +
        "<td><input type='text'></td></tr>"
    );
    $(function () {
      $("input[id^='cluber']").each(function () {
        var _this = this.id;

        $("#" + _this).datepicker({
          dateFormat: "yy/mm/dd",
          buttonImage: "images/calendar.png",

          buttonImageOnly: true,

          changeYear: true,

          changeMonth: true,
          dayNamesMin: ["일", "월", "화", "수", "목", "금", "토"],

          monthNames: [
            "1월",
            "2월",
            "3월",
            "4월",
            "5월",
            "6월",
            "7월",
            "8월",
            "9월",
            "10월",
            "11월",
            "12월",
          ],

          monthNamesShort: [
            "1월",
            "2월",
            "3월",
            "4월",
            "5월",
            "6월",
            "7월",
            "8월",
            "9월",
            "10월",
            "11월",
            "12월",
          ],
        });
      });
    });
  });

  $("#moneyDel3").click(function () {
    $("#contentTable2 tbody input[type='checkbox']:checked")
      .parent()
      .parent()
      .remove();
  });
});
