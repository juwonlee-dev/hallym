
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>club_info</title>
</head>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/page.css">
<style>
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
	/* width: 100%; */
	overflow: auto;
}

</style>

<body>
	<div class="main">
		<div class="mainLeft">
			<table id="myTable" class="type04" border="1"
					style="table-layout: fixed;">
					<th style="font-size: 25px; width: 200px;">우수 동아리 순위</th>
					
						<tr>
						<th>현재 순위</th>
						<td>${clubRank}</td>
						</tr>
	
					<form method="post" action="topClubRankAction.do" >
							<input type="hidden" name="club_id" value="${club_id}">
							<input type="hidden" name="year" value="${year}">
							<tr>
							<th>순위 수정</th>
							<td><input style="width: 99%; height: 99%; resize: none" name="rank"></td>
							<td><input name="submit" type="submit" value="수정"></td>
							</tr>
					</form>
			</table>
		</div>
	</div>
</body>
</html>