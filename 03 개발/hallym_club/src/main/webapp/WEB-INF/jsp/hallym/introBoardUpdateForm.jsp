<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="java.util.Arrays"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>동아리 연합회 소개 - 수정</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

    <!--css-->
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
    <link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
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
		,_cur_menu_cd = '4146',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/_res/league/'
		,editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = '',developMode = false,device='pc',isMobile=false
		,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = '',locale= 'ko'
		,localeScriptPath='${pageContext.request.contextPath}/custom/js/';
       //]]>
  	</script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/ckeditor/ckeditor.js"></script>
  	<script type="text/javascript" src="${pageContext.request.contextPath}/plugin/ckeditor/config.js"></script>

	<script type="text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>	
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/tag-it.min.2.0.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/common/js/jquery-plugin/tag/jquery.autosize.input.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/custom/js/board.write.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/test/common/bootstrap/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
	<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20200506_00/e/js/element/element_main.js"></script>
	
    <script type="text/javascript">
        function ListForm(){
            location.href="/introView.do";
        }

        $(document).ready(function() {
        	var board_cd = "<%=session.getAttribute("board_cd") %>"
        	<%System.err.println("[introUpdateForm.jsp] board_cd: " + session.getAttribute("board_cd")); %>
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	for(var i=0; i<sidemenu.length; i++) {
        		if(sidemenu[i].className == "active") {
        			activeNum = i;
        			break;
        		}
        	}
        	var msg = "";
        	var msg2 = "";
        	var code = 0;
        	
    		sidemenu[activeNum].classList.remove('active');
    		sidemenu[activeNum].getElementsByTagName("a")[0].classList.remove("active");
        	switch(board_cd) {
        	case "007005":
        		msg = "동아리 연합회 소개";
        		msg2 = "소개";
        		code = 1;
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007006":
        		msg = "동아리 배치도";
        		msg2 = "소개";
        		code = 1;
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007007":
        		msg = "회칙";
        		msg2 = "소개";
        		code = 1;
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	case "007008":
        		msg = "세칙";
        		msg2 = "소개";
        		code = 1;
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		break;
        	default:
        		msg = "Null";
   				msg2 = "Null";
        		break;
        	}
        	document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > div > div > h2").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(2)").innerText = msg2;
        	document.querySelector("#item_body > div > div.path-wrap > div > div > ul > li:nth-child(3)").innerText = msg;
        	document.querySelector("#item_body > div > div.sub-container > div.content-wrap > div.title > div > h3").innerText = msg;
        	
        });
    </script>
    
    <style>
		.ck-editor__editable {
			min-height: 400px;
			max-height: 500px;
		}
		
		.ck.ck-editor__editable:not(.ck-editor__nested-editable).ck-focused {
	    	width: auto;
		}
		
		.ck.ck-editor__main>.ck-editor__editable:not(.ck-focused) {
	    	width: auto;
		}
	</style>
</head>
<body id="item_body" class="pc" style="position: relative; min-height: 100%; top: 0px;">
	<%
		UserVO userVO = null;
		String userId = null;
		String auth_code = null;
		String board_cd = null;
		if (session.getAttribute("userVO") != null) {
			userVO = ((UserVO) session.getAttribute("userVO"));
			userId = userVO.getId();
			auth_code = (String) session.getAttribute("auth_code");
			board_cd = (String) session.getAttribute("board_cd");
		}
		if (userId == null) {
			out.println("<script>");
			out.println("alert('로그인이 필요한 서비스입니다.')");
			out.println("location.href='login.do'");
			out.println("window.close();");
			out.println("</script>");
		} else {
	%>
	<c:set var="writerAuth" value="${writerAuth}"/>
	<%
		String writerAuth = (String) pageContext.getAttribute("writerAuth");
		String[] allowAuth = {"010001", "010002", "010003"};
		boolean isAdmin = Arrays.asList(allowAuth).contains(writerAuth);
	%>
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
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
                        	<c:when test="${board_cd eq '007005'}">
                       		 <li>동아리 연합회 소개</li>
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
		<div class="sub-container">
			<!--메뉴바-->
            <div class="lnb-wrap">
                <div class="lnb">
                    <div class="lnb-title-box">
                    	<div>
                            <h2>소개</h2>
                       	 </div>
                    </div>
                    <ul class="lnb-menu jwxe-menu-ul">
                    	<li>
							<a href="/introView.do?board_cd=007005">동아리 연합회 소개</a>
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
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <c:choose>
                       	<c:when test="${board_cd eq '007005'}">
                      		 <h3>동아리 연합회 소개</h3>
                       	</c:when>
                       	<c:when test="${board_cd eq '007006'}">
                      		 <h3>동아리방 배치도</h3>
                       	</c:when>
                       	<c:when test="${board_cd eq '007007'}">
                      		 <h3>회칙</h3>
                       	</c:when>
                       	<c:when test="${board_cd eq '007008'}">
                      		 <h3>세칙</h3>
                       	</c:when>
                     </c:choose>
                    </div>
                </div>
                
                <div class="tab"></div>
                <!--공지사항-->
                <div class="content" id="jwxe_main_content">
                    <script type="text/javascript">
                        //<![CDATA[
                          var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
                          clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
                        //]]>
                    </script>
                    <div class="ko board write co-board type01">
	                    <div class="bn-write-common01 type01">
	                        <!-- 사용여부를  게시판 수정시 기타 설정에서 선택할수 있는 필드  -->
	                        <form method="post" action="/introUpdateAction.do" name="boardForm" enctype="multipart/form-data">
	                            <fieldset>
	                            	<c:choose>
				                       	<c:when test="${board_cd eq '007005'}">
				                      		 <legend class="hide">동아리 연합회 소개</legend>
				                       	</c:when>
				                       	<c:when test="${board_cd eq '007006'}">
				                      		 <legend class="hide">동아리방 배치도</legend>
				                       	</c:when>
				                       	<c:when test="${board_cd eq '007007'}">
				                      		 <legend class="hide">회칙</legend>
				                       	</c:when>
				                       	<c:when test="${board_cd eq '007008'}">
				                      		<legend class="hide">세칙</legend>
				                       	</c:when>
				                     </c:choose>
	                                
	                                <input type="hidden" name="csrfToken" value="cryjsjscbszhtaostgll">
	                                <input type="hidden" name="articleNo" value="">
	                                <input type="hidden" name="parentNo" value="0">
	                                <input type="hidden" name="htmlYn" value="Y">
	                                <input type="hidden" name="board_cd" value="${board_cd}">
	                                <div class="b-table-wrap">
	                                    <!--내용-->
	                                    <div class="b-table-box type01">
	                                        <div class="b-row-box">
	                                            <div class="b-title-box b-required">
	                                                <label for="articleText">내용</label>
	                                            </div>  
	                                            <div class="b-con-box">
	                                                <textarea id="articleText" name="contents" class="b-input b-textarea jwvalid-must-contents ceditor" rows="10" cols="30" data-editor-height="500" style="height: 0px; border: none; position: absolute; left: -99999px;">${boardVO.contents}</textarea>
	                                            </div>
	                                        </div>
	                                    </div>
										
	                                </div>
	                            </fieldset>  
	                            <div class="b-btn-wrap">
	                                <a class="b-btn-type01 b-btn-c-white" title="취소" href="javascript:ListForm();">취소</a>
	                                <!-- 버튼 -->
	                                <button type="submit" class="b-btn-type01 b-btn-c-blue submit"  onclick="return confirm('저장 하시겠습니까?');">저장</button>
	                            </div>
	                        </form> 
	                    </div>
	                </div>
	            </div>
	        </div>
	    </div>
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
	</div>
	
	<script type="text/javascript">
		var editor = CKEDITOR.replace( 'articleText', {
			enterMode: '2',
		    shiftEnterMode: '3',
			filebrowserUploadUrl: '/ImageUpload.do'
		});	
	</script>
	<%} %>
	 
</body>

</html>