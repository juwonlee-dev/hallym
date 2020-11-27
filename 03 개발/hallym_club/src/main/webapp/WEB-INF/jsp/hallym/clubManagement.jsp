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
	<title>한림대학교 동아리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
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
	

	<script type="text/javascript">	        
	   
        
        function getPage(data1, data2, data3, data4) {
        	var page_cd = "<%=session.getAttribute("page_cd") %>"
        	var urlpaging = "/clubManagement.do?";
        	if(page_cd == "013004" || page_cd == "013005") {
        		
            	var opt = data1; /* year */
            	var link = urlpaging + "&page_cd=" + page_cd + "&year="+opt;
        		location.href = link; 
        	} else {
        		var page = data1; /* 페이지 번호 */
            	var opt = data2; /* page_cd*/
            	var opt2 = data3; /* search */
            	var link = urlpaging + "&page=" + page;
            	
            	if(opt != null) {
            		link += "&page_cd=" + opt;
            	}
            	if(opt2 != null) {
            		link += "&search=" + opt2;
            	}
            	
            	location.href = link; 
        	}
            
        	
        }
        
        $(document).ready(function() {
        	var page_cd = "<%=session.getAttribute("page_cd") %>"
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	<%System.err.println("[clubManagement.jsp] page_cd: " +session.getAttribute("page_cd")); %>
        	for(var i=0; i<sidemenu.length; i++) {
        		if(sidemenu[i].className == "active") {
        			activeNum = i;
        			break;
        		}
        	}
        	var msg = "";
        	var msg2 = "";
        	
    		sidemenu[activeNum].classList.remove('active');
    		sidemenu[activeNum].getElementsByTagName("a")[0].classList.remove("active");
        	switch(page_cd) {
        	case "013001":
        		msg = "등록요청한 동아리";
        		msg2 = "관리자 페이지";
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "013002":
        		msg = "등록된 동아리";
        		msg2 = "관리자 페이지";
        		sidemenu[1].classList.add('active');
        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	
        	case "013003":
        		msg = "삭제처리된 동아리";
        		msg2 = "관리자 페이지";
        		sidemenu[2].classList.add('active');
        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	
        	case "013004":
        		msg = "우수동아리 순위 지정(공연)";
        		msg2 = "관리자 페이지";
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "013005":
        		msg = "우수동아리 순위 지정(비공연)";
        		msg2 = "관리자 페이지";
        		sidemenu[4].classList.add('active');
        		sidemenu[4].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	default:
        		msg = "디폴트";
        		msg2 = "관리자 페이지";
        		break;
        	}
        	document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > div > div > h2").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(2)").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(3)").innerText = msg;
        	document.querySelector("#item_body > div > div.sub-container > div.content-wrap > div.title > div > h3").innerText = msg;
        	
        	
        });

    </script>
	<!--style-->
	<style type='text/css'></style>

</head>


<body id="item_body" class="pc">
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = (UserVO) session.getAttribute("userVO");
			cuserId = cuserVO.getId();
		}
	%>
	
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
	</ul>
	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
		<div class="sub-visual-wrap"></div>
        <div class="path-wrap">
            <div class="path-box">
                <div class="jwxe_navigator jw-relative">
                    <ul>
                        <li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>구분</li>
                        <li>관리자 페이지</li>
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
                     
						<li class="active"><a href="/clubManagement.do?page_cd=013001" class="active">등록요청한 동아리</a></li>
                        <li><a href="/clubManagement.do?page_cd=013002">등록된 동아리</a></li>
                        <li><a href="/clubManagement.do?page_cd=013003">삭제처리된 동아리</a></li>
                        <li><a href="/clubManagement.do?page_cd=013004">우수동아리 순위 지정(공연)</a></li>
                        <li><a href="/clubManagement.do?page_cd=013005">우수동아리 순위 지정(비공연)</a></li>
                    
                    </ul>
                </div>
            </div>
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>관리자 페이지</h3>
                    </div>
                </div>
                
                <div class="tab"></div>
                <!--공지사항-->
                <div class="content" id="jwxe_main_content">
                    <script type="text/javascript">
                        //<![CDATA[
                          var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
                          clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
                        //]]>
                    </script>
                    <div class="ko board list co-board type01">
                        <div class="common">
                            <!--검색창-->
                            <div class="bn-search01 type01">
                                <form method="post" action="/clubManagement.do" name="clubForm" enctype="multipart/form-data">
                                    <c:choose>
                                    <c:when test="${page_cd eq '013004' || page_cd eq '013005'}">
                                    <fieldset class="b-search-wrap">
										<legend class="hide">게시글 검색</legend>
										<div class="b-sel-box b-cate-basic" style="z-index: 0;">
											<select id="selectYear" class="b-sel-title" name="year" onchange="changeSelect('${page_cd}','${gb_cd}','${at_cd}');">
												<option class=searchOption value="2019"
												>2019</option>
												<option class=searchOption value="2018">2018</option>
												<option class=searchOption value="2017">2017</option>
											</select>
										</div>
										
										<c:choose>
										<c:when test="${page_cd eq '013004'}">
										<input type="hidden" name="at_cd" value="002001">
										</c:when>
										<c:otherwise>
										<input type="hidden" name="at_cd" value="002002">
										</c:otherwise>
										</c:choose>
										<input type="hidden" name="page_cd" value="${page_cd}">
										<input type="hidden" name="gb_cd" value="${gb_cd}">
										
									</fieldset>
                                    </c:when>
                                    <c:otherwise>
                                    <fieldset class="b-search-wrap">
                                        <legend class="hide">동아리 검색</legend>
                                        <input type="hidden" name="page_cd" value="${page_cd}">
                                        <div class="b-sel-box b-cate-basic" style="z-index: 0;">
                                        	<select class="b-sel-title" name="gb_cd">
                                        		<option class=searchOption value="0">전체</option>
								                <option class=searchOption value="001001">증앙동아리</option>
								                <option class=searchOption value="001002">과동아리</option>
								            </select>
								        </div>
                                        <div class="b-sel-box b-cate-basic" style="z-index: 0;">
                                        	<select class="b-sel-title" name="at_cd">
								                <option class=searchOption value="002">전체</option>
                                        		<option class=searchOption value="002001">공연</option>
								                <option class=searchOption value="002002">학술</option>
								                <option class=searchOption value="002003">취미예술</option>
								                <option class=searchOption value="002004">종교</option>
								                <option class=searchOption value="002005">체육</option>
								                <option class=searchOption value="002006">봉사</option>
								                <option class=searchOption value="002007">기타</option>
								            </select>
                                        </div>
                                        <label for="search_val" class="b-sel-label"><span>검색어</span></label>
                                        <input type="text" id="search_val" name="search" value placeholder="검색어를 입력해 주세요">
                                        <button type="submit" class="b-sel-btn">검색</button>
                                    </fieldset>
                                    </c:otherwise>
                                    </c:choose>
                                    
                                </form>
                            </div>
                            <!--검색창-->

                            <!--공지사항1-->
                            
                            <div id="content">
			<div class="main">
				<div class="mainLeft" style="margin-bottom: 20dp">
				<c:choose>
					<c:when test="${page_cd eq '013001'}">
							<table id="myTable" class="type04" border="1"
							style="table-layout: fixed;"> 
							<th style="font-size: 25px; width: 200px;">등록요청한 동아리</th>
							<th style="font-size: 12px; width: 100px;">총 ${clubListCount} 개의 동아리</th>
							<tr>
								<th style="font-size: 20px; width: 160px;">동아리 명</th>
								<th style="font-size: 20px; width: 100px;">구분</th>
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
								<c:when test="${not empty clubList }">
									<c:forEach items='${clubList}' var="item" varStatus="status">
									
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
						</c:when>
						<c:when test="${page_cd eq '013002'}">
							<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
							<th style="font-size: 25px; width: 200px;">등록된 동아리</th>
							<th style="font-size: 12px; width: 100px;">총 ${clubListCount} 개의 동아리</th>
							<tr>
								<th style="font-size: 20px; width: 160px;">동아리 명</th>
								<th style="font-size: 20px; width: 100px;">구분</th>
								<th style="font-size: 20px; width: 50px;">분야</th>
								
								<th style="font-size: 20px; width: 140px;">개설년도</th>
								<th style="font-size: 20px; width: 70px;">동아리방</th>
								
								<th style="font-size: 20px; width: 110px;">회장 이름</th>
								<th style="font-size: 20px; width: 110px;">회장 학번</th>
								<th style="font-size: 20px; width: 125px;">기타</th>
							</tr>
						
							
								<c:choose>
									<c:when test="${not empty clubList }">
										<c:forEach items='${clubList}' var="item" varStatus="status">
										<tr>
										<form name="form" method="post" action="clubInfo.do">
											<td class="club_manage" onclick="popup(${item.club_id})">${item.club_nm}</td>
											<input type="hidden" name="club_id" value="${item.club_id}">
										</form>
										<td>${item.club_gb_cd}</td>
										<td>${item.club_at_cd}</td>
										
										<td>${item.open_dt}</td>
										<td>${item.club_room}</td>
										
										<td>${item.president}</td>
										<td>${item.president_id}</td>
										<td>
											<form name="form" method="post" action="clubHideAction.do">
												<input type="hidden" name="club_id" value="${item.club_id}">
												<input type="submit" value="삭제" name="submit" class="manage-btn"
												onclick="return confirm('${item.club_nm}(${item.club_id}) 삭제하겠습니까?');"> 
											</form>
											
										</td>
										
										</tr>
										</c:forEach>
									</c:when>
								</c:choose>
								</table>
								</c:when>
								<c:when test="${page_cd eq '013003'}">
								<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
								<th style="font-size: 25px; width: 200px;">삭제처리된 동아리</th>
								<th style="font-size: 12px; width: 100px;">총 ${clubListCount} 개의 동아리</th>
								<tr>
									<th style="font-size: 20px; width: 160px;">동아리 명</th>
									<th style="font-size: 20px; width: 100px;">구분</th>
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
									<c:when test="${not empty clubList }">
										<c:forEach items='${clubList}' var="item" varStatus="status">
										<tr>
										<form name="form" method="post" action="clubInfo.do">
											<td class="club_manage" onclick="popup(${item.club_id})">${item.club_nm}</td>
											<input type="hidden" name="club_id" value="${item.club_id}">
										</form>
										<td>${item.club_gb_cd}</td>
										<td>${item.club_at_cd}</td>
										<td>${item.open_dt}</td>
										<td>${item.club_room}</td>
										<td>${item.president}</td>
										<td>${item.president_id}</td>
										<td>
											<form name="form" method="post" action="clubReOpenAction.do">
												<input type="hidden" name="club_id" value="${item.club_id}">
												<input type="submit" value="취소" name="submit" class="manage-btn"
												onclick="return confirm('${item.club_nm}(${item.club_id}) 삭제취소하겠습니까?');"> 
											</form>
										</td>
										
										</tr>
										</c:forEach>
									</c:when>
								</c:choose>
								</table>
								</c:when>
								
								<c:when test="${page_cd eq '013004'}">
								<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
								<th style="font-size: 25px; width: 200px;">우수동아리 순위 지정 (공연)</th>
								<th style="font-size: 12px; width: 100px;">총 ${clubListCount} 개의 동아리</th>
								<th style="font-size: 12px; width: 100px;">${year}년도</th>
								<tr>
									<th style="font-size: 20px; width: 160px;">동아리 명</th>
									<th style="font-size: 20px; width: 100px;">구분</th>
									<th style="font-size: 20px; width: 50px;">분야</th>
									<th style="font-size: 20px; width: 70px;">순위</th>
									<th style="font-size: 20px; width: 125px;">기타</th>
								</tr>
							
							
								<c:choose>
									<c:when test="${not empty clubList }">
										<c:forEach items='${clubList}' var="item" varStatus="status">
										<tr>
										<form name="form" method="post" action="">
											<td class="club_manage" onclick="topPopup(${item.club_id}, ${year},${item.rank})">${item.club_nm}</td>
											<input type="hidden" name="club_id" value="${item.club_id}">
											<input type="hidden" name="year" value="${year}">
										</form>
										<td>${item.club_gb_cd}</td>
										<td>${item.club_at_cd}</td>
										<td>${item.rank}</td>
										<td>
											<form name="form" method="post" action="topClubAction.do">
												<input type="hidden" name="club_id" value="${item.club_id}">
												<input type="hidden" name="year" value="${year}">
												<input type="hidden" name="page_cd" value="${page_cd}">
												<input type="submit" value="제외" name="submit" class="manage-btn"
												onclick="return confirm('${item.club_nm}(${item.club_id}) 우수동아리에서 제외 시키겠습니까?');"> 
											</form>
										</td>
										
										</tr>
										</c:forEach>
									</c:when>
								</c:choose>
								</table>
								</c:when>
								<c:when test="${page_cd eq '013005'}">
								<table id="myTable" class="type04" border="1" style="table-layout: fixed;">
								<th style="font-size: 25px; width: 200px;">우수동아리 순위 지정 (비공연)</th>
								<th style="font-size: 12px; width: 100px;">총 ${clubListCount} 개의 동아리</th>
								<th style="font-size: 12px; width: 100px;">${year}년도</th>
								<tr>
									<th style="font-size: 20px; width: 160px;">동아리 명</th>
									<th style="font-size: 20px; width: 100px;">구분</th>
									<th style="font-size: 20px; width: 50px;">분야</th>
									<th style="font-size: 20px; width: 70px;">순위</th>
									<th style="font-size: 20px; width: 125px;">기타</th>
								</tr>
							
							
								<c:choose>
									<c:when test="${not empty clubList }">
										<c:forEach items='${clubList}' var="item" varStatus="status">
										<tr>
										<form name="form" method="post" action="topClubAction.do">
											<td class="club_manage" onclick="topPopup(${item.club_id},${year}, ${item.rank})">${item.club_nm}</td>
											<input type="hidden" name="club_id" value="${item.club_id}">
											<input type="hidden" name="year" value="${year}">
											<input type="hidden" name="page_cd" value="${page_cd}">
										</form>
										<td>${item.club_gb_cd}</td>
										<td>${item.club_at_cd}</td>
										<td>${item.rank}</td>
										<td>
											<form name="form" method="post" action="topClubAction.do">
												<input type="hidden" name="club_id" value="${item.club_id}">
												<input type="hidden" name="year" value="${year}">
												<input type="hidden" name="page_cd" value="${page_cd}">
												<input type="submit" value="제외" name="submit" class="manage-btn"
												onclick="return confirm('${item.club_nm}(${item.club_id}) 우수동아리에서 제외 시키겠습니까?');"> 
											</form> 
										</td>
										
										</tr>
										</c:forEach>
									</c:when>
								</c:choose>
								</table>
								</c:when>
								<c:otherwise>
									ERROR
								</c:otherwise>
							</c:choose>
					
							</div>
							</div>
						</div>

                            <!--공지사항2-->
                            <div class="b-paging01 type03">
                                <div class="b-paging01 type01">
                                    <div class="b-paging-wrap">
                                    	<c:choose>
                                    	<c:when test="${page_cd eq '013004' || page_cd eq '013005'}">
                                    	
                                    	</c:when>
                                    	<c:otherwise>
                                    	<ul>
											<c:if test="${totalPage > 1 and currPage ne prevPage}">
												<li class="first pager">
													<a href="javascript:getPage(1,'${page_cd}','${search}');" title="첫 페이지로 이동하기">
														<span class="hide">첫 페이지로 이동하기</span>
													</a>
												</li>
												<li class="prev pager">
													<a href="javascript:getPage(${prevPage},'${page_cd}','${search}');" title="이전 페이지로 이동하기">
														<span class="hide">이전 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											<c:forEach var="i" begin="1" end="${totalPage}">
												<li>
													<c:choose>
							                        	<c:when test="${i eq currPage}">
							                        		<a class="active" href="javascript:getPage(${i},'${page_cd}','${search}');">${i}</a>
							                        	</c:when>
							                        	<c:otherwise>
							                        		<a class href="javascript:getPage(${i},'${page_cd}','${search}');">${i}</a>
							                        	</c:otherwise>
							                        </c:choose>
						                        </li>
											</c:forEach>
											<c:if test="${totalPage > 1 and currPage ne nextPage}">
												<li class="next pager">
													<a href="javascript:getPage(${nextPage},'${page_cd}','${search}');" title="다음 페이지로 이동하기">
														<span class="hide">다음 페이지로 이동하기</span>
													</a>
												</li>
												<li class="last pager">
													<a href="javascript:getPage(${totalPage},'${page_cd}','${search}');" title="마지막 페이지로 이동하기">
														<span class="hide">마지막 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											
										</ul>
                                    	</c:otherwise>
                                    	</c:choose>
										
									</div>
                                </div>
                            </div>
                            <!--공지사항2-->
                            <div class="b-btn-wrap">
                       		 
                            </div>
                            <form name=admin-form method=post action="">
                                <input type="hidden" name="method">
                                <input type="hidden" name="articles">
                                <input type="hidden" name="confirMode">
                            </form>
                        </div>
                    </div>
                </div>
                <!--공지사항-->

            </div>
            <!--공지사항 본문-->
		</div>
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
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
	function topPopup(frm, year, curRank) {
		var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=1200, height=500, top=50,left=20";
		if(winRef == null){
			winRef = window.open("/topClubInfo.do?club_id="+frm+"&year="+year+"&curRank="+curRank, 'w', status);
			return true;
			
		} else {
			if(winRef.closed == false){
				winRef.focus();
				return true;
			}
			else {
				winRef = window.open("/topClubInfo.do?club_id="+frm+"&year="+year+"&curRank="+curRank, 'w', status);
				return true;
			}
		}
	}
	
	function changeSelect(page_cd,gb_cd, at_cd){
		var select = document.getElementById("selectYear");
		var selectValue = select.options[select.selectedIndex].value;
		location.href = "/clubManagement.do?page_cd="+page_cd+"&year="+selectValue;

	}
	
</script>
	
</body>
</html>