<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
	<title>한림대학교 동아리 커뮤니티</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name="viewport" content="width=1200">
	
	<!--font awesome-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" />
	<!--[if IE 8]>
	    <link rel="stylesheet" type="text/css" href="/_common/ie8.css" />
	<![endif]-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css" />
	<link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	
	<!--js-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
	<script defer="" type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
	<script type="text/javascript">
	//<![CDATA[
	    var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href
	    ,_so_ = false,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font'
	    ,_reouscePath = '/_res/league/',editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = ''
	    ,developMode = false,device='pc',isMobile=false,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = ''
	    ,rootPath = '',locale= 'ko',localeScriptPath='/_custom/hallym/resource/js/';
	//]]>
	</script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js" ></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/newphoto.js" defer></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/hclubDesign.js" defer></script>

</head>
<body id="item_body" class="pc">
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
		<li><a href="#jwxe_main_menu">주메뉴 바로가기</a></li>
		<li><a href="#jwxe_sub_menu">서브메뉴 바로가기</a></li>
	</ul>

	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap clubGreen"><jsp:include	page="/WEB-INF/jsp/community/item/top-util.jsp" /></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/community/item/header.jsp" /></div>
		</header>
        <!--작은 바-->
        <div class="sub-visual-wrap"></div>
        <div class="path-wrap">
            <div class="path-box">
                <div class="jwxe_navigator jw-relative">
                    <ul>
                        <li><a href="/clubIntro.do?club_id=${club_id}"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>게시판</li>
                        <li class="clubonly">${headTitle}</li>
                    </ul>
                </div>
            </div>
        </div>

        <!--공지사항 보기-->
        <div class="sub-container newform">
			<!--본문-->
			<c:choose>
				<c:when test='${board_cd eq "007001" || board_cd eq "007002"}'>
					<jsp:include page="/WEB-INF/jsp/community/board/item/BoardReadContents.jsp"/>
				</c:when>
				<c:when test='${board_cd eq "007003"}'>
					<jsp:include page="/WEB-INF/jsp/community/board/item/BoardReadContents.jsp"/>
				</c:when>
				<c:when test='${board_cd eq "007004"}'>
					<jsp:include page="/WEB-INF/jsp/community/board/item/CalendarReadContents.jsp"/>
				</c:when>
				<c:otherwise>
					
				</c:otherwise>
			</c:choose>
		</div>
        <footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp" /></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp" /></div>
		</footer>
    </div>
    <script>
		function getDownLink(data1, data2, data3) {
			var url = "/FileDownload.do?club_id=" + data1 + "&board_cd=" + data2 + "&num=" + data3;
			location.href = url;
	    }
    </script>
    <noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>