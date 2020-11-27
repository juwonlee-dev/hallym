<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>
<%@page import="hallym.club.user.vo.UserVO"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>소개</title>
	
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge" />
	<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	
	<!--css-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css" />
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" />
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
		var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
		,_cur_menu_cd = '4131',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/res/league/'
		,editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = '',developMode = false,device='pc',isMobile=false
		,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = ''
		,locale= 'ko',localeScriptPath='${pageContext.request.contextPath}/custom/js/';
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
	<script type="text/javascript">	        
	   
        
        function getPage(data1, data2, data3, data4) {
            var urlpaging = "/clubSearch.do?";
        	var page = data1; /* 페이지 번호 */
        	var opt = data2; /* gb_cd*/
        	var opt2 = data3; /* at_cd*/
        	var opt3 = data4; /* search */
        	var link = urlpaging + "&page=" + page;
        	
        	if(opt != null) {
        		link += "&gb_cd=" + opt;
        	}
        	if(opt2 != null) {
        		link += "&at_cd=" + opt2;
        	}
        	if(opt3 != null) {
        		link += "&search=" + opt3;
        	}
        	
        	location.href = link; 
        }
        
        $(document).ready(function() {
        	var board_cd = "<%=session.getAttribute("board_cd") %>"
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	for(var i=0; i<sidemenu.length; i++) {
        		if(sidemenu[i].className == "active") {
        			activeNum = i;
        			break;
        		}
        	}

    		sidemenu[activeNum].classList.remove('active');
    		sidemenu[activeNum].getElementsByTagName("a")[0].classList.remove("active");
    		
        	var msg = "";
        	var msg2 = "";
        	
        	switch(board_cd) {
        	case "007009":
        		msg = "동아리란?";
        		msg2 = "소개";
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007005":
        		msg = "동아리 연합회";
        		msg2 = "소개";
        		sidemenu[1].classList.add('active');
        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007006":
        		msg = "동아리방 배치도";
        		msg2 = "소개";
        		sidemenu[2].classList.add('active');
        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007007":
        		msg = "회칙";
        		msg2 = "소개";
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007008":
        		msg = "세칙";
        		msg2 = "소개";
        		sidemenu[4].classList.add('active');
        		sidemenu[4].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	default:
        		msg = "Null2";
    			msg2 = "소개";
        		break;
        	}
        	
        	document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > div > div > h2").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(2)").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(3)").innerText = msg;
        	document.querySelector("#item_body > div > div.sub-container > div.content-wrap > div.title > div > h3").innerText = msg;
        });

    </script>
    
    <!-- 에디터로 업로드한 이미지가 반응형으로 조절되게 하기 위해 기존 에디터 크기 지정을 무시함 -->
	<style type='text/css'>
		div.content img { max-width: 100%; height: auto;  float: none !important;}
		/*div#cke_1_contents img { max-width: 100%; height: auto; }*/
	</style>
</head>
<body id="item_body" class="pc">
	<ul id="go_main">
		<li><a href="#jwxe_main_content" >본문 바로가기</a></li>
		<li><a href="#jwxe_main_menu" >주메뉴 바로가기</a></li>
		<li><a href="#jwxe_sub_menu" >서브메뉴 바로가기</a></li>
	</ul>
	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
		<div class="sub-visual-wrap"></div>
		<div class="path-wrap">
            <div class="path-box">
                <div class="jwxe_navigator jw-relative">
                    <ul>
                        <li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>소개</li>
                        <c:choose>
                        	<c:when test="${board_cd eq '007009'}">
                       		 <li>동아리란?</li>
                        	</c:when>
                        	<c:when test="${board_cd eq '007005'}">
                       		 <li>동아리 연합회</li>
                        	</c:when>
                        	<c:when test="${board_cd eq '007006'}">
                       		 <li>동아리방 배치도</li>
                        	</c:when>
                        	<c:when test="${board_cd eq '007007'}">
                       		 <li>회칙</li>
                        	</c:when>
                        	<c:when test="${board_cd eq '007008'}">
                       		 <li>세칙</li>
                        	</c:when>
                        </c:choose>
                    </ul>
                </div>
            </div>
        </div>
        <!--로그인-->
		<div class="sub-container">	
			<!--게시판 메뉴-->
			<div class="lnb-wrap">
				<div class="lnb">
					<div class="lnb-title-box">
						<div>			
							<h2>소개</h2>
						</div>
					</div>
					<ul class="lnb-menu jwxe-menu-ul">
						<li>
							<a href="/introView.do?board_cd=007009">동아리란?</a>
						</li>
						<li>
							<a href="/introView.do?board_cd=007005">동아리 연합회</a>
						</li>
						<li>
							<a href="/introView.do?board_cd=007006" >동아리방 배치도</a>
						</li>
						<li>
							<a href="/introView.do?board_cd=007007" >회칙</a>
						</li>
						
					</ul>
				</div>
			</div>
	        <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                    	<h3>Null</h3>
                    </div>
                </div>
                <div class="tab"></div>
                <div class="content" id="jwxe_main_content">
                	<div class="content-box">
	                	<form id="termsForm" class="b-login-box jw-form-valid" method="post" action="/introUpdateForm.do">
							<div class="con-box">
								<div class="">
									<ul>
										<li class="" style="width: 100%; float: left;padding-top: 20px;border-top: 1px solid #d8d8d8;">
								        	<%-- <c:choose>
						                       	<c:when test="${board_cd eq '007009'}">
						                      		 <h3 class="text-black">동아리란?</h3>
						                       	</c:when>
						                       	<c:when test="${board_cd eq '007005'}">
						                      		 <h3 class="text-black">동아리 연합회</h3>
						                       	</c:when>
						                       	<c:when test="${board_cd eq '007006'}">
						                      		 <h3 class="text-black">동아리방 배치도</h3>
						                       	</c:when>
						                       	<c:when test="${board_cd eq '007007'}">
						                      		 <h3 class="text-black">회칙</h3>
						                       	</c:when>
						                       	<c:when test="${board_cd eq '007008'}">
						                      		 <h3 class="text-black">세칙</h3>
						                       	</c:when>
						                     </c:choose> --%>
								        	<div class="border-box bg-gray">  
												${boardVO.contents}
						                       	<textarea id="articleText" 
						                       				name="contents" 
						                       				rows="10" 
						                       				cols="30" 
						                       				class="b-input b-textarea jwvalid-must-contents ceditor" 
						                       				data-editor-height="500"
						                       				style="height: 0px; border: none; position: absolute; left: -99999px;">
						                       	</textarea>
	                                        </div>
								        </li>
									</ul>
							    </div>
							</div>
							<div class="con-box no-pd"><br></div>
							<div class="bn-login01 type01">
								 <c:if test="${isAdmin eq true}">
									<input type="hidden" name="board_cd" value="${board_cd}">
									<button type="submit" class="b-btn-login" value="수정하기">수정하기</button>
								 </c:if>
					    	</div>
						</form>
					</div>
                </div>
            </div>
        </div>
		<!--마지막페이지-->
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer> 
	</div>
	<noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>