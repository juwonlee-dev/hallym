<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css?after">
<link href='${pageContext.request.contextPath}/res/clubOld/js/packages/core/main.css' rel='stylesheet' />
<link href='${pageContext.request.contextPath}/res/clubOld/js/packages/daygrid/main.css' rel='stylesheet' />
<script src='${pageContext.request.contextPath}/res/clubOld/js/packages/core/main.js'></script>
<script src='${pageContext.request.contextPath}/res/clubOld/js/packages/interaction/main.js'></script>
<script src='${pageContext.request.contextPath}/res/clubOld/js/packages/daygrid/main.js'></script>

<%
	
	String calenar = (String) session.getAttribute("jsonInfo");
	System.err.println("[clubCalendar.jsp] calenar: "+ calenar);
%>
<script>
	/* var arr = new Array();

	 var arrInfo = new Object();

	 arrInfo.title = 'zzz22';
	 arrInfo.start = '2019-10-03';
	 arrInfo.end= '2019-10-07';
	 arr.push(arrInfo);

	 arrInfo = new Object();
	 arrInfo.title = 'zzz';
	 arrInfo.start = '2019-10-01';
	 arrInfo.end= '2019-10-07';
	 arr.push(arrInfo); */

	/* var jsonInfo = JSON.stringify([{"title":"김as","start":"2019-10-18","end":"2019-10-18"}]); */
	var jsonInfo = JSON.stringify(<%=calenar%>);
</script>
<script>
	document.addEventListener('DOMContentLoaded', function() {
		var calendarEl = document.getElementById('calendar');

		var today = new Date();
		var yyyy = today.getFullYear();
		var mm = today.getMonth() + 1;
		var dd = today.getDate();

		if (dd < 10) {
			dd = '0' + dd
		}

		if (mm < 10) {
			mm = '0' + mm
		}

		today = yyyy + '-' + mm + '-' + dd;

		var calendar = new FullCalendar.Calendar(calendarEl, {
			plugins : [ 'interaction', 'dayGrid' ],
			defaultDate : today,
			locale : 'ko',
			displayEventTime : false, //시간 제거
			eventLimit : 4, // allow "more" link when too many events
			events : eval(jsonInfo)

		});

		calendar.render();
	});
</script>
<style>
#calendar {
	max-width: 900px;
	margin: 0 auto;
}
</style>
</head>
<body>
	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main">
		<div style="max-width: 880px; margin: 0 auto; height: 30px">
			<div style="float: right">
				<c:if test="${isStaff eq true}">
				<button class="cal-btn"
					onclick="location.href='clubBoardWriteForm.do?club_id=${club_id}&board_cd=${board_cd}'">일정
					등록</button>
				</c:if>
			</div>
		</div>
		<div id='calendar' style="max-width: 880px; margin: 0 auto;"></div>
	</div>
</body>
</html>