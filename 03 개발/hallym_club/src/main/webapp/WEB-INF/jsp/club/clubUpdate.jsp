<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="java.util.ArrayList"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css">

<style>
table.type03 {
	border-collapse: collapse;
	line-height: 1.5;
	border-top: 3px solid #369;
	border-left: 1px solid #ccc;
	font-size: 140%;
	width:100%;
	margin-bottom: 10px;
}

table.type03 th {
	padding: 3px;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type03 td {
	padding: 3px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}
</style>
</head>
<body>

	<%
		request.setCharacterEncoding("UTF-8");

		int club_id = 1;

		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
	%>



	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main">
		<h2>동아리 수정</h2>


		<form method="post" action="clubUpdateAction.do" onsubmit="return check_form();">
			<table class="type03">
				<tr>
					<th>동아리명</th>
					<td style="color: #153d73; font-weight: bold;">
					<input type="hidden" name="club_id" value=<%=club_id%> /> 
						<font color="black" style="margin-right: 100px;">${clubInfo.club_nm}</font>
				</tr>

				<tr>
					<th>목적</th>
					<td colspan="2" height="60px"><textarea
							style="width: 99%; height: 99%; resize: none" name="club_aim">${clubInfo.club_aim}</textarea></td>
				</tr>

				<tr>
					<th>활동</th>
					<td colspan="2" height="60px"><textarea
							style="width: 99%; height: 99%; resize: none" name="club_active">${clubInfo.club_active}</textarea></td>
				</tr>

				<tr>
					<th>동아리 정보</th>
					<td style="text-align: left">
					개설년도<input type="text" name="open_dt" style="font-size: 20px; margin-left: 20px; border: 1px solid #ccc;"
						size="10" maxlength="8" value="${clubInfo.open_dt}">
						동아리방<input type="text" name="club_room" style="font-size: 20px; margin-left: 20px; border :1px solid #ccc;" size="10"
						value="${clubInfo.club_room}">
					</td>
				</tr>

			</table>

			<input type="submit" value="수정" class="manage-btn">
			<input type="reset" value="취소" class="manage-btn" onclick="history.back();">

		</form>
	</div>
	


	<script>
		function check_form() {
			var ck_name = document.getElementById("club_nm").value;

			if (ck_name.trim() == "") {
				alert("동아리 이름을 입력해주세요");
				document.getElementById("club_nm").focus();
				return false;
			}

		}
	</script>
</body>
</html>