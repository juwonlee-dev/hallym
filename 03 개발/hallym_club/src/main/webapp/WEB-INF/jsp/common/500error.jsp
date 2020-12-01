<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>500 Internal Error</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/error.css">
	
</head>
<body>
	<div class="noise"></div>
	<div class="overlay"></div>
	<div class="terminal">
	  <h1>Error <span class="errorcode">500</span></h1>
	  <p class="output">The page you are looking for might have been removed, had its name changed or is temporarily unavailable.</p>
	  <p class="output">Please try to <a href="javascript:history.back();">go back</a> or <a href="/index.do">return to the homepage</a>.</p>
	  <p class="output">Good luck.</p>
	</div>
</body>
</html>