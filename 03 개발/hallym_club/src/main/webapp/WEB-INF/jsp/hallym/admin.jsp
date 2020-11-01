<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Content-Security-Policy" content="upgrade-insecure-requests">
<title>한림대학교 동아리</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/page.css">
<style>
.main {
	float: left;
	position: relative;
	width: 100%;
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

.club_picture {
	text-decoration: none;
	color: black;
}

.club_picture:hover {
	text-decoration: underline;
	color: blue;
}
</style>
<!--css-->
<!--link-->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" /><!--  -->

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
						<th style="font-size: 25px; width: 200px;">등록요청한 동아리</th>
						<tr>
							<th style="font-size: 20px; width: 160px;">동아리 명</th>
							<th style="font-size: 20px; width: 50px;">구분</th>
							<th style="font-size: 20px; width: 50px;">분야</th>
							<th style="font-size: 20px; width: 250px;">목적</th>
							<th style="font-size: 20px; width: 130px;">활동</th>
							<th style="font-size: 20px; width: 140px;">개설년도</th>
							<th style="font-size: 20px; width: 70px;">동아리방</th>
							
							<th style="font-size: 20px; width: 140px;">프로필</th>
							<th style="font-size: 20px; width: 70px;">포스터</th>
							
							<th style="font-size: 20px; width: 110px;">회장 이름</th>
							<th style="font-size: 20px; width: 110px;">회장 학번</th>
							<th style="font-size: 20px; width: 125px;">기타</th>
						</tr>
						
						<c:choose>
							<c:when test="${not empty waitRegisterClubList }">
								<c:forEach items='${waitRegisterClubList}' var="item" varStatus="status">
								
								<form name="form" method="post" action="registerUpdateAction.do">
								<tr>
								
								<td>${item.club_nm}</td>
								<td>${item.club_gb_cd}</td>
								<td>${item.club_at_cd}</td>
								<td>${item.club_aim}</td>
								<td>${item.club_active}</td>
								<td>${item.open_dt}</td>
								<td>${item.club_room}</td>
								
								<td class="club_picture" onclick="window.open('upload/club/${item.intro_save_file_nm}','new img', 'width=750,height=850')">클릭</td>
								<td class="club_picture" onclick="window.open('upload/club/${item.poster_save_file_nm}','new img', 'width=750,height=850')">클릭</td>
								
								<td>${item.president}</td>
								<td>${item.president_id}</td>
								
								<input type="hidden" name="club_id" value="${item.club_id}">
		
								<td>
								<input type="submit" value="수락" name="submit" class="manage-btn"
								onclick="return confirm('${item.club_nm}(${item.club_id}) 수락하시겠습니까?');">
								
								<input type="submit" value="거절" name="submit" class="manage-btn"
								onclick="return confirm('${item.club_nm}(${item.club_id}) 거절하시겠습니까?');"></td>
								</tr>
								</form>
								</c:forEach>
							</c:when>
							<c:otherwise>
							<tr> 
							
							</tr>
							</c:otherwise>
						</c:choose>
		
					</table>
		
					<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
						<th style="font-size: 25px; width: 200px;">등록된 동아리</th>
						<tr>
							<th style="font-size: 20px; width: 160px;">동아리 명</th>
							<th style="font-size: 20px; width: 50px;">구분</th>
							<th style="font-size: 20px; width: 50px;">분야</th>
							<!-- 
							<th style="font-size: 20px; width: 250px;">목적</th>
							<th style="font-size: 20px; width: 130px;">활동</th>
							 -->
							 
							<th style="font-size: 20px; width: 140px;">개설년도</th>
							<th style="font-size: 20px; width: 70px;">동아리방</th>
							
							<th style="font-size: 20px; width: 110px;">회장 이름</th>
							<th style="font-size: 20px; width: 110px;">회장 학번</th>
							<th style="font-size: 20px; width: 125px;">기타</th>
						</tr>
					
						
						<c:choose>
							<c:when test="${not empty registerClubList }">
								<c:forEach items='${registerClubList}' var="item" varStatus="status">
								<tr>
								<form name="form" method="post" action="clubInfo.do">
									<td class="club_manage" onclick="popup(${item.club_id})">${item.club_nm}</td>
									<input type="hidden" name="club_id" value="${item.club_id}">
								</form>
								<td>${item.club_gb_cd}</td>
								<td>${item.club_at_cd}</td>
								<%-- 
								<td>${item.club_aim}</td>
								<td>${item.club_active}</td>
								 --%>
								<td>${item.open_dt}</td>
								<td>${item.club_room}</td>
								
								<td>${item.president}</td>
								<td>${item.president_id}</td>
								<td>
									<form name="form" method="post" action="clubDeleteAction.do">
										<input type="hidden" name="club_id" value="${item.club_id}">
										<input type="submit" value="삭제" name="submit" class="manage-btn"
										onclick="return confirm('${item.club_nm}(${item.club_id}) 삭제하겠습니까?');"> 
									</form>
									<form name="form" method="post" action="topClubAction.do">
										<input type="hidden" name="club_id" value="${item.club_id}">
										<input type="hidden" name="at_cd" value="${item.club_at_cd}">
										<input type="hidden" name="gb_cd" value="${item.club_gb_cd}">
										<input type="submit" value="top in" name="submit" class="manage-btn"
										onclick="return confirm('${item.club_nm}(${item.club_id}) 우수 동아리로 등록 하겠습니까?');">
										<input type="submit" value="top out" name="submit" class="manage-btn"
										onclick="return confirm('${item.club_nm}(${item.club_id}) 우수 동아리를 해지 하겠습니까?');">
									</form>
								</td>
								
								</tr>
								</c:forEach>
							</c:when>
						</c:choose>
					</table>
					</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<script>
		var winRef;
		function popup(frm) {
			var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=1200, height=500, top=50,left=20";
			if(winRef == null){
				winRef = window.open("/clubInfo.do?club_id="+frm, 'w', status);
				return true;
				
			} else {
				if(winRef.closed == false){
					winRef.focus();
					return true;
				}
				else {
					winRef = window.open("/clubInfo.do?club_id="+frm, 'w', status);
					return true;
				}
			}
		}
	</script>
	<!-- <script>
		function popup(frm) {
			var url = "club_info.do?club_id="+frm;
			var title = "testpop";
			var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=1200, height=500, top=50,left=20";
			window.open(url, title, status); 
			//window.open(url,title,status); window.open 함수에 url을 앞에와 같이
			//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
			//가능합니다.
			frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
			frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
			frm.method = "post";
			frm.submit();
		}
	</script> -->

</body>
</html>