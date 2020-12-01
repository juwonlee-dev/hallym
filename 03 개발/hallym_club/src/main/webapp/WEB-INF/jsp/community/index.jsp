<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  

<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="hallym.club.club.vo.ClubVO"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>한림대학교 동아리 커뮤니티</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
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
	<!--font awesome-->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
	
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
    <script type = "text/javascript" src="${pageContext.request.contextPath}/res/board/js/hclubDesign.js" defer></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/datepicker/datepicker.js"></script>
	
	<script type="text/javascript">	        
    	
    </script>
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
	
	<c:set var="staff" value="${staff_cd}"/>
    <c:set var="clubVO" value="${clubVO}"/>
    <%
		ClubVO clubVO = (ClubVO) pageContext.getAttribute("clubVO");
    %>
	
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
	</ul>
	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap clubGreen"><jsp:include page="/WEB-INF/jsp/community/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/community/item/header.jsp"/></div>
		</header>
		<div class="sub-visual-wrap"></div>
        <div class="path-wrap">
            <div class="path-box">
                <div class="jwxe_navigator jw-relative">
                    <ul>
                        <li><a href="/clubIntro.do?club_id=${club_id}"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li><%=clubVO.getClub_nm()%></li>
                        <li class="clubonly">커뮤니티</li>
                    </ul>
                </div>
            </div>
        </div>
        
        <div class="sub-container">
			<!--왼쪽 게시판 메뉴-->
            <!--본문-->
	        <div class="newClubCommunity">
	            <div class="communitybox ver2">
	                <div class="commnunity-left ver2">
	                <div class="community-title">
	                     <span><i class="far fa-window-restore"></i>동아리 정보</span>
	                     
	                </div>
	                <div class="community-left-middle">
	                     <img src="upload/club/<%=clubVO.getIntro_save_file_nm()%>" onerror="this.src='images/error/error.png'">
	                     <div class="community-left-middle-text">
	                         <h3><%=clubVO.getClub_nm()%></h3>
	                         <span>회장 : <%=clubVO.getPresident()%></span>
	                         <span>개설일 : 
	                         <%
	                         	Date oldDate;
                            	SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
                            	SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
                            	try {
                                    oldDate = oldFormat.parse(clubVO.getOpen_dt());
                                   	out.print(newFormat.format(oldDate));
                            	} catch(Exception e){
                            		out.print(clubVO.getOpen_dt());
                            	}
	                         %>
	                         </span>
	                     </div>
	                </div>
	                </div>
	            </div>
	            <div class="main-content-wrap01 ver2" id="jwxe_main_content">
		            <div class="main-content-box main-content-box01 ver2">
		                <div class="main-mini-wrap ver2">
		                    
		                    <!-- 공지사항 목록 -->
		                    <div class="main-mini-box main-mini-box01 border">
		                        <h3 class="main-title ver2"><i class="fas fa-exclamation"></i>공지사항</h3>
		                        <div class="mini-board-content ver2">
		                            <ul>
									<c:forEach items='${noticeList}' var="item" varStatus="status">
										<li>
											<a class="articleTitle" href="/clubBoardReadForm.do?club_id=<%=clubVO.getClub_id()%>&board_cd=007001&board_no=${item.board_no}">
												<p>
													<span class="mini-title">
													<c:if test='${item.board_fix eq "Y"}'>
														[공지]
													</c:if>
														${item.title}
													</span>
												</p>
											</a>
											<span class="mini-date">
												<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
												<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
												${inputDate}
			                            	</span>
										</li>
									</c:forEach>
									<c:if test="${fn:length(noticeList) le 0}">
										<li class="list-none">
											등록된 글이 없습니다.
										</li>
									</c:if>
		                            </ul>
		                        </div>
		                        <a href="/clubBoardList.do?club_id=<%=clubVO.getClub_id()%>&board_cd=007001" title="공지사항 더보기" class="viewmore ver2">더보기</a>
		                    </div>
		                    
		                    <!-- 자유게시판 목록 -->
		                    <div class="main-mini-box main-mini-box01 ver2 border">
		                        <h3 class="main-title ver2"><i class="fas fa-users"></i>자유게시판</h3>
		                        <div class="mini-board-content ver2">
		                            <ul>
									<c:forEach items='${generalList}' var="item" varStatus="status">
										<li>
											<a class="articleTitle" href="/clubBoardReadForm.do?club_id=<%=clubVO.getClub_id()%>&board_cd=007002&board_no=${item.board_no}">
												<p>
													<span class="mini-title">
													<c:if test='${item.board_fix eq "Y"}'>
														[공지]
													</c:if>
														${item.title}
													</span>
												</p>
											</a>
											<span class="mini-date">
												<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
												<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
												${inputDate}
			                            	</span>
										</li>
									</c:forEach>
									<c:if test="${fn:length(generalList) le 0}">
										<li class="list-none">
											등록된 글이 없습니다.
										</li>
									</c:if>
		                            </ul>
		                        </div>
		                        <a href="/clubBoardList.do?club_id=<%=clubVO.getClub_id()%>&board_cd=007002" title="자유게시판 더보기" class="viewmore ver2">더보기</a>
		                    </div>
		                </div>
	                </div>
	            </div>
	            <div class="main-content-wrap01 ver2" id="jwxe_main_content">
	                <div class="main-content-box main-content-box01 ver2">
	                    <div class="main-mini-wrap ver2 plus">
	                        
	                        <!-- 교내활동 목록 -->
	                        <div class="main-mini-box main-mini-box01 border">
	                            <h3 class="main-title ver2"><i class="fas fa-school"></i>교내 활동</h3>
	                            <div class="mini-board-content ver2">
	                                <ul>
									<c:forEach items='${inActList}' var="item" varStatus="status">
										<li>
											<a class="articleTitle" href="/clubActivityRead.do?club_id=${club_id}&act_cd=${item.act_cd}&act_no=${item.act_no}">
												<p>
													<span class="mini-title">
												<c:choose>
													<c:when test="${item.accept_cd eq '017001'}">
														[승인됨]
													</c:when>
													<c:when test="${item.accept_cd eq '017002'}">
														[거부됨]
													</c:when>
													<c:when test="${item.accept_cd eq '017003'}">
														<!-- [대기중] -->
													</c:when>
													<c:when test="${item.accept_cd eq '017004'}">
														[보류중]
													</c:when>
													<c:otherwise>
														
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${item.act_kind_cd eq '016001'}">
														[일반]
													</c:when>
													<c:when test="${item.act_kind_cd eq '016002'}">
														[수상]
													</c:when>
													<c:otherwise>
														
													</c:otherwise>
												</c:choose>
														${item.act_title}
													</span>
												</p>
											</a>
											<span class="mini-date">
												<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
												<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
												${inputDate}
			                            	</span>
										</li>
									</c:forEach>
									<c:if test="${fn:length(inActList) le 0}">
										<li class="list-none">
											등록된 활동이 없습니다.
										</li>
									</c:if>
	                                </ul>
	                            </div>
	                            <a href="/clubActivityList.do?club_id=${club_id}&act_cd=015001" title="교내활동 더보기" class="viewmore ver2">더보기</a>
	                        </div>
	                        
	                        <!-- 교외활동 목록 -->
	                        <div class="main-mini-box main-mini-box01 ver2 border">
	                            <h3 class="main-title ver2"><i class="fas fa-building"></i>교외 활동</h3>
	                            <div class="mini-board-content ver2">
	                                <ul>
	                                 
									<c:forEach items='${outActList}' var="item" varStatus="status">
										<li>
											<a class="articleTitle" href="/clubActivityRead.do?club_id=${club_id}&act_cd=${item.act_cd}&act_no=${item.act_no}">
												<p>
													<span class="mini-title">
												<c:choose>
													<c:when test="${item.accept_cd eq '017001'}">
														[승인됨]
													</c:when>
													<c:when test="${item.accept_cd eq '017002'}">
														[거부됨]
													</c:when>
													<c:when test="${item.accept_cd eq '017003'}">
														<!-- [대기중] -->
													</c:when>
													<c:when test="${item.accept_cd eq '017004'}">
														[보류중]
													</c:when>
													<c:otherwise>
														
													</c:otherwise>
												</c:choose>
												<c:choose>
													<c:when test="${item.act_kind_cd eq '016001'}">
														[일반]
													</c:when>
													<c:when test="${item.act_kind_cd eq '016002'}">
														[수상]
													</c:when>
													<c:otherwise>
														
													</c:otherwise>
												</c:choose>
														${item.act_title}
													</span>
												</p>
											</a>
											<span class="mini-date">
												<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
												<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
												${inputDate}
			                            	</span>
										</li>
									</c:forEach>
									<c:if test="${fn:length(outActList) le 0}">
										<li class="list-none">
											등록된 활동이 없습니다.
										</li>
									</c:if>
									
	                                </ul>
	                            </div>
	                            <a href="/clubActivityList.do?club_id=${club_id}&act_cd=015002" title="교외활동 더보기" class="viewmore ver2">더보기</a>
	                        </div>
	                    </div>
                   	</div>
               	</div>
			</div>
		<!-- End of sub-container -->
		</div>
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
	</div>
	
</body>
</html>