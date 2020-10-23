<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="hallym.club.clubmember.vo.ClubMemberVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 관리</title>
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

ul {
	padding-left: 10px;
}

ul li {
	display: inline;
	font-size: 20px;
	margin-right: 100px;
}
</style>
</head>

<body>
	<p>isPresident: ${isPresident} </p>
	<%
		request.setCharacterEncoding("UTF-8");

		UserVO userVO = null;
		String userId = null;
		String join_cd = null;
		String staff_cd = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
		} else {
			out.println("<script>");
			out.print("alert('로그인이 필요합니다.');");
			out.print("window.close();");
			out.println("</script>");
		}

		

		System.out.println("[memberInfo.jsp] userId: " + userId);
		String student_id = request.getParameter("student_id");
		int club_id = Integer.parseInt(request.getParameter("club_id"));
		
		
		if(session.getAttribute("join_cd") != null) {
			join_cd = (String) session.getAttribute("join_cd");
		}
		if(session.getAttribute("staff_cd") != null) {
			staff_cd = (String) session.getAttribute("staff_cd");
		}
		
	   	
	%>

	<ul>
		<form method="post" action="clubStaffUpdateAction.do">
			<input type="hidden" name="club_id" value=<%=club_id%>> 
			<input type="hidden" name="student_id"	value="${memberInfo.student_id}">
			<li>${memberInfo.name} (${memberInfo.student_id})</li>
			<li style="float: right;">직책&nbsp; 
			<select id="staff"
				name="staff" style="font-size: 20px"
				onchange="staff_change(this.form);">
					<option value="004004"
						
						
						<%if (staff_cd.equals("회원"))
				out.println("selected");%>>회원</option>
					<option value="004002"
						<%if (staff_cd.equals("부회장"))
				out.println("selected");%>>부회장</option>
					<option value="004003"
						<%if (staff_cd.equals("총무"))
				out.println("selected");%>>총무</option>
			</select> 
			<input class="button" type="submit" name="submit" value="직위변경"
			 onclick="return confirm('직위를 변경하시겠습니까?');"
				style="margin-left: 50px;" />
			<c:if test="${isPresident eq true}">
			<input class="button" type="submit" name="submit" value="회장위임"
			 onclick="return confirm('회장을 위임하시겠습니까?');"
				style="margin-left: 50px;" />
			</c:if>
			</li>
			
		</form>

	</ul>

	<table class="type03">
		<tr>
			<th rowspan="6" width="20%"><br> <br> <br>인 적<br>사
				항</th>
			<td width="20%">학과<font>*</font></td>
			<td width="20%"><input type="text" name="grade" id="major"
				readonly="readonly" value="${memberInfo.major}"></td>
			<td width="20%">학년<font>*</font></td>
			<td width="20%"><input type="text" name="grade" id="grade"
				readonly="readonly" value="${memberInfo.grade}"></td>
		</tr>
		<tr>
			<td>학번<font>*</font></td>
			<td><input type="text" name="student_id" readonly="readonly"
				value="${memberInfo.student_id}"></td>

			<td>성명<font>*</font></td>
			<td><input type="text" style="width: 99%" name="name" id="name"
				readonly="readonly" value="${memberInfo.name}"> </td>
		</tr>
		
		<tr>
			<td>전화번호<font>*</font></td>
			<td colspan="3"><input type="text" style="width: 99%"
				name="phone_no" id="phone_no" readonly="readonly"
				value="${memberInfo.phone_no}"></td>
		</tr>
		<tr>
			
		</tr>
		<tr>
			<td>E-mail</td>
			<td colspan="3"><input type="text" style="width: 99%"
				name="email" readonly="readonly"
				value="${memberInfo.email}"></td>
		</tr>

		<tr>
			<th><br>차 후<br>활동계획</th>
			<td colspan="4" height="100px"><textarea
					style="width: 99%; height: 99%; resize: none" name="plan"
					readonly="readonly">${memberInfo.plan}</textarea></td>
		</tr>

		<tr>
			<th><br>바라는 점</th>
			<td colspan="4" height="80px"><textarea
					style="width: 99%; height: 99%; resize: none" name="hope"
					readonly="readonly">${memberInfo.hope}</textarea></td>
		</tr>

	</table>

	<!-- <script>
		function staff_change(e) {
			var name = document.getElementById("name").value;
			var staff = document.getElementById("staff").value;

			if (staff == "004001")
				staff = "회장";
			else if (staff == "004002")
				staff = "부회장";
			else if (staff == "004003")
				staff = "총무";
			else
				staff = "회원";

			if (confirm(name + "을(를) " + staff + "(으)로 변경 하시겠습니까?") == true) { //확인
				e.submit();

			} else { //취소
				return;
			}
		}
	</script> -->
</body>
</html>