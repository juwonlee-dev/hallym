<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마이페이지</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css?after">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/table.css?after">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/page.css?after">
<style>
.main {
	float: left; 
	left:12%;
	position: relative;
	width: 75%;
	height: 100%;
	margin-left: 20px;
}

table.type04 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-left: 1px solid #ccc;
	border-top: 3px solid #369;
	margin: auto;
	text-align: center;
	width: 100%;
	font-size: 25px;
}

table.type04 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: top;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type04 td {
	padding: 3px;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
	vertical-align: middle;
}

.mainLeft {
	border: 1px solid #ccc;
	margin: 0 auto;
	display: block;
	padding: 10px;
	min-height: 75%;
	/*width: 100%; */
	overflow: auto;
}

.club_manage {
	text-decoration: none;
	color: black;
}

.club_manage:hover {
	text-decoration: underline;
	color: blue;
}

</style>
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
<!--style-->
<style type='text/css'></style>
</head>
<body>
	<div id="wrap">
		<div class="container">
			<div class="sub-wrap">
				<header>
					<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
					<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
				</header>

		<div id="content">
			<div class="main">
				
				<div class="mainLeft" style="width: 75%;">
						
					<table id="myTable" class="type04" border="1"
						style="table-layout: fixed;">
						<th style="font-size: 25px; width: 500px;">가입 승인 중인 동아리</th>
						<tr>
							<th style="font-size: 20px; width: 500px;">동아리 명</th>
							<th style="font-size: 20px; width: 125px;">기타</th>
						</tr>
						
						<c:choose>
							<c:when test="${not empty waitJoinClub }">
								<c:forEach items='${waitJoinClub}' var="item" varStatus="status">
								<form method="post" action="applyClubDeleteAction.do">
								<tr>
									<td>${item.club_nm}</td>
									<input type="hidden" name="club_id" value="${item.club_id}">
									<td>
									<input type="submit" value="신청 취소" name="submit" class="manage-btn"
									onclick="return confirm('${item.club_nm} 가입 신청을 취소하시겠습니까?');">
								</tr>
								</form>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr> 
								<td>없음</td>
								<td>없음</td>
							
							</tr>
							</c:otherwise>
						</c:choose>
		
					</table>
					
					<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
						<th style="font-size: 25px; width: 200px;">동아리 등록 현황</th>
						<tr>
						
							<th style="font-size: 20px; width: 160px;">동아리 명</th>
							<th style="font-size: 20px; width: 50px;">구분</th>
							<th style="font-size: 20px; width: 50px;">분야</th>
							<th style="font-size: 20px; width: 550px;">목적</th>
							<th style="font-size: 20px; width: 130px;">활동</th>
							<th style="font-size: 20px; width: 140px;">개설년도</th>
							<th style="font-size: 20px; width: 70px;">동아리방</th>
							<th style="font-size: 20px; width: 125px;">기타</th>
						</tr>
						
						<c:forEach items='${waitRegisterClubList}' var="item" varStatus="status">
						
							<tr>
								<td>${item.club_nm}</td>
								<td>${item.club_gb_cd}</td>
								<td>${item.club_at_cd}</td>
								<td>${item.club_aim}</td>
								<td>${item.club_active}</td>
								<td>${item.open_dt}</td>
								<td>${item.club_room}</td>
								
								<form name="form" method="post" action="applyClubRegisterDeleteAction.do">
									<td>
										<input type="hidden" name="club_id" value="${item.club_id}">
										<input type="submit" value="신청 취소" name="submit" class="manage-btn"
										onclick="return confirm('${item.club_nm} 동아리 등록을 취소하시겠습니까?');"> 
									</td>
								</form>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
		</div>
		<%-- <footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer> --%>
	
		</div>
	</div>

</body>
</html>