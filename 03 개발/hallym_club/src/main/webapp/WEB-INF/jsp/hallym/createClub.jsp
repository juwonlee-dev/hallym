<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="java.util.Arrays"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>우수동아리</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<!--link-->
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/common/cms.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/res/league/css/layout.css" />
<!--  -->

<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/common/css/toastr.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/res/board/css/board.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/res/board/css/type01.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/custom/css/board.common.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/res/league/css/user.css">

<!--script-->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
<script defer type="text/javascript"
	src="//translate.google.com/translate_a/element.js?cd=googleTranslateElementInit"></script>
<script type="text/javascript">
	//<![CDATA[
	var _thisHost = location.protocol + '//' + location.host, _thisUrl = document.location.href, _so_ = false, _cur_menu_cd = '4157', _edit_content = false, front_page_edit = true, zooInOutMode = 'font', _reouscePath = '/res/league/', editorVendor = 'froala', sslYN = 'N', sslPort = '8443', servicePort = '', developMode = false, device = 'pc', isMobile = false, _cfgUseDevMode = false, _siteId = 'league', printSelector = '#jwxe_main_content', ctx = '', rootPath = '', locale = 'ko', localeScriptPath = '${pageContext.request.contextPath}/custom/js/';
	//]]>
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/cms.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/js/control.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/res/league/js/user.js"></script>

<script type="text/javascript">
	function getPage(data1, data2, data3, data4) {
		var urlpaging = "/topClub.do?";
		var page = data1; /* 페이지 번호 */
		var opt = data2; /* gb_cd*/
		var opt2 = data3; /* at_cd*/
		var opt3 = data4; /* search */
		var link = urlpaging + "&page=" + page;

		if (opt != null) {
			link += "&gb_cd=" + opt;
		}
		if (opt2 != null) {
			link += "&at_cd=" + opt2;
		}
		if (opt3 != null) {
			link += "&search=" + opt3;
		}

		location.href = link;
	}

	$(document)
			.ready(
					function() {
						var sidemenu = document
								.querySelector(
										"#item_body > div > div.sub-container > div.lnb-wrap > div > ul")
								.getElementsByTagName('li');
						var activeNum = 0;
						for (var i = 0; i < sidemenu.length; i++) {
							if (sidemenu[i].className == "active") {
								activeNum = i;
								break;
							}
						}
						var msg = "";
						var msg2 = "";
						var code = 0;

						sidemenu[activeNum].classList.remove('active');
						sidemenu[activeNum].getElementsByTagName("a")[0].classList
								.remove("active");
						msg = "동아리 개설 신청"
						msg2 = "개설"

						document
								.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > div > div > h2").innerText = msg2;
						document
								.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(2)").innerText = msg2;
						document
								.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(3)").innerText = msg;
						document
								.querySelector("#item_body > div > div.sub-container > div.content-wrap > div.title > div > h3").innerText = msg;

					});
</script>
<!--style-->
<style type='text/css'></style>
<style>
/* .main {
	float: left;
	left: 0%;
	position: relative;
	width: 100%;
	height: 100%;
	margin-left: 20px;
} */ 

.manage-btn {
	background: #3b5998;
	width: 60px;
	height: 35px;
	color: white;
	border: none;
	border-radius: 5px;
	cursor: pointer;
	font-size: 13px;
	float: right;
}
/* 
table.type03 {
	border-collapse: collapse;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 5px solid #369;
	margin: 20px 3px;
	font-size: 140%;
}

table.type03 th {
	padding: 3px;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type03 td {
	padding: 3px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}  */
</style>


</head>

<body id="item_body" class="pc">

	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
	</ul>
	<div class="sub-wrap">
		<header>
		<div class="top-header-wrap"><jsp:include
				page="/WEB-INF/jsp/item/top-util.jsp" /></div>
		<div class="bottom-header-wrap"><jsp:include
				page="/WEB-INF/jsp/item/header.jsp" /></div>
		</header>
		<div class="sub-visual-wrap"></div>
		<div class="path-wrap">
			<div class="path-box">
				<div class="jwxe_navigator jw-relative">
					<ul>
						<li><a href="/index.do"><img
								src="images/common/ico-home.png" alt="home"></a></li>
						<li>개설</li>
						<li>동아리 개설 신청</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="sub-container">
		<!--메뉴바-->
		<div class="lnb-wrap">
			<div class="lnb">
				<div class="lnb-title-box">
					<div>
						<h2>개설</h2>
					</div>
				</div>
				<ul class="lnb-menu jwxe-menu-ul">
					<li class="active"><a href="/createClub.do" class="active">동아리
							개설 신청</a></li>
				</ul>
			</div>
		</div><!-- 본문 -->
	<div class="content-wrap">
		<div class="title">
			<div class="jwxe_mnu_template jw-relative page-title">
				<h3>개설</h3>
			</div>
		</div>
		<div class="tab"></div>
		<!-- 내용 -->
		<div class="content" id="jwxe_main_content">

			<div class="bn-list-common01 type01 bn-common bn-common">
				<div class="b-top-info-wrap"></div>

				<div class="main">
					<h2>신규 동아리 등록</h2>
					<form method="post" action="/createClub.do"
						enctype="multipart/form-data" onsubmit="return check_form();">
						<table class="type03">

							<tr>
								<th>동아리명    *</th>								
								<td style="color: #153d73; font-weight: bold;"><input
									type="text" id="club_nm" name="club_nm"
									style="font-size: 20px; margin-right: 30px;">
							</tr>

							<tr>
								<th>구분    *</th>
								<td><input type="radio" name="club_gb_cd" value="001001"
									checked="checked" /> 중앙동아리 <input type="radio"
									name="club_gb_cd" value="001002" /> 과동아리</td>
							</tr>

							<tr>
								<th>분야</th>
								<td><input type="radio" name="club_at_cd" value="002001"
									checked="checked" /> 공연 <input type="radio" name="club_at_cd"
									value="002002" /> 학술 <input type="radio" name="club_at_cd"
									value="002003" /> 취미예술 <input type="radio" name="club_at_cd"
									value="002004" /> 종교 <input type="radio" name="club_at_cd"
									value="002005" /> 체육 <input type="radio" name="club_at_cd"
									value="002006" /> 봉사 <input type="radio" name="club_at_cd"
									value="002007" /> 기타</td>
							</tr>

							<tr>
								<th>목적    *</th>
								<td colspan="2" height="60px"><textarea
										style="width: 99%; height: 99%; resize: none" name="club_aim"></textarea></td>
							</tr>

							<tr>
								<th>활동    *</th>
								<td colspan="2" height="60px"><textarea
										style="width: 99%; height: 99%; resize: none"
										name="club_active"></textarea></td>
							</tr>
							
							<tr>
							<th>동아리 정보</th>
							<td style="text-align:left">개설년도<input type="text" name="open_dt" style="font-size:20px; margin-left:20px;" size="6" maxlength="8"></td>
							<td style="text-align:left">동아리방<input type="text" name="club_room" style="font-size:20px; margin-left:20px;"></td>
							</tr>
							
							<!-- <tr>
								<th>동아리 정보</th>
								<td>
									<tr>
										<th>개설년도 *</th>
										<input type="text"	name="open_dt" style="font-size: 20px; margin-left: 20px;"
											size="6" maxlength="8">
									<tr>
										<th>동아리방</th>
										<input type="text" name="club_room" style="font-size: 20px; margin-left: 20px;">
									</tr>
								</td>
							</tr> -->

							<tr>
								<th>프로필</th>
								<td><input type="file" name="file1"></td>
							</tr>

							<tr>
								<th>홍보 포스터</th>
								<td><input type="file" name="file2"></td>
							</tr>

							<tr>
								<th>회장 학번    *</th>
								<td><input type="text" id="user_id" name="user_id"
									value="${user_id}" style="font-size:20px" readonly="readonly"></td>
						</table>
						<input type="submit" value="등록" class="manage-btn"
							style="margin-right: 45%;">

					</form>
				</div>


				<div class="b-paging01 type03">
					<div class="b-paging01 type01">
						<div class="b-paging-wrap"></div>
					</div>
				</div>
				<div class="b-btn-wrap"></div>
			</div>
		</div>
	</div>
	</div>


	


		<footer>
		<div class="top-footer-wrap"><jsp:include
				page="/WEB-INF/jsp/item/footer-top.jsp" /></div>
		<div class="bottom-footer-wrap"><jsp:include
				page="/WEB-INF/jsp/item/footer.jsp" /></div>
		</footer>
	<script>
		function check_form() {
			var ck_name = document.getElementById("club_nm").value;
			var ck_user_id = document.getElementById("user_id").value;
			var ck_club_aim = document.getElementById("club_aim").value;
			var ck_club_active = document.getElementById("club_active").value;
			var ck_open_dt = document.getElementById("open_dt").value;
			if (ck_name.trim() == "") {
				alert("동아리 이름을 입력해주세요");
				document.getElementById("club_nm").focus();
				return false;
			}

			if (ck_user_id.trim() == "") {
				alert("회장을 입력해주세요");
				document.getElementById("user_id").focus();
				return false;
			}
			
			if (ck_name.trim() == "") {
				alert("목적을 입력해주세요");
				document.getElementById("club_aim").focus();
				return false;
			}
			
			if (ck_name.trim() == "") {
				alert("활동을  입력해주세요");
				document.getElementById("club_active").focus();
				return false;
			}
			
			if (ck_name.trim() == "") {
				alert("개설년도를 입력해주세요");
				document.getElementById("open_dt").focus();
				return false;
			}
		}
	</script>
</body>
</html>