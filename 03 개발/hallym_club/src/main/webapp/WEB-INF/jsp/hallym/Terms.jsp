<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@page import="hallym.club.user.vo.UserVO"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>Login</title>
	
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
	
</head>
<body id="item_body" class="pc">
<%
	Cookie[] cookies = request.getCookies();
	String ID = "";
	String GBN = "";
	if(cookies != null) {
		for(Cookie c : cookies) {
			if(c.getName().trim().equals("ID")) {
				ID = c.getValue();
			} else if(c.getName().trim().equals("GBN")) {
				GBN = c.getValue();
			}
		}
	}

%>
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
                        <li><a href="/terms.do"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>기타</li>
                        <li>서비스 이용 약관</li>
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
							<h2>기타</h2>
						</div>
					</div>
					<ul class="lnb-menu jwxe-menu-ul">
						<li>
							<a href="/terms.do" >서비스 이용 약관</a>
						</li>
					</ul>
				</div>
			</div>
	        <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>서비스 이용 약관</h3>
                    </div>
                </div>
                <div class="tab"></div>
                <div class="content" id="jwxe_main_content">
                	<div class="content-box">
	                	<form id="termsForm" class="b-login-box jw-form-valid" method="post" action="/termsAgreeAction.do">
							<div class="con-box">
								<div class="">
									<ul>
										<li class="" style="float: left;padding-top: 20px;border-top: 1px solid #d8d8d8;">
								        	<h3 class="text-black">개인정보 수집 · 이용 동의</h3>
								        	<div class="border-box bg-gray">
								            	한림대학교 동아리 관리 플랫폼 서비스(이하 '동아리 플랫폼')는 회원식별, 회원가입 및 고지사항 전달 등을 위해 아래와 같은 개인정보를 수집·이용합니다.
								            	<br>
								            	이후에 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.
								            	<br>
								            	
								            	<br>
								            	1. 회원식별 및 회원서비스 제공<br>
								            	- 수집목적 : 회원식별 및 회원서비스 제공<br>
								            	- 수집항목 : 학번 또는 사번, 이름, 학년, 소속 및 직급 등 한림대학교 통합정보시스템에서 제공되는 기본 학적 정보<br>
								            	- 수집근거 : 개인정보보호법 제 15조 제 1항<br>
								            	<br>
								            	2. 고지사항 전달<br>
								            	- 수집목적 : 고지사항 전달<br>
								            	- 수집항목 : 이메일, 휴대전화번호<br>
								            	- 수집근거 : 개인정보보호법 제 15조 제 1항<br>
								            	<br>
								            	3. 부정 이용 방지<br>
								            	- 수집목적 : 불량 회원의 부정 이용 방지<br>
								            	- 수집항목 : 접속 아이피, 접속 로그<br>
								            	- 수집근거 : 개인정보보호법 제 15조 제 1항<br>
								            	<br>
								            	귀하는 한림대학교 동아리 관리 플랫폼 서비스(이하 '동아리 플랫폼') 이용에 필요한 최소한의 개인정보 수집·이용에 동의하지 않을 수 있으나, 동의를 거부할 경우 서비스 이용이 불가할 수 있습니다.
								            	<br>
								            </div>
								            <div style="float: right;margin-bottom: 20px;">
								            	<label for="chk_id">[필수]위 개인정보 수집·이용에 동의합니다.</label>
		                                        <input type="checkbox" id="chk_id" name="agreeTerm" value="012001">
		                                    </div>
								        </li>
									</ul>
							    </div>
							</div>
							<div class="con-box no-pd"><br></div>
							<div class="bn-login01 type01">
								 
								<button type="submit" class="b-btn-login" value="동의하기">동의하기</button>
								
								<!--  
								<button onclick="submitTerms" class="b-btn-login" value="동의하기">동의하기</button>
					    		 -->
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