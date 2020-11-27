
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  
<%@page import="hallym.club.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 가입 양식</title>
	<link type="text/css" rel="stylesheet" charset="UTF-8"
		href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
	
	<!--script-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
	<script defer type="text/javascript" src="//translate.google.com/translate_a/element.js?cd=googleTranslateElementInit"></script>
	<script type="text/javascript">
	   //<![CDATA[
	       var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
	       ,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/res/league/'
	       ,editorVendor = 'froala',sslYN = 'N',sslPort = '8443', servicePort = '',developMode = false,device='pc',isMobile=false
	       ,_cfgUseDevMode = false, _siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = ''
	       ,locale= 'ko', localeScriptPath='${pageContext.request.contextPath}/custom/js/';
	   //]]>
	</script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
	
<style>

/* .bottom {
	position: absolute;
	width: 60%;
	top: 72%;
	left: 20%;
	text-align: center;
} */

</style>
</head>
<%
	request.setCharacterEncoding("UTF-8");
	String userId = null;
	if (session.getAttribute("userVO") != null) {
		UserVO  userVO = ((UserVO) session.getAttribute("userVO"));
		userId = userVO.getId();
	}
%>
<body>
	<div class="sub-wrap">
		<header> </header>
		<div class="sub-visual-wrap"></div>
		<div class="path-wrap">
			<div class="path-box">
				<div class="jwxe_navigator jw-relative">
					<ul>

					</ul>
				</div>
			</div>
		</div>
		<div class="sub-container">
			<!--메뉴바-->
			<div class="lnb-wrap">
				<div class="lnb">
					<div class="lnb-title-box">
						<div>
							<h2>구분</h2>
						</div>
					</div>
					<ul class="lnb-menu jwxe-menu-ul">

					</ul>
				</div>
			</div>
			<!--메뉴바-->
			<!--공지사항 본문-->
			<div class="content-wrap">
				<div class="title">
					<div class="jwxe_mnu_template jw-relative page-title">
						<h3>${club_nm} 가입신청</h3>
					</div>
				</div>

				<div class="tab"></div>
				<!--공지사항-->
				<div class="content" id="jwxe_main_content">
					<script type="text/javascript">
						//<![CDATA[
						var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false' ? false
								: true, clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
						//]]>
					</script>
					<div class="ko board list co-board type01">
						<div class="bn-write-common01 type01">
							<div class="main">
								<form method="post" action="clubSignUpAction.do"
									onsubmit="return check_form();">
									<fieldset>
										<legend class="hide"></legend>
										<input name="csrfToken" type="hidden"
											value="mkktrnrrxrznvsjcvvyu"> 
											<input type="hidden"
											name="articleNo" value=""> 
											<input name="articleNo"
											type="hidden" value=""> 
											<input name="parentNo"
											type="hidden" value="0"> 
											<input name="htmlYn"
											type="hidden" value="Y"> 
											<input type="hidden"
											name="club_id" value="${club_id}">
										<h2></h2>

										<div class="b-table-wrap">
											<div class="b-table-box type01 b-subject-box">
												<div class="b-row-box">
													<div class="b-title-box b-required">
														<label for="articleTitle">학과</label>
													</div>
													<div class="b-con-box">

														<input class="jwvalid-must-title b-input type01"
															type="text" id="major" name="major"
															value="${userVO.major}" required readOnly>
													</div>
												</div>
											</div>
										</div>
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">학번</label>
												</div>
												<div class="b-con-box">

													<input class="jwvalid-must-title b-input type01"
														type="text" id="user_id" name="user_id"
														value="${userVO.id}" required readOnly>
												</div>
											</div>
										</div>

										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">학년</label>
												</div>
												<div class="b-con-box">

													<input class="jwvalid-must-title b-input type01"
														type="text" id="grade" name="grade"
														value="${userVO.grade}" required readOnly>
												</div>
											</div>
										</div>


										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">성명</label>
												</div>
												<div class="b-con-box">

													<input class="jwvalid-must-title b-input type01"
														type="text" id="name" name="name" value="${userVO.name}"
														required readOnly>
												</div>
											</div>
										</div>



										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">전화번호</label>
												</div>
												<div class="b-con-box">

													<input class="jwvalid-must-title b-input type01"
														type="text" id="phone_no" name="phone_no"
														value="${userVO.phoneNumber}" required>
												</div>
											</div>
										</div>


										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">이메일</label>
												</div>
												<div class="b-con-box">

													<input class="jwvalid-must-title b-input type01"
														type="text" id="email" name="email"
														value="${userVO.e_mail}" required>
												</div>
											</div>
										</div>
										<!--목적-->
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="purposText">차후 활동 계획</label>
												</div>
												<div class="b-con-box">
													<textarea name="plan" id="plan" class="textareaBox"
														required></textarea>
												</div>
											</div>
										</div>

										<!--활동-->
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="activityText">바라는 점</label>
												</div>
												<div class="b-con-box">
													<textarea name="hope" id="hope"
														class="textareaBox" required></textarea>
												</div>
											</div>
										</div>
										<div class="bottom">다음과 같은 개인정보를 해당 신청한 동아리 임원(회장, 부회장)이
											볼 수 있습니다. 이를 동의하며 위의 기재한 내용이 틀림없음을 확인하며 가입을 신청합니다.</div>
										<div class="b-btn-wrap">
											<div class="apply">
												신청자(학번)<font>*</font> ( 
												<input type="text"
													style="width: 30%;" id="apply"> ) 
													
											</div>
											<button style="margin: 15px" type="submit"
												class="b-btn-type01 b-btn-c-blue submit">신청</button>
										</div>

									</fieldset>
								</form>
							</div>
							

						</div>
					</div>
				</div>
			</div>
		</div>
		
	</div>


	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		function check_form() {
			var ck_major = document.getElementById("major").value;
			var ck_grade = document.getElementById("grade").value;
			var ck_nm = document.getElementById("name").value;
			//var ck_gender = document.getElementById("GENDER").value;
			var ck_phone = document.getElementById("phone_no").value;
			var ck_apply = document.getElementById("apply").value;
			var ck_plan = document.getElementById("plan").value

			var exp = /^[0-9]{1}$/; //숫자만, 글자수 1
			var exp1 = /^[0-9]{9,13}$/; //숫자만, 전화번호 검증
			var exp2 = /^[0-9]{8}$/; //숫자만, 글자수8

			if (ck_major.trim() == "") {
				alert("학과를 입력해주세요");
				document.getElementById("MAJOR").focus();
				return false;
			}
			if (!ck_grade.match(exp)) {
				alert("학년은 숫자 1글자로 입력해주세요.");
				document.getElementById("GRADE").focus();
				return false;
			}
			if (ck_nm.trim() == "") {
				alert("이름을 입력해주세요");
				document.getElementById("NM").focus();
				return false;
			}
			
			if (ck_phone.trim() == "") {
				alert("전화번호를 입력해주세요.");
				document.getElementById("PHONE_NO").focus();
				return false;
			}
			
			if (ck_plan.trim() == "") {
				alert("차후 활동계획을 입력해주세요");
				document.getElementById("plan").focus();
				return false;
			}
			if (ck_apply.trim() == "") {
				alert("서명해주세요.");
				document.getElementById("apply").focus();
				return false;
			}
			if (ck_apply !=	<%=userId%>) {
				alert("학번을 정확하게 서명해주세요.");
				document.getElementById("apply").focus();
				return false;
			}
		

		}
	</script>


</body>
</html>