<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=1200">

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css?after">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/table.css?after">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/page.css?after">

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
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
<title>한림대학교 동아리</title>
</head>
<body>


	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main">
		<ul style="list-style: none;">
			<li style="font-size: 25px; font-weight: bold; font-align: center;">${headTitle}</li>
		</ul>

		<div id="list">
			<div class="row">

				<table class="table">

					<thead>
						<tr>
						<c:choose>
							<c:when test='${board_cd eq "007004"}'>
							<th style="width: 70%;">제목</th>
							<th style="width: 30%;">비고</th>
							</c:when>
							
							<c:otherwise>
							<th style="width: 100px;">글 번호</th>
							<th style="width: 500px;">제목</th>
							<th style="width: 100px;">분류</th>
							<th style="width: 100px;">작성자</th>
							<th style="width: 100px;">작성일</th>
							<th style="width: 100px;">조회수</th>
							</c:otherwise>
						</c:choose>
						</tr>
					</thead>
					<tbody>
						<c:forEach items='${clubBoardList}' var="item" varStatus="status">
						<tr>
							<td>${item.getBoard_no()}</td>
							<td><a
								href="clubBoardReadForm.do?board_no=${item.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}">
									${item.getTitle()}</a></td>

							<td style="text-align: center;">${headTitle}</td>
							<td style="text-align: center;">${item.getInput_id()}</td>
							<td style="text-align: center;">${item.getInput_date().substring(0, 10)}</td>
							<td style="text-align: center;">${item.getOpen_cnt()}</td>
						</tr>
						</c:forEach>
					</tbody>
				</table>

				<c:choose>
					<c:when test='${board_cd eq "007002"}'>
						<a class="btn"
						href="clubBoardWriteForm.do?club_id=${club_id}&board_cd=${board_cd}">글쓰기</a>
					</c:when>
					
					<c:otherwise>
						<c:if test="${isStaff eq true }">
						<a class="btn"
							href="clubBoardWriteForm.do?club_id=${club_id}&board_cd=${board_cd}">글쓰기</a>
						</c:if>
					</c:otherwise>
				</c:choose>
				
			<div class="b-paging01 type03">
                   <div class="b-paging01 type01">
                   	<div class="b-paging-wrap">
					<ul>
					<c:if test="${totalPage > 1 and currPage ne prevPage}">
					<li class="first pager">
						<a href="javascript:getPage(1,'${board_cd}','${condition}', '${club_id}');" title="첫 페이지로 이동하기">
							<span class="hide">첫 페이지로 이동하기</span>
						</a>
					</li>
					<li class="prev pager">
						<a href="javascript:getPage(${prevPage},'${board_cd}','${condition}','${club_id}');" title="이전 페이지로 이동하기">
							<span class="hide">이전 페이지로 이동하기</span>
						</a>
					</li>
					</c:if>
					<c:forEach var="i" begin="1" end="${totalPage}">
					<li>
						<c:choose>
                        	<c:when test="${i eq currPage}">
                        		<a class="active" href="javascript:getPage(${i},'${board_cd}','${condition}','${club_id}');">${i}</a>
                        	</c:when>
                        	<c:otherwise>
                        		<a class href="javascript:getPage(${i},'${board_cd}','${condition}','${club_id}');">${i}</a>
                        	</c:otherwise>
                        </c:choose>
                       </li>
					</c:forEach>
					<c:if test="${totalPage > 1 and currPage ne nextPage}">
					<li class="next pager">
						<a href="javascript:getPage(${nextPage},'${board_cd}','${condition}','${club_id}');" title="다음 페이지로 이동하기">
							<span class="hide">다음 페이지로 이동하기</span>
						</a>
					</li>
					<li class="last pager">
						<a href="javascript:getPage(${totalPage},'${board_cd}','${condition}','${club_id}');" title="마지막 페이지로 이동하기">
							<span class="hide">마지막 페이지로 이동하기</span>
						</a>
					</li>
					</c:if>
					</ul>
					</div>
                	</div>
            	</div>
			</div>
		</div>
	<%-- 	<div class="category">
			<form method="get" action="clubBoardList.do">
				<input type="hidden" value="${board_cd}" name="board_cd"> <input
					type="hidden" value="${club_id}" name="club_id">
				<ul>
					<li><select><option value="">제목</option></select></li>
					<li><input type="text" size="20" name="condition"
						value="${condition}"> <input type="submit" value="검색"
						class="category-btn"></li>
				</ul>
			</form>
		</div> --%>
	</div>
	
	<script type="text/javascript">	        
	    function writeForm(){
	            location.href="/clubBoardWriteForm.do";   
	    }
        
        function getPage(data1, data2, data3, data4) {
            var urlpaging = "/clubBoardList.do?";
        	var page = data1; /* 페이지 번호 */
        	var bdc = data2; /* board_cd */
        	var cdn = data3; /* title */
        	var club_id = data4 /* club_id*/
        	var link = urlpaging + "page=" + page + "&club_id=" + club_id + "&bdc=" + bdc  
        	if(data3 != null){
        		link += "&cdn=" + cdn;
        	}
        	location.href = link; 
        }
	</script>
</body>
</html>