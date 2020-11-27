<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="x" uri="http://java.sun.com/jsp/jstl/xml"%>

<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="hallym.club.club.vo.ClubVO"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>


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
	
    <!-- 에디터로 업로드한 이미지가 반응형으로 조절되게 하기 위해 기존 에디터 크기 지정을 무시함 -->
	<style type='text/css'>
		div.content img { max-width: 100%; height: auto;  float: none !important;}
		/*div#cke_1_contents img { max-width: 100%; height: auto; }*/
	</style>
</head>
<body id="item_body" class="pc">
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = (UserVO) session.getAttribute("userVO");
			cuserId = cuserVO.getId();
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
                        <li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
                        <li>활동</li>
                        <li>조회 및 가입</li>
                       	<li>${clubVO.club_nm}</li>
                       	<li>소개</li>
                       	
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
							<h2>${clubVO.club_nm}</h2>
						</div>
					</div>
					<ul class="lnb-menu jwxe-menu-ul">
						<li class="active">
							<a class="active" href="/clubIntroView.do?club_id=${clubVO.club_id}">소개</a>
						</li>
						<li>
							<a href="#" onclick="postPopUp(${clubVO.club_id}, '${clubVO.club_nm}');">가입신청</a>
						</li>
						<li>
							<c:choose>
								<c:when test="${not empty email}">
								<a href="mailto:${email}" title="메일보내기">문의(E-mail)</a>
								</c:when>
								<c:otherwise>
								<a href="#" onclick="alert('이메일이 주소를 찾을 수 없습니다.');">문의(E-mail)</a>
								</c:otherwise>
							</c:choose>
						</li>
					</ul>
				</div>
			</div>
	        <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                      		 <h3>${clubVO.club_nm}  소개 </h3>
                      		 
                    </div>
                </div>
                <div class="tab"></div>
                <div class="content" id="jwxe_main_content">
                	<div class="content-box">
	                	<form id="termsForm" class="b-login-box jw-form-valid" method="post" action="/clubIntroUpdateForm.do">
							<div class="con-box">
								<div class="">
									<ul>
										<li class="" style="width: 100%; float: left;padding-top: 20px;border-top: 1px solid #d8d8d8;">
								        	
						                      <h3 class="text-black"></h3>
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
						 	<input type="hidden" name="club_id" value="${clubVO.club_id}">
							<input type="hidden" name="board_cd" value="${board_cd}">
							 <c:if test="${isStaff eq true}">
								<button type="submit" class="b-btn-login" value="수정하기">수정하기</button>
							 </c:if> 
							</div>
						</form>
						<%--  <div class="bn-login01 type01">
							<button style="margin-top: 20px; padding: 12px 1px;" class="b-btn-login" onclick="postPopUp(${clubVO.club_id}, '${clubVO.club_nm}');">가입 신청</button>
					    </div> --%>
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
	<script type="text/javascript">
		var winRef;
		function postPopUp(club_id, club_nm) {
		<%if (cuserId == null) {%>
			alert("로그인이 필요합니다.");
			location.href='/login.do';
			return false;
		<%} else {%>
		if(winRef == null){
			/* ie 브라우저에서는 스크롤이 기본 옵션이 아니라 추가 옵션이라 scrollbars를 통해 별도로 지정하지 않으면 작동하지 않는다. */
			winRef = window.open("/clubSignUpForm.do?club_id="+club_id+"&club_nm="+club_nm, 'w', 'width=900,height=650,location=no,status=no,scrollbars=yes');
			return true;
			
		} else {
			if(winRef.closed == false){
				winRef.focus();
				return true;
			}
			else {
				winRef = window.open("/clubSignUpForm.do?club_id="+club_id+"&club_nm="+club_nm, 'w', 'width=900,height=650,location=no,status=no,scrollbars=yes');
				return true;
			}
		}
		<%}%>
		}
	</script>
	<noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>