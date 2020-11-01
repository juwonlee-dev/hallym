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
		System.out.println("[clubMemberList.jsp] category:" + category);
		System.out.println("[clubMemberList.jsp] search:" + search);
		
		
	%>
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
				<form method="get" action="clubMemberList.do?&club_id=${club_id}">
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

	<script type="text/javascript">	        
	   
        
        function getPage(data1, data2, data3, data4) {
            var urlpaging = "/clubMemberList.do?";
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
</body>
</html>