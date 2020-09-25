
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
<title>한림대학교 동아리 가입 양식</title>

<style>
table.type03 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-top: 1px solid #ccc;
	border-left: 5px solid #369;
	margin: 5px 3px;
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
	top: 72%;
	left: 20%;
	text-align: center;
}

.apply {
	position: absolute;
	width: 36%;
	top: 78%;
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
<%
	request.setCharacterEncoding("UTF-8");
	String userId = null;
	if (session.getAttribute("userVO") != null) {
		UserVO  userVO = ((UserVO) session.getAttribute("userVO"));
		userId = userVO.getId();
	}
%>
<body>
	<form method="post" action="clubSignUpAction.do" onsubmit="return check_form();">
		<h2>${club_nm}
			동아리 가입 신청서
		</h2>
		<input type="text" name="club_id" value="${club_id}" style="display: none">
		<table class="type03">
			<tr>
				<th rowspan="6" width="20%"><br> <br> <br>인 적<br>사 항</th>
				<td width="20%">학과<font>*</font></td>
				<td width="20%"><input type="text" name="major" id="major"
					readonly="readonly" value="${userVO.getMajor()}"></td>
				<td width="20%">학년<font>*</font></td>
				<td width="20%"><input type="text" name="grade" id="grade"
					readonly="readonly" value="${userVO.getGrade()}"></td>
			</tr>
			<tr>
				<td>학번<font>*</font></td>
				<td><input type="text" name="user_id" readonly="readonly"
					value="${userVO.getId()}"></td>
				<td>성명<font>*</font></td>
				<td><input type="text" style="width: 100%" name="name" id="name"
					value="${userVO.getName()}" readonly="readonly"></td>
				
			</tr>
			
			<tr>
				<td>전화번호<font>*</font></td>
				<td colspan="3"><input type="text" name="phone_no"
					id="phone_no" style="width: 99%" readonly="readonly"
					value="${userVO.getPhoneNumber()}"></td>
			</tr>
		
			<tr>
				<td>E-mail</td>
				<td colspan="3"><input type="text" style="width: 99%"
					name="email" readonly="readonly" value="${userVO.getE_mail()}"></td>
			</tr>

			<tr>
				<th><br>차 후<br>활동계획 <font>*</font></th>
				<td colspan="4" height="100px"><textarea
						style="width: 99%; height: 99%; resize: none" name="plan" id="plan"></textarea></td>
			</tr>

			<tr>
				<th><br>바라는 점</th>
				<td colspan="4" height="80px"><textarea
						style="width: 99%; height: 99%; resize: none" name="hope"></textarea></td>
			</tr>
		</table>

		<div class="bottom">다음과 같은 개인정보를 해당 신청한 동아리 회장이 볼 수 있습니다. 이를 동의하며 위의 기재한 내용이 틀림없음을 확인하며 가입을 신청합니다.</div>

		<div class="apply">
			신청자(학번)<font>*</font> ( <input type="text" style="width: 30%;"
				id="apply"> ) <input type="submit" class="button"
				value="제출 하기">
		</div>

	</form>
	
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
	<script>
		function check_form() {
			var ck_major = document.getElementById("major").value;
			var ck_grade = document.getElementById("grade").value;
			var ck_nm = document.getElementById("name").value;
			//var ck_gender = document.getElementById("GENDER").value;
			var ck_phone = document.getElementById("phone_no").value;
			var ck_apply = document.getElementById("apply").value;
			var ck_plan = document.getElementById("plan").value

			var exp = /^[0-9]{1}$/; //숫자만, 글자수 1
			var exp1 = /^[0-9]{9,13}$/; //숫자만, 전화번호 검증
			var exp2 = /^[0-9]{8}$/; //숫자만, 글자수8

			if (ck_major.trim() == "") {
				alert("학과를 입력해주세요");
				document.getElementById("MAJOR").focus();
				return false;
			}
			if (!ck_grade.match(exp)) {
				alert("학년은 숫자 1글자로 입력해주세요.");
				document.getElementById("GRADE").focus();
				return false;
			}
			if (ck_nm.trim() == "") {
				alert("이름을 입력해주세요");
				document.getElementById("NM").focus();
				return false;
			}
			
			if (ck_phone.trim() == "") {
				alert("전화번호를 입력해주세요.");
				document.getElementById("PHONE_NO").focus();
				return false;
			}
			
			if (ck_plan.trim() == "") {
				alert("차후 활동계획을 입력해주세요");
				document.getElementById("plan").focus();
				return false;
			}
			if (ck_apply.trim() == "") {
				alert("서명해주세요.");
				document.getElementById("apply").focus();
				return false;
			}
			if (ck_apply !=	<%=userId%>) {
				alert("학번을 정확하게 서명해주세요.");
				document.getElementById("apply").focus();
				return false;
			}
		

		}
	</script>


</body>
</html>