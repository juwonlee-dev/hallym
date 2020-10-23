<%@page import="hallym.club.clubmember.vo.ClubMemberVO"%>
<%@page import="java.util.ArrayList"%>
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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/table.css">

<style>
html, body {
	width: 100%;
	height: 100%;
}

table.type04 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-left: 1px solid #ccc;
	border-top: 3px solid #369;
	margin: auto;
	text-align: center;
	width: 100%;
	font-size: 13px;
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
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type02 {
	border-collapse: collapse;
	text-align: center;
	line-height: 1.5;
	border-right: 1px solid #ccc;
	border-top: 3px solid #369;
	margin: 5px 3px;
}

table.type02 th {
	padding: 3px;
	font-weight: bold;
	vertical-align: top;
	color: #153d73;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

table.type02 td {
	font-size: 13px;
	padding: 3px;
	vertical-align: top;
	border-right: 1px solid #ccc;
	border-bottom: 1px solid #ccc;
}

#left_side {
	float: left;
	margin: 5px;
	margin-left: 3%;
	padding: 10px;
	min-height: 60%;
	width: 15.5%;
	margin-top: 7%;
}

.mainLeft {
	border: 1px solid #ccc;
	float: left;
	height: 300px;
	width: 100%;
	overflow: auto;
}

.mainRight {
	border: 0px;
	float: left;
	height: 450px;
	width: 100%;
	overflow: hidden;
}

/* .type03 a{
	text-decoration: none;
} */
a:link {
	color: black;
	text-decoration: none;
}

a:active {
	color: black;
	text-decoration: none;
}

a:visited {
	color: black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: underline;
}
*
/
</style>
</head>
<%
		
		request.setCharacterEncoding("UTF-8");
		
		int club_id = 1;
		int rowIndex = 0;
		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
		if (request.getParameter("rowIndex") != null) {
			rowIndex = Integer.parseInt(request.getParameter("rowIndex"));
		}
		System.err.println("[clubManage.jsp] rowIndex: " + rowIndex);
		ArrayList<ClubMemberVO> member_list = null;
		if(session.getAttribute("memberList") != null) {
			member_list = (ArrayList<ClubMemberVO>) session.getAttribute("memberList");
		} 
		System.err.println("[clubManage.jsp] memberList: " + member_list);
	%>
<body>

	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div>
	<div class="main">
		<div class="mainLeft">
			<input type="hidden" name="rowIndex" id="rowIndex"
				value="${rowIndex}">			
			
			<table class="type04" border="1">
				<tr>
					<th style="font-size: 15px; width: 500px;">전공</th>
					<th style="font-size: 15px; width: 500px;">학번</th>
					<th style="font-size: 15px; width: 500px;">이름</th>
				</tr>
				<c:choose>
					<c:when test="${memberListCount lt 1}">
				<tr>
					<th colspan="3">동아리 가입 신청이 없습니다.</th>
				</tr>
					</c:when>
					<c:otherwise>
				
				 <c:forEach items='${memberList}' var="item" varStatus="status">
			
				
				<tr onclick="getIndex(this);" id="club_table"
					style="cursor: pointer">
					<td>${item.major}</td>
					<td>${item.student_id}</td>
					<td>${item.name}</td>
				</tr>
				</c:forEach>
			</table>
			
		</div>

		<div class="mainRight">

			<form method="post" action="clubManageAction.do">
				<input type="hidden" name="club_id" id="club_id"
					value="${club_id}">
				<table class="type02">
					
					<tr>
						<th rowspan="6" width="20%"><br> <br> <br>인 적<br>사
							항</th>
						<td width="20%">학과<font>*</font></td>
						<td width="20%"><input type="text" name="MAJOR" id="MAJOR"
							value=<%=member_list.get(rowIndex).getMajor()%>
							readonly="readonly"></td>
						<td width="20%">학년<font>*</font></td>
						<td width="20%"><input type="text" name="GRADE" id="GRADE"
							value=<%=member_list.get(rowIndex).getGrade()%>
							readonly="readonly"></td>
					</tr>
					<tr>
						<td>학번<font>*</font></td>
						<td><input type="text" name="student_id" readonly="readonly"
							value=<%=member_list.get(rowIndex).getStudent_id()%>></td>

						<td>성명<font>*</font></td>
						<td><input type="text" style="width: 80%" name="NM" id="NM"
							value=<%=member_list.get(rowIndex).getName()%> readonly="readonly">
							
					</tr>
					<tr>
						
					</tr>
					<tr>
						<td>전화번호<font>*</font></td>
						<td colspan="3"><input type="text" style="width: 99%"
							name="PHONE_NO" id="PHONE_NO" readonly="readonly"
							value=<%=member_list.get(rowIndex).getPhone_no()%>></td>
					</tr>
					<tr>
						

					</tr>
					<tr>
						<td>E-mail</td>
						<td colspan="3"><input type="text" style="width: 99%"
							name="EMAIL" readonly="readonly"
							value=<%=member_list.get(rowIndex).getEmail()%>></td>
					</tr>

					<tr>
						<th><br>차 후<br>활동계획</th>
						<td colspan="4" height="100px"><textarea
								style="width: 99%; height: 99%; resize: none"
								readonly="readonly" name="plan"><%=member_list.get(rowIndex).getPlan()%> </textarea></td>
					</tr>

					<tr>
						<th><br>바라는 점</th>
						<td colspan="4" height="80px"><textarea
								style="width: 99%; height: 99%; resize: none"
								readonly="readonly" name="hope"><%=member_list.get(rowIndex).getHope()%></textarea></td>
					</tr>
					

				</table>
				
				<input type="submit" value="승인" name="submit" class="manage-btn" onclick="return confirm('승인 하시겠습니까?');">
				<input type="submit" value="거부" name="submit" class="manage-btn" onclick="return confirm('거부 하시겠습니까?');">
					</c:otherwise>
				</c:choose>
			</form>
			
				
				
		</div>
		
	</div>
	
	
	
	</div>
	
	<script>
	
	var a = document.getElementById("club_table").parentNode;
	var idx = parseInt(document.getElementById("rowIndex").value) + 1;
	var club_id = <%=club_id%>;
	var trs = a.getElementsByTagName('tr');

	for ( var i = 0; i < trs.length; i++ ) {
			trs[i].style.backgroundColor = "white";
			trs[idx].style.backgroundColor = "#dcdcdc";
		}

	function club_post(){
		var id = document.getElementById("club_id").value;
		location.href="clubManage.do?club_id="+id;	//선택 값이 바뀌면 첫 행부터
	}

	function getIndex(x){
		var idx = x.rowIndex-1;
		document.getElementById("rowIndex").value = x.rowIndex-1;
		location.href="clubManage.do?club_id="+club_id+"&rowIndex=" + idx;
	}
	</script>

	
</body>
</html>