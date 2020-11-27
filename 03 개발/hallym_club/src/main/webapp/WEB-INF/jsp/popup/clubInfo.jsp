
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
					<form name="form" method="post" action="topClubAction.do">
						<tr>
							<th style="font-size: 25px; width: 200px;">우수동아리 등록</th>
							<td></td>	
						</tr>
						<tr>
						<td>
							<select id="selectYear" class="b-sel-title" name="year">
								<option class=searchOption value="2019">2019</option>
								<option class=searchOption value="2018">2018</option>
								<option class=searchOption value="2017">2017</option>
							</select>
						</td>
						<td>	
							<input type="hidden" name="club_id" value="${club_id}">
							<input type="submit" value="등록" name="submit" class="manage-btn"
							onclick="return confirm('${club_nm}(${club_id}) 우수 동아리로 등록 하겠습니까?');">
						</td>
						</tr> 
					
					</form>
						
						
			</table>
				
			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">

				<th style="font-size: 25px; width: 200px;">프로필 및 포스터</th>
				

					<form method="post" action="clubPhotoChangeAction.do" enctype="multipart/form-data" >
						<input type="hidden" name="club_id" value="${club_id}">
						
							<tr>
							<th onclick="window.open('upload/club/${club_intro}','new img', 'width=750,height=850')">프로필</th>
							<td><input type="file" name="file1"></td>
							<td><input name="submit" type="submit" value="프로필 삭제"></td>
							</tr>
						
							<tr>
							<th onclick="window.open('upload/club/${club_poster}','new img', 'width=750,height=850')">홍보 포스터</th>
							<td><input type="file" name="file2"></td>
							<td><input name="submit" type="submit" value="포스터 삭제"></td>
							</tr>
						<th><input name="submit" type="submit" value="업로드"></th>
							
							
					</form>
			</table>

			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">

				<th style="font-size: 25px; width: 200px;">동아리원 추가</th>
				<tr>

					<form method="post" action="clubMemberAddAction.do">
						<input type="hidden" name="club_id" value="${club_id}">
						<th style="font-size: 20px; width: 130px;">학번</th>
						<td><input style="width: 99%; height: 99%; resize: none"
							name="student_id">
						
						</td>

						<td>
						<select id="staff" name="staff" style="font-size: 20px">
								<option value="004001">회장</option>
								<option value="004002">부회장</option>
								<option value="004003">총무</option>
								<option value="004004" selected>회원</option>
						</select>
						</td>
						<td><input name="write" type="submit" value="추가"></td>
				</tr>
				</form>
			</table>

			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">
			<th style="font-size: 25px; width: 200px;">${club_nm}</th>
				<tr>
					<th style="font-size: 20px; width: 130px;">이름</th>
					<th style="font-size: 20px; width: 160px;">전공</th>
					<th style="font-size: 20px; width: 50px;">학년</th>
					<th style="font-size: 20px; width: 120px;">학번</th>
					<th style="font-size: 20px; width: 140px;">연락처</th>
					<th style="font-size: 20px; width: 70px;">직위</th>
					<th style="font-size: 20px; width: 95px;">가입일자</th>
				</tr>
				
				<c:forEach items='${clubMemberList}' var="item" varStatus="status">
				<tr>
				<form method="post" action="clubMemberDeleteAction.do">
					<td>${item.name}</td>
					<td>${item.major}</td>
					<td>${item.grade}</td>
					<td>${item.student_id}</td>
					<td>${item.phone_no}</td>
					<td>${item.staff_cd}</td>
					<td>${item.join_dt}</td>
					<td>
						<input name="submit" type="submit" value="삭제" onclick="return confirm('${item.name} 회원을 삭제하시겠습니까?');">
					</td>
					
					<input type="hidden" name="club_id" value="${club_id}">
					<input type="hidden" name="student_id" value="${item.student_id}">
				</form>
				</tr>
				</c:forEach>
			</table>
		</div>
	</div>


</body>
</html>