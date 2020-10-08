<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css">
<!--css-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/css/jquery.tagit.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/css/tagit.ui-zendesk.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
<link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
<link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
      
<!--js-->
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
<script defer="" type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
<script type="text/javascript">
     //<![CDATA[
	var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
	,_cur_menu_cd = '4146',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/_res/league/'
	,editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = '',developMode = false,device='pc',isMobile=false
	,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = '',locale= 'ko'
	,localeScriptPath='${pageContext.request.contextPath}/custom/js/';
     //]]>
</script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/ckeditor/config.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/tag-it.min.2.0.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/jquery.autosize.input.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/test/custom/js/board.write.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/test/common/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20200506_00/e/js/element/element_main.js"></script>

</head>

<body>

	<c:set var="staff" value="${staff_cd}"/>
	<div class="wrap">
	
		<div class="container">
			<div class="sub-wrap">
				<header>
					<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
					<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
				</header>
				
				<div class="latest">
					<div class="notice">
						<h4>
							커뮤니티 정보&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<input type="button" value="나의정보"
								style="background-color: transparent; border: 0px transparent solid;"
								onclick="location.href ='applyMod.jsp?club_id=${club_id}';" />
						</h4>
						<ul>
						
							<div class="icon">
								<img width="60" height="90" src="upload/club/${club_intro}" alt="">
							</div>
							
							<li><input type="text" name="club_name" value="${club_name}"
								size=16 readonly></li>
							<li>회장 : ${president_nm}</li>
							<li style="border-bottom: 2px solid #797979;">개설일 : ${open_dt}</li>
						</ul>
						<hr>
			
						<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
							<li style="font-size: 13px; border-bottom: 0.5px solid #797979;">동아리</li>
							<li style="margin-left: 15px;"><input type="button"
								value="소개"
								onclick="location.href ='clubIntro.do?club_id=${club_id}';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="물품목록"
								onclick="location.href ='clubProduct.do?club_id=${club_id}';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="예산"
								onclick="location.href ='club_budget.jsp?club_id=${club_id}';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="회원목록"
								onclick="location.href ='clubMemberList.do?club_id=${club_id}';" /></li>
						</ul>
						<hr>
			
						<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
							<li style="font-size: 13px; border-bottom: 0.5px solid #797979;">게시판</li>
							<li style="margin-left: 15px;"><input type="button"
								value="공지사항"
								onclick="location.href='clubBoardList.do?club_id=${club_id}&board_cd=007001';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="자유게시판"
								onclick="location.href='clubBoardList.do?club_id=${club_id}&board_cd=007002';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="사진"
								onclick="location.href='clubBoardList.do?club_id=${club_id}&board_cd=007003';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="일정"
								onclick="location.href='clubCalendar.do?club_id=${club_id}&board_cd=007004';" />
			
							</li>
							<li style="margin-left: 25px;"><input type="button"
								value="└개인 정보 동의"
								onclick="location.href='myClub_Board.jsp?club_id=${club_id}&board_cd=007004';" /></li>
							
							<!-- 임원일 때  -->
							<c:if test="${(isStaff eq true)}">
							<li style="margin-left: 25px;"><input type="button"
								value="└개인 정보 동의 목록"
								onclick="location.href='club_agreeMember.jsp?club_id=${club_id}&title_no=-1';" /></li>
							
							</c:if>
						</ul>
						<hr>
						
						<!-- 임원일 때  --> 
						<c:if test="${isStaff eq true}">
						<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
							<li style="font-size: 13px; border-bottom: 0.5px solid #797979;">동아리
								관리</li>
							<li style="margin-left: 15px;"><input type="button"
								value="동아리 회원 승인"
								onclick="location.href='manage.jsp?club_id=${club_id}';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="동아리 회원 관리"
								onclick="location.href='manage_list.jsp?club_id=${club_id}';" /></li>
							<li style="margin-left: 15px;"><input type="button"
								value="동아리 정보 수정"
								onclick="location.href='updateClub.jsp?club_id=${club_id}';" /></li>
						</ul>
						<hr>
						</c:if>	
			
						<ul style="margin-top: 10px; border-bottom: 2px solid #797979;">
							<form method="post" action="applyDeleteAction.jsp"
								onSubmit="return confirm('탈퇴 신청을 하시겠습니까?');">
								<input type="hidden" name="clubNM" value="${club_name}"> <input
									type="submit" value="탈퇴 하기"
									style="background-color: transparent; border: 0px transparent solid; cursor: pointer;">
							</form>
						</ul>
						<hr> 
					</div>
				</div>
			</div>
		</div>
		<%-- <footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>  --%>
	</div>
	
	
</body>
</html>