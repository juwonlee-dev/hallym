

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<%@page import="java.net.URLEncoder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.io.PrintWriter"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리</title>


<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/table.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/page.css">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/css/jquery.tagit.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/css/tagit.ui-zendesk.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">

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
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		
		int club_id = -1;

		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
		
	
		String category = "name";
		String search = "";

		if (request.getParameter("category") != null) {
			category = request.getParameter("category");
		}
		if (request.getParameter("search") != null) {
			search = request.getParameter("search");
		}
		System.out.println("[clubManageList.jsp] category:" + category);
		System.out.println("[clubManageList.jsp] search:" + search);
		
		
	%>

	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main">
		<div class="mainLeft" style="height: 700px;">

		
				

			<table id="myTable" class="type04" border="1"
				style="table-layout: fixed;">
				<tr>
					<th style="font-size: 20px; width: 160px;">전공</th>
					<th style="font-size: 20px; width: 50px;">학년</th>
					<th style="font-size: 20px; width: 120px;">학번</th>
					<th style="font-size: 20px; width: 130px;">이름</th>
					<th style="font-size: 20px; width: 140px;">연락처</th>
					<th style="font-size: 20px; width: 70px;">임원</th>
					<th style="font-size: 20px; width: 95px;">가입일자</th>
					<th style="font-size: 20px; width: 125px;">관리</th>
				</tr>
				<c:forEach items='${memberList}' var="item" varStatus="status">
			<form name="form" method="post" action="clubManageAction.do">
				<tr>
						<td>${item.major}</td>
						<td>${item.grade}</td>
						<td>${item.student_id}</td>
						<td>${item.name}</td>
						<td>${item.phone_no}</td>
						<td>${item.staff_cd}</td>
						<td>${item.join_dt}</td>
						<input type="hidden" name="student_id"
							value="${item.student_id}">
						<input type="hidden" name="club_id" value="${item.club_id}">
						<input type="hidden" name="join_cd" value="${item.join_cd}">
						<input type="hidden" name="staff_cd" value="${item.staff_cd}">

						<td><button value="${item.student_id}" name="update"
								class="manage-btn" onclick="popup(this.form);">수정</button> <input
							type="submit" value="제명" name="submit" class="manage-btn"
							onclick="return confirm('${item.name}(${item.student_id}) 제명하시겠습니까?');"></td>
					</tr>
				</form>
				</c:forEach>

			</table>

			<div class="b-paging01 type03">
                   <div class="b-paging01 type01">
                   	<div class="b-paging-wrap">
					<ul>
					<c:if test="${totalPage > 1 and currPage ne prevPage}">
					<li class="first pager">
						<a href="javascript:getPage(1,'${category}','${search}', '${club_id}');" title="첫 페이지로 이동하기">
							<span class="hide">첫 페이지로 이동하기</span>
						</a>
					</li>
					<li class="prev pager">
						<a href="javascript:getPage(${prevPage},'${category}','${search}','${club_id}');" title="이전 페이지로 이동하기">
							<span class="hide">이전 페이지로 이동하기</span>
						</a>
					</li>
					</c:if>
					<c:forEach var="i" begin="1" end="${totalPage}">
					<li>
						<c:choose>
                        	<c:when test="${i eq currPage}">
                        		<a class="active" href="javascript:getPage(${i},'${category}','${search}','${club_id}');">${i}</a>
                        	</c:when>
                        	<c:otherwise>
                        		<a class href="javascript:getPage(${i},'${category}','${search}','${club_id}');">${i}</a>
                        	</c:otherwise>
                        </c:choose>
                       </li>
					</c:forEach>
					<c:if test="${totalPage > 1 and currPage ne nextPage}">
					<li class="next pager">
						<a href="javascript:getPage(${nextPage},'${category}','${search}','${club_id}');" title="다음 페이지로 이동하기">
							<span class="hide">다음 페이지로 이동하기</span>
						</a>
					</li>
					<li class="last pager">
						<a href="javascript:getPage(${totalPage},'${category}','${search}','${club_id}');" title="마지막 페이지로 이동하기">
							<span class="hide">마지막 페이지로 이동하기</span>
						</a>
					</li>
					</c:if>
					</ul>
					</div>
                	</div>
            </div>

			<div class="category">
				<form method="get" action="clubManageList.do?&club_id=${club_id}">
					<input type="hidden" name="club_id" value="${club_id}">
					<ul>
						<li><select name="category" id="category">
								<option value="name"
									<%if (category.equals("name"))
				out.println("selected");%>>이름</option>
								<option value="major"
									<%if (category.equals("major"))
				out.println("selected");%>>전공</option>
								<option value="student_id"
									<%if (category.equals("student_id"))
				out.println("selected");%>>학번</option>
						</select></li>
						<li><input type="text" id="search" name="search" size="30"
							value="<%=search%>" onfocus="this.select()"></li>
						<li><button type="submit" class="category-btn">검색</button></li>
					</ul>
				</form>
			</div>
		</div>
	</div>

	<script type="text/javascript">	        
	   
        
        function getPage(data1, data2, data3, data4) {
            var urlpaging = "/clubManageList.do?";
        	var page = data1; /* 페이지 번호 */
        	var category = document.getElementById("category").value;
        	var search = data3; /* search */
        	var club_id = data4 /* club_id */
        	var link = urlpaging + "page=" + page + "&club_id=" + club_id + "&category=" + category  
        	if(data3 != null){
        		link += "&search=" + search;
        	}
        	location.href = link; 
        }
	</script>
	<script>
		function popup(frm) {
			var url = "clubMemberInfo.do";
			var title = "pop";
			var status = "toolbar=no,directories=no,scrollbars=no,resizable=no,status=no,menubar=no,width=800, height=500, top=50,left=20";
			window.open("", title, status); //window.open(url,title,status); window.open 함수에 url을 앞에와 같이
			//인수로  넣어도 동작에는 지장이 없으나 form.action에서 적용하므로 생략
			//가능합니다.
			frm.target = title; //form.target 이 부분이 빠지면 form값 전송이 되지 않습니다. 
			frm.action = url; //form.action 이 부분이 빠지면 action값을 찾지 못해서 제대로 된 팝업이 뜨질 않습니다.
			frm.method = "post";
			frm.submit();
		}
	</script>


</body>
</html>