<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css">

<style>
table.type03 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 5px solid #369;
	margin-top: 30px;
}

table.type03 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: top;
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

.bottom {
	position: absolute;
	width: 60%;
	top: 55%;
	left: 20%;
	text-align: center;
}

.apply {
	position: absolute;
	width: 36%;
	top: 62%;
	left: 64%;
}

font {
	color: red;
}

.button {
	width: 80px;
	background-color: #046BB9;
	border: none;
	color: #fff;
	padding: 5px 0;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 15px;
	border-radius: 10px;
	cursor: pointer;
}
</style>
</head>
<body>

	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main">
		<form method="post" action="clubMyInfoAction.do">
			<input type="hidden" name="club_id" value="${club_id}">
			<h2>
				<input type="text" name="club_nm" value="${club_nm}"
					style="border: none; Outline: none; font-size: 20pt; text-align: center;"
					readonly> 동아리 가입 정보 수정
			</h2>
			<table class="type03">
				<tr>
					<th rowspan="6" width="20%"><br> <br> <br>인 적<br>사
						항</th>
					<td width="20%">학과<font>*</font></td>
					<td width="20%"><input type="text" name="major"
						value="${userVO.major}"readOnly></td>
					<td width="20%">학년<font>*</font></td>
					<td width="20%"><input type="text" name="grade"
						value="${userVO.grade}" readOnly></td>
				</tr>
				<tr>
					<td>학번<font>*</font></td>
					<td><input type="text" name="student_id" value="${userVO.id}"
						readOnly></td>
					<td>성명<font>*</font></td>
					<td><input type="text" style="width: 62%" name="name"
						value="${userVO.name}"readOnly></td>
				</tr>
				<tr>
					<td>전화번호<font>*</font></td>
					<td colspan="3"><input type="text" style="width: 99%"
						name="phone_no" 
						value="${userVO.phoneNumber}" readOnly></td>
				</tr>
				
				<tr>
					<td>E-mail</td>
					<td colspan="3"><input type="text" style="width: 99%"
						name="email" value="${userVO.e_mail}"readOnly></td>
				</tr>

				<tr>
					<th><br>차 후<br>활동계획</th>
					<td colspan="4" height="100px"><textarea
							style="width: 99%; height: 99%; resize: none" name="plan">${plan}</textarea></td>
				</tr>

				<tr>
					<th><br>바라는 점</th>
					<td colspan="4" height="80px"><textarea
							style="width: 99%; height: 99%; resize: none" name="hope">${hope}</textarea></td>
				</tr>

			</table>

			<div class="bottom">위의 기재한 내용이 틀림없음을 확인하며, 나의 정보를 수정 하겠습니다.</div>

			<div class="apply">
				<input type="submit" class="button" value="수정하기">
			</div>
		</form>
	</div>

</body>
</html>