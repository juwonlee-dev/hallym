<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="hallym.club.user.vo.UserVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		String cusername = null;
		//String auth_code = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = ((UserVO) session.getAttribute("userVO"));
			cuserId = cuserVO.getId();
			cusername = cuserVO.getName();
			//auth_code = (String) session.getAttribute("auth_code");
		}
	%>
	<div class="bottom-header-box">
		<a class="btn-menu" href="#a"><span class="hide">모바일 메뉴 열기</span></a>
		<h1>
			<a href="/index.do" title="동아리 바로가기"> 
				<img src="${pageContext.request.contextPath}/images/common/img-logo.png" alt="한림대학교">
				<span>동아리</span>
			</a>
		</h1>
		<div class="gnb">
			<ul class="gnb-ul jwxe-menu-ul">
				<li>
				 	<a title="소개" href="/introView.do" class="">
				 		<span>소개</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/introView.do?board_cd=007005">동아리 연합회 소개</a>
						</li>
						<li>
							<a href="/introView.do?board_cd=007006" >동아리방 배치도 - 준비중</a>
						</li>
						<li>
							<a href="/introView.do?board_cd=007007" >회칙 - 준비중</a>
						</li>
						<li>
							<a href="/introView.do?board_cd=007008" >세칙 - 준비중</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="활동" href="/clubSearch.do?page=1" class="">
				 		<span>활동</span>
				 			
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/clubSearch.do?page=1">조회 및 가입</a>
						</li>
						<li>
							<a href="/createClub.do">동아리 신규 등록</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="우수동아리" href="/topClub.do?">
				 		<span>우수동아리</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/topClub.do?at_cd=002001">공연</a>
						</li>
						<li>
							<a href="/topClub.do?at_cd=002002">비공연</a>
						</li>
					</ul>
				</li>
				
				<li>
				 	<a title="게시판" href="/BoardSearch.do?bdc=007001">
				 		<span>게시판</span>
				 			<span>notice</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/BoardSearch.do?bdc=007001">공지사항</a>
						</li>
						
					</ul>
			   </li>
			</ul>			
		</div>
	</div>
	<nav class="slideMenu">
	<div class="m-util">
		<ul>
			<li><a href="/index.do" title="home 바로가기">Home</a></li>
			<li><a href="#a" title="사이트맵 보기" class="sitemap-btn">Sitemap</a></li>
		<%	if(cuserId == null) { %>
			<li class="login">
				<a href="/login.do" class="login" title="Login">Login</a>
			</li>
		<%	} else { %>
			<li class="profile">
				<a href="/profile.do" class="profile" title="Profile"><%=cusername%>님</a>
			</li>
			<li class="logout">
				<a href="/logout.do" class="logout" title="Logout">Logout</a>
			</li>
		<%	} %>
		</ul>
	</div>
	<!--
		<div class="m-gnb">
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/menu/gnb/mobile/gnb_type01" />
				<c:param name="depth" value="3" />
			</c:import>
		</div>
		-->
	<div class="m-gnb">
		<ul class="dep1 jwxe-menu-ul">
			<li><a href="/introView.do">소개</a>
				<ul class="dep2">
					<li><a href="/introView.do?board_cd=007005">동아리 연합회 소개</a></li>
					<li><a href="/introView.do?board_cd=007006" >동아리방 배치도 - 준비중</a></li>
					<li><a href="/introView.do?board_cd=007007">회칙 - 준비중</a></li>
					<li><a href="/introView.do?board_cd=007008">세칙 - 준비중</a></li>
				</ul></li>
			<li><a href="/createClub.do">활동</a>
				<ul class="dep2">
					<li><a href="/clubSearch.do">조회 및 가입</a></li>
					<li><a href="/createClub.do">동아리 신규 등록</a></li>
				</ul></li>
			<li><a href="/topClub.do">우수 동아리</a>
				<ul class="dep2">
					<li><a href="/topClub.do?at_cd=002001">공연</a></li>
					<li><a href="/topClub.do?at_cd=002002">비공연</a></li>
				</ul></li>
			<li><a href="/BoardSearch.do?bdc=007001">게시판</a>
				<ul class="dep2">
					<li><a href="/BoardSearch.do?bdc=007001">공지사항</a></li>	
				</ul></li>
		</ul>
	</div>
	</nav>
	<a href="#a" class="slide-close"><span class="hide">모바일 메뉴 닫기</span></a>
	<div class="m-gnb-bg">&nbsp;</div>
	<!-- 사이트 맵 -->
	<div class="sitemap-wrap">
		<div class="sitemap-box">
			<!--
			<c:import url="/cms/menu/siteMap.do" charEncoding="utf-8">  
				<c:param name="view" value="/_custom/${clientId}/_common/site-map/site_map" />
			</c:import>
		-->
			<ul>
				<li id="menu_4137" class="depth_1 first"><a
					href="/introView.do" class="depth_1 ">소개</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first"><a
							href="/introView.do?board_cd=007005" class="depth_2 ">동아리 연합회 소개</a></li>
						<li id="menu_4142" class="depth_2 first"><a
							href="/introView.do?board_cd=007006" class="depth_2 ">동아리방 배치도 - 준비중</a></li>
						<li id="menu_4142" class="depth_2 first"><a
							href="/introView.do?board_cd=007007" class="depth_2 ">회칙 - 준비중</a></li>
						<li id="menu_4142" class="depth_2 first"><a
							href="/introView.do?board_cd=007008" class="depth_2 ">세칙 - 준비중</a></li>
					</ul></li>
				<li id="menu_4141" class="depth_1"><a
					href="/clubSearch.do" class="depth_1 ">활동</a>
					<ul class="depth_2">
					<li id="menu_4157" class="depth_2 first"><a
							href="/clubSearch.do" class="depth_2 ">조회 및 가입</a></li>
						<li id="menu_4157" class="depth_2 first"><a
							href="/createClub.do" class="depth_2 ">동아리 신규 등록</a></li>
					</ul></li>
				<li id="menu_4138" class="depth_1"><a
					href="/topClub.do" class="depth_1 ">우수동아리</a>
					<ul class="depth_2">
						<li id="menu_4441" class="depth_2"><a
							href="/topClub.do?at_cd=002001" class="depth_2 ">공연</a></li>
						<li id="menu_4435" class="depth_2"><a
							href="/topClub.do?at_cd=002002" class="depth_2 ">비공연</a></li>
					</ul></li>
				
				<li id="menu_4138" class="depth_1"><a
					href="/BoardSearch.do?bdc=007001" class="depth_1 ">게시판</a>
					<ul class="depth_2">
						<li id="menu_4146" class="depth_2 first"><a
							href="/BoardSearch.do?bdc=007001" class="depth_2 ">공지사항</a></li>
					</ul></li>	
			</ul>
			<a href="#" title="닫기" class="sitemap-close">
				<img src="${pageContext.request.contextPath}/images/board/btn-sitemap-close.png" alt="닫기">
			</a>
		</div>
	</div>
	<!-- //사이트 맵 -->
</body>
</html>