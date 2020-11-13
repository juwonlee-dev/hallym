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
</head>
<body>
	<%-- upload/club/${item.intro_save_file_nm} --%>

	<jsp:include page="clubPlatform.jsp"></jsp:include>
	<div class="main">
		<img width="980" height="700" src="upload/club/${club_poster}"
			onerror="this.src='images/error/error.png'" >
	</div>
</body>
</html>