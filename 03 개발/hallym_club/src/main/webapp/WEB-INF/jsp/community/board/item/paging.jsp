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
</head>
<body>
	<div class="b-paging01 type01">
     	<div class="b-paging-wrap">
			<ul>
			<c:if test="${totalPage > 1 and currPage ne prevPage}">
				<li class="first pager">
					<a href="javascript:getPage(1,'${board_cd}','${condition}', '${club_id}', '${opt}');" title="첫 페이지로 이동하기">
						<span class="hide">첫 페이지로 이동하기</span>
					</a>
				</li>
				<li class="prev pager">
					<a href="javascript:getPage(${prevPage},'${board_cd}','${condition}', '${club_id}', '${opt}');" title="이전 페이지로 이동하기">
						<span class="hide">이전 페이지로 이동하기</span>
					</a>
				</li>
			</c:if>
			<c:forEach var="i" begin="1" end="${totalPage}">
				<li>
					<c:choose>
	                      	<c:when test="${i eq currPage}">
	                      		<a class="active ver2" href="javascript:getPage(${i},'${board_cd}','${condition}', '${club_id}', '${opt}');">${i}</a>
	                      	</c:when>
	                      	<c:otherwise>
	                      		<a class href="javascript:getPage(${i},'${board_cd}','${condition}', '${club_id}', '${opt}');">${i}</a>
	                      	</c:otherwise>
	                      </c:choose>
	                     </li>
			</c:forEach>
			<c:if test="${totalPage > 1 and currPage ne nextPage}">
				<li class="next pager">
					<a href="javascript:getPage(${nextPage},'${board_cd}','${condition}', '${club_id}', '${opt}');" title="다음 페이지로 이동하기">
						<span class="hide">다음 페이지로 이동하기</span>
					</a>
				</li>
				<li class="last pager">
					<a href="javascript:getPage(${totalPage},'${board_cd}','${condition}', '${club_id}', '${opt}');" title="마지막 페이지로 이동하기">
						<span class="hide">마지막 페이지로 이동하기</span>
					</a>
				</li>
			</c:if>
			</ul>
		</div>
	</div>
</body>
</html>