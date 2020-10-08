<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 뷰포트 -->

<meta name="viewport" content="width=device-width" initial-scale="1">

<!-- 스타일시트 참조  -->

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css?after">
<title>한림대학교 동아리</title>

</head>

<style>
.table {
	border-collapse: collapse;
	border-top: 3px solid #168;
	margin: 0 auto;
}

.table th {
	color: #168;
	background: #f0f6f9;
	text-align: center;
}

.table th, .table td {
	padding: 10px;
	border: 1px solid #ddd;
}

.table th:first-child, .table td:first-child {
	border-left: 0;
}

.table th:last-child, .table td:last-child {
	border-right: 0;
}

.table tr td:first-child {
	text-align: center;
}

.table caption {
	caption-side: bottom;
	display: none;
}

.intro {
	width: 100%;
	height: 30px;
}
</style>

<body>
<p>isMyWrite: ${isMyWrite}</p>


	<jsp:include page="clubPlatform.jsp"></jsp:include>
	<!-- 게시판 -->
	<div class="main">
		<div class="container">
			<div class="row">
				<table class="table">
					<thead>
						<tr>
							<th colspan="3">글 보기</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">글 제목</td>
							<td colspan="2">${searchBoard.getTitle()}</td>
						</tr>
						<c:if test='${board_cd eq "007004"}'>
						<tr>
							<td>일정</td>
							<td><label for="fromDate">${searchBoard.getStart_date().substring(0, 10)}</label>
								~ <label for="toDate">${searchBoard.getEnd_date().substring(0, 10)}</label>
							</td>
						</tr>
						</c:if>
						<tr>
							<td>작성자</td>
							<td colspan="2">${writerName}</td>

						</tr>
						<tr>
							<td>작성일</td>
							<td colspan="2">${searchBoard.getInput_date()}</td>

						</tr>
						<tr>
							<td>조회수</td>
							<td colspan="2">${searchBoard.getOpen_cnt()}</td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align: left;">
								<textarea name="CONTENTS" rows="15" style="width: 645px;"
									readonly="readonly">${searchBoard.getContents()}</textarea>
							</td>
						</tr>
					</tbody>

				</table>
				<div id="lay-btn">
					<c:choose>
						<c:when test='${board_cd eq 007004}'>
						<a class="input-btn"
							href="clubCalendar.do?club_id=${club_id}&board_cd=${board_cd}">목록</a>
						</c:when>
					
						<c:otherwise>
						<a class="input-btn"
							href="clubBoardList.do?club_id=${club_id}&board_cd=${board_cd}">목록</a>
						</c:otherwise>
					</c:choose>

					<c:if test='${isMyWrite eq true}'>
					<a class="input-btn"
						href="clubBoardUpdateForm.do?board_no=${searchBoard.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}">수정</a>

					<a class="input-btn" onclick="return confirm('삭제 하시겠습니까?');"
						href="clubBoardDeleteAction.do?board_no=${searchBoard.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}">삭제</a>
					</c:if>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
