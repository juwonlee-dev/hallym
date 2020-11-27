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
<!--css -->

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
<link type="text/css" rel="stylesheet" charset="UTF-8"
	href="https://translate.googleapis.com/translate_static/css/translateelement.css">


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
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/datepicker/datepicker.js"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20200506_00/e/js/element/element_main.js"></script>
        
 


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
						<li>동아리 신규 등록</li>
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
					<li class="active"><a href="/createClubAction.do" class="active">동아리
							신규 등록</a></li>
				</ul>
			</div>
		</div>
		<!-- 본문 -->
		<div class="content-wrap">
			<div class="title">
				<div class="jwxe_mnu_template jw-relative page-title">
					<h3>개설</h3>
				</div>
			</div>
			<div class="tab"></div>
			<!-- 내용 -->
			<div class="content" id="jwxe_main_content">
	
				<div class="ko board write co-board type01">
					<div class="bn-write-common01 type01">
	
					<div class="main">
						<h2></h2>
						<form name="writeForm" method="post" 
								action="/createClubAction.do" 
								enctype="multipart/form-data"
								onsubmit="return check_form();">
							<fieldset>
								<legend class="hide"></legend>
								<input name="csrfToken" type="hidden" value="mkktrnrrxrznvsjcvvyu">									
								<input type="hidden" name="articleNo" value="">
								<input name="articleNo" type="hidden" value="">
								<input name="parentNo" type="hidden" value="0">
								<input name="htmlYn" type="hidden" value="Y">
								
							<div class="b-table-wrap">
									<!--동아리명-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box b-required">
											<label for="articleTitle">동아리명</label>
										</div>
										<div class="b-con-box">
											 
											<input class="jwvalid-must-title b-input type01" 
											type="text" id="club_nm" 
											name="club_nm" value="" required>
										</div>
									</div>
								</div>
								<!--구분-->
								<div class="b-table-box type01 b-notice-box">
									<div class="b-row-box">
										<div class="b-title-box b-required"> <!--  b-required -->
											구분
										</div>
										<div class="b-con-box">
											<div class="b-period-box">
												<p>
												<input name="club_gb_cd" 
														class="b-chk" 
														id="topDivisionYn"
														type="radio" 
														value="001001"
														required> 
												<label for="topDivisionYn" >중앙동아리</label>
												<input name="club_gb_cd" 
														class="b-chk"
														id="topDivisionYn2"
														type="radio"
														value="001002">  
												<label for="topDivisionYn2">학과 동아리</label>
												</p>
												
											</div>
										</div>
									</div>
								</div>
								<!--분야-->
								<div class="b-table-box type01 b-notice-box">
									<div class="b-row-box">
										<div class="b-title-box"> <!--  b-required -->
											분야
										</div>
										<div class="b-con-box">
											<div class="b-period-box">
												<p>
												<input name="club_at_cd" class="b-chk" id="topFieldYn" 
												type="radio" value="002001"> 
												<label for="topFieldYn">공연</label>
												
												<input name="club_at_cd" class="b-chk" id="topFieldYn2"
												type="radio" value="002002">  
												<label for="topFieldYn2">학술</label>
												
												<input name="club_at_cd" class="b-chk" id="topFieldYn3"
												type="radio" value="002003">  
												<label for="topFieldYn3">취미/예술</label>
												
												<input name="club_at_cd" class="b-chk" id="topFieldYn4"
												type="radio" value="002004">  
												<label for="topFieldYn4">종교</label>
												
												<input name="club_at_cd" class="b-chk" id="topFieldYn5"
												type="radio" value="002005">  
												<label for="topFieldYn5">체육</label>
												
												<input name="club_at_cd" class="b-chk" id="topFieldYn6"
												type="radio" value="002006">  
												<label for="topFieldYn6">봉사</label>
												
												<input name="club_at_cd" class="b-chk" id="topFieldYn7"
												type="radio" value="002007">  
												<label for="topFieldYn7">기타</label>
												</p>
												
											</div>
										</div>
									</div>
								</div>		
								<!--목적-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box b-required">
											<label for="purposText">목적</label>
										</div>
										<div class="b-con-box">
											<textarea name="club_aim" id="club_aim" class="textareaBox" required></textarea>	
										</div>
									</div>
								</div>	
						
								<!--활동-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box b-required">
											<label for="activityText">활동</label>
										</div>
										<div class="b-con-box">
											<textarea name="club_active" id="club_active" class="textareaBox" required></textarea>	
										</div>
									</div>
								</div>
								<!--동아리 정보 동아리방 회장학번-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box">
											<label for="clubInfo">동아리 정보</label>
										</div>
										<div class="b-con-box">
											<div class="b-con-box-left">
												<span>동아리 방</span>
												<input class="jwvalid-must-title b-input type01" 
														name="club_room" type="text" value="" style="width :62%;">
												
											
											</div>
											<div class="b-con-box-left">
												<span>개설년도</span>
												
												<input name="open_dt" title="시작 날짜" id="clubDate" 
													type="text" maxlength="10" readonly="readonly" value="" 
													data-valid-title="공지시작일" style="width:55%;">		
												<span class="dakepicker_img"><img id="date_img" src="images/calendar.png"></span>
                      						  </div>									
											<div class="b-con-box-left">
												<span>회장 학번</span>
												<input class="jwvalid-must-title b-input type01" type="text" name="user_id" id="user_id"
												value="${user_id}" readonly="readonly" style="width :62%; background-color: lightgray;">
											</div>
											
											
										</div>
									</div>
								</div>
								<!--프로필-->
								<div class="b-table-box type01">
									<div class="b-row-box">
										<div class="b-title-box">프로필</div>
										<div class="b-con-box02">
											<div class="b-file-box type01 new">
													<select id="attachCnt" class="attach-select b-select" style="display:none">
														<option value="1"></option>
													</select>
											</div>
											<div class="b-file-box type03 file-list new">
												<div>
													<div>
														<input type="text" id="file_view2" name="wr-file-name" 
															class="b-input new" placeholder="첨부파일을 등록하세요" readonly="">  <!--  name="wr-file-name" -->
														<input class="outTable thumb hide  " type="file" 
															id=file_nm2 name="file1" onchange="javascript:document.getElementById('file_view2').value = this.value;">
														<label for="file_nm2" class="b-file-btn">찾아보기</label>
													</div>
													
												</div>
											</div>
										</div>
									</div>
								</div>
								<!--홍보 포스터-->
								<div class="b-table-box type01">
									<div class="b-row-box">
										<div class="b-title-box">홍보 포스터</div>
										<div class="b-con-box02">
											<div class="b-file-box type01 new">
												
													<select id="attachCntNew" class="attach-select b-select" style="display:none">
														
														<option value="2"></option>
														
													</select>
												
											</div>
											
											
											<div class="b-file-box type03 file-list new">
												<div>
													<div>
														<input type="text" id="file_view3" name="wr-file-name" class="b-input new" placeholder="첨부파일을 등록하세요" readonly="">  <!--  name="wr-file-name" -->
														<input class="outTable thumb hide  " type="file" 
														id="file_nm3" name="file2" onchange="javascript:document.getElementById('file_view3').value = this.value;">
														<label for="file_nm3" class="b-file-btn">찾아보기</label>
													</div>
													
												</div>
											</div>
											
										</div>
									</div>
								</div>
								</div>
							</fieldset>  
							
							<div class="b-btn-wrap">
								<button type="submit" class="b-btn-type01 b-btn-c-blue submit">등록</button>
							</div>	  
	
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