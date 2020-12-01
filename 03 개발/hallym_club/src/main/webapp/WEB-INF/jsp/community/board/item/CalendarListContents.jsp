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
</head>
<body>
<%
	String calenar = (String) session.getAttribute("jsonInfo");
	System.err.println("[clubCalendar.jsp] calenar: "+ calenar);
%>
	<h1><i class="far fa-calendar-alt"></i>일정</h1>
    <div id="calendar"></div> 
    <div class="b-btn-wrap date">
	<c:if test="${isStaff eq true}">
		<a class="b-btn-type01 b-btn-c-blue submit ver2" href="clubBoardWriteForm.do?club_id=${club_id}&board_cd=${board_cd}">등록</a>
	</c:if>
    </div>
	<script>
		var jsonInfo = JSON.stringify(<%=calenar%>);
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
				plugins : [ 'interaction' ,'dayGrid'],
 				header : {
   					left : 'prev,next,today',
   					center : 'title',
   					right : 'dayGridMonth,dayGridDay'
				},
				defaultDate : today,
	       		displayEventTime : false, //시간 제거
	       		events : eval(jsonInfo),
	       		eventLimit : 5,
	       		dropable : false,
	       		editable : false,
	       		/* 드래그로 일정 이동
	     		drop : function(info) {
	     			if (checkbox.checked) {
	       				info.draggedEl.parentNode.removeChild(info.draggedEl);
	     			}
	   			},
	   			*/
	   			locale : 'ko'
	       });
	       
	       calendar.render();
		});
	</script>
</body>
</html>