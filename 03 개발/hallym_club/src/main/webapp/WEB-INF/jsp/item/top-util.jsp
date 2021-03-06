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
		String auth_code = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = ((UserVO) session.getAttribute("userVO"));
			cuserId = cuserVO.getId();
			cusername = cuserVO.getName();
			auth_code = (String) session.getAttribute("auth_code");
		}
	%>
	<div class="top-header-box">
		<div>
			<a href="http://www.hallym.ac.kr/" target="_blank" title="한림대학교 사이트 새창열림">한림대학교</a>
		</div>
		<ul>
			<li><a href="/index.do" title="HOME 바로가기">HOME</a></li>
			<li><a href="#a" title="사이트맵 보기" class="sitemap-btn">사이트맵</a></li>
			
	<%	if(cuserId == null) { %>
			<li class="login">
				<a href="/login.do" title="로그인 바로가기">로그인</a>
			</li>
	<%	} else { %>
			<li class="profile">
				<a href="" title="마이페이지 바로가기"  style="pointer-events: none;"><%=cusername%>님</a>
			</li>
			<li class="profile">
				<a href="/profile.do" title="마이페이지 바로가기">마이페이지</a>
			</li>
			<% if(auth_code.equals("010001") || auth_code.equals("010002") || auth_code.equals("010003")) { %>
				<li class="admin">
				<a href="/clubManagement.do" title="관리자페이지 바로가기">관리자페이지</a>
			</li>
			<%} %>
			<li class="logout">
				<a href="/logout.do" title="로그아웃 바로가기">로그아웃</a>
			</li>
	<%	} %>
		</ul>
	</div>
	
</body>
</html>