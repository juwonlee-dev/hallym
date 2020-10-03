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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/table.css">
</head>
<body>

	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main" style="overflow: auto; max-height: 550px;">
		<table id="table">
			<thead>
				<tr>
					<th scope="col" style="width: 20%;">이름</th>
					<th scope="col" style="width: 20%;">직위</th>
					<th scope="col" style="width: 20%;">전공</th>
					<th scope="col" style="width: 22%;">전화번호</th>
				</tr>
			</thead>
			<tbody>
			  <c:forEach items='${memberList}' var="item" varStatus="status">
				
				<tr>
					<td><strong>${item.getName()}</strong></td>
					<td>${item.getStaff_cd()} </td>
					<td>${item.getMajor()}</td>
					<td>${item.getPhone_no()}</td>
				</tr>
				
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>