<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=1200">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="/common/css/default.css?after">

</head>

<body>

	<div id="wrap">
		<%-- <div id="header">
			<jsp:include page="/WEB-INF/jsp/item/header2.jsp"></jsp:include>
		</div>
 --%>
		<hr>
		<div id="visual">
			<img src="image/visual.jpg" alt="">
		</div>

		<hr>

		<div id="content">
			<div class="latest">
				<div class="notice">
					<h2>공지사항</h2>
					<ul>
						<c:forEach items='${boardList}' var="item" varStatus="status">
						<li>
							<c:if test='${item.board_fix eq "Y" }'>
								<img src="image/ic_notice.gif" border="0" valign="middle" alt="고정글">
							</c:if>
							
							<a href="view.jsp?BOARD_NO=${item.board_no}&club_id=1&board_cd=007001">${item.title}</a>
							<span class="date">
							<%-- <fmt:formatDate value="${item.input_date}" pattern="yyyy-MM-dd" /> --%>
							${item.input_date}
							</span></li>
					
						</c:forEach>
					</ul>
					<a href="board.jsp" class="more">더보기</a>
				</div>
				
				<div class="banner">
					<h2>배너</h2>
					<p>
						<img src="image/banner.gif" alt="지금 로그인하고 다양한 동아리를 만나세요!">
					</p>
				</div>
				
				
			</div> 

			<div class="club">
				<div class="intro">
					<h2>동아리</h2>
					
					<ul>
						<c:forEach items='${clubList}' var="item" varStatus="status">
						<li>
							<div class="thm">
								<img class="logo"
									src="upload/club/${item.intro_save_file_nm}"
									onerror="this.src='image/error.png'" alt="">
							</div>
							
							
							<div class="tit">
							<c:choose>
								<c:when test="${userVO eq null}">
									<a href="club_search.do?search=${item.club_nm}">${item.club_nm}</a>
								</c:when>
							    <c:otherwise>
							    
									<a href="club_intro.jsp?club_id=${item.club_id}">${item.club_nm}</a>
								
								<%-- 	 star	<c:when test="${ }">
									
									</c:when> --%>
								</c:otherwise>
							</c:choose>
							</div>
							<div class="note">
							<c:choose>
								<c:when test="${userVO eq null}">
								${item.club_aim}
								</c:when>
							</c:choose> 
							<%-- staff_cd	<c:otherwise>
								${item }
								</c:otherwise> --%>
							</div>
							<div class="tag">
								#${item.gb_nm}
								#${item.at_nm}</div>
						</li>
						</c:forEach>
					
					</ul>
					
					
				</div>
			</div>

		</div>
	<hr>
		<%-- <div id="footer">
			<jsp:include page="/WEB-INF/jsp/item/footer2.jsp"></jsp:include>
		</div> --%>
	<hr>
	</div>
</body>
</html>