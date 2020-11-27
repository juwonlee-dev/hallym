<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="java.util.Arrays"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>게시판 &gt; Notice 게시판읽기&#40;농구게시판 테스트&#41; | 부서_인트라뮤럴</title>

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
        var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href
        ,_so_ = false,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font'
        ,_reouscePath = '/res/league/',editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = ''
        ,developMode = false,device='pc',isMobile=false,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = ''
        ,rootPath = '',locale= 'ko',localeScriptPath='${pageContext.request.contextPath}/custom/js/';
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
 
	     function ListForm(){
	     	location.href="/BoardSearch.do";
	     }
     
	     function getSingleBoard(data1) {
	     	location.href="/BoardReadForm.do?&num=" + data1;
	     }
	     
	     function getDownLink(data1) {
	    	 var url = "/FileDownload.do?&num=";
	    	 var num = data1;
	    	 location.href = url + num;
	     }
	     
	     function getPage(data1, data2, data3) {
	            var urlpaging = "/BoardSearch.do?";
	        	var page = data1; /* 페이지 번호 */
	        	var bdc = data2; /* board_cd */
	        	var cdn = data3; /* title */
	        	var link = urlpaging + "page=" + page + "&bdc=" + bdc  
	        	if(data3 != null){
	        		link += "&cdn=" + cdn;
	        	}
	        	
	        	//link += "&bdc="+ opt2 + "&condition=" + (data3 == null)?"":cdn;
	        	//link = urlpaging+"bdc=007001&page="+page + (data3 == null)?"":"&cdn="+cdn;
	        	location.href = link; 
	        }
	     
	     function checkDelete(data1) {
	    	 if(confirm("게시글을 삭제 하시겠습니까?")) {
	 		 	location.href = data1;
	 		   	return true;
	 		 }
	 		 return false;
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
	        	var msg = "";
	        	var msg2 = "";
	        	var code = 0;
	        	
	    		sidemenu[activeNum].classList.remove('active');
	    		sidemenu[activeNum].getElementsByTagName("a")[0].classList.remove("active");
	        	switch(board_cd) {
	        	case "007001":
	        		msg = "공지사항";
	        		msg2 = "게시판";
	        		code = 1;
	        		sidemenu[0].classList.add('active');
	        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
	        		break;
	        	case "007002":
	        		msg = "자유게시판";
	        		msg2 = "게시판";
	        		code = 1;
	        		sidemenu[1].classList.add('active');
	        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
	        		break;
	        	case "007003":
	        		msg = "사진";
	        		msg2 = "게시판";
	        		code = 1;
	        		sidemenu[2].classList.add('active');
	        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
	        		break;
	        	case "007004":
	        		msg = "일정";
	        		msg2 = "게시판";
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
 	<!-- 
 	<style>
 		/* 바깥 테두리 제거 */
		#cke_articleText {
			/* border: none; */ 
			border: 1px solid #ffffff;
		}
		
		/* 툴바 제거 */
	   .cke_inner .cke_top {
		    display: none;
		}
		
		/* 하단 태그 삭제 */
		#cke_1_bottom {
			display: none;
		}
		
	</style>
	-->
	
    <!-- 에디터로 업로드한 이미지가 반응형으로 조절되게 하기 위해 기존 에디터 크기 지정을 무시함 -->
	<style type='text/css'>
		div.content img { max-width: 100%; height: auto; float: none !important;}
		/*div#cke_1_contents img { max-width: 100%; height: auto; }*/
	</style>
</head>
<body id="item_body" class="pc">
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		String auth_code = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = (UserVO) session.getAttribute("userVO");
			cuserId = cuserVO.getId();
			auth_code = (String) session.getAttribute("auth_code");
		}
	%>
	
	<c:set var="board_cd" value="${board_cd}"/>
	<c:set var="input_id" value="${searchBoard.input_id}"/>
	<c:set var="update_id" value="${searchBoard.update_id}"/>
	<c:set var="writerAuth" value="${writerAuth}"/>
	<c:set var="editorAuth" value="${editorAuth}"/>
    <ul id="go_main">
        <li><a href="#jwxe_main_content" >본문 바로가기</a></li>
        <li><a href="#jwxe_main_menu" >주메뉴 바로가기</a></li>
        <li><a href="#jwxe_sub_menu" >서브메뉴 바로가기</a></li>
    </ul>

    <div class="sub-wrap">
        <!--메뉴바-->
        <header>
			<div class="top-header-wrap"><jsp:include page="/WEB-INF/jsp/item/top-util.jsp"/></div>
			<div class="bottom-header-wrap"><jsp:include page="/WEB-INF/jsp/item/header.jsp"/></div>
		</header>
        <!--작은 바-->
        <div class="sub-visual-wrap"></div>
        <div class="path-wrap">
        	<div class="path-box">
          		<div class="jwxe_navigator jw-relative">
                	<ul>
                    	<li><a href="/index.do"><img src="images/common/ico-home.png" alt="home"></a></li>
	                    <li>게시판</li>
	                    <li>공지사항</li>
                 	</ul>
             	</div>
         	</div>
     	</div>
        <!--공지사항 보기-->
        <div class="sub-container">

            <div class="lnb-wrap">
                <div class="lnb">
                    <div class="lnb-title-box">
                        <div>
                            <h2>게시판</h2>
                        </div>
                    </div>
                    <ul class="lnb-menu jwxe-menu-ul">
                    <%-- <c:choose>
                    	<c:when test="${(board_cd eq '007001') or (board_cd eq '007002') or (board_cd eq '007003') or (board_cd eq '007004')}">
	                         --%>
	                        <li class="active"><a href="/BoardSearch.do?&bdc=007001" class="active">공지사항</a></li>
	                        <!-- <li><a href="/BoardSearch.do?&bdc=007102">Photos</a></li>
	                        <li><a href="/BoardSearch.do?&bdc=007103">경기영상</a></li>
	                        <li><a href="/BoardSearch.do?&bdc=007104">News</a></li> -->
                        <%-- </c:when> --%>
                       
                        <%-- <c:otherwise> --%>
                        	<!-- <li class="active"><a href="/BoardSearch.do?&bdc=007001" class="active">축구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007002">농구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007003">야구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007006">족구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007004">배드민턴</a></li>
							<li><a href="/BoardSearch.do?&bdc=007010">테니스</a></li>
							<li><a href="/BoardSearch.do?&bdc=007009">피구</a></li>
							<li><a href="/BoardSearch.do?&bdc=007007">풋살</a></li>
							<li><a href="/BoardSearch.do?&bdc=007008">탁구</a></li> -->
                        <%-- </c:otherwise>
                    </c:choose> --%>
                    </ul>
                </div>
            </div>

        <!--본문-->
        <div class="content-wrap">
            <div class="title">
                <div class="jwxe_mnu_template jw-relative page-title" >
                    <h3>공지사항</h3>
                </div>
            </div>
            <div class="tab"></div>
            <div class="content" id="jwxe_main_content">
                <script type="text/javascript">
                //<![CDATA[
                    var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
                    clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
                //]]>
                </script>
                <div class="ko board view co-board type01">
                    <div class="bn-view-common01-box">
                        <div class="bn-view-common01 type01">
                            <input type="hidden" name="articleNo" value="30582" />
                            <div class="b-main-box">
                                <div class="b-top-box">
                                    <p class="b-title-box"><span>${searchBoard.title}</span></p>
                                    <div class="b-etc-box">
                                        <ul>
                                            <li class="b-hit-box">
                                                <span>조회수</span>
                                                <span>${searchBoard.open_cnt}</span>
                                            </li>
                                            <li class="b-writer-box">
                                                <span>작성자</span>
                                                <span>
                               						<%
                           							String writerAuth = (String) pageContext.getAttribute("writerAuth");
					                        		String[] allowAuth = {"010001", "010002", "010003"};
					                        		if(Arrays.asList(allowAuth).contains(writerAuth)) {
						                          	%>
						                           		관리자(${writerName})
						                          	<%
						                      		} else {
							                       	%>
							                        	${writerName}
							                       	<%
						                      		}
						                           	%>
                                                </span>
                                            </li>
                                            <li class="b-date-box">
                                                <span>작성일</span>
                                                <span>
                                                	<fmt:parseDate value="${searchBoard.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
                                                   	<fmt:formatDate value="${tmp}" pattern="yyyy.MM.dd"/>
                                             	</span>
                                            </li>
                                       	<c:if test='${not empty searchBoard.update_id}'>
                                            <li class="b-writer-box">
                                                <span>수정자</span>
                                                <span>
                                                	<%
                           							String editorAuth = (String) pageContext.getAttribute("editorAuth");
					                        		if(Arrays.asList(allowAuth).contains(editorAuth)) {
						                          	%>
						                           		관리자(${editorName})
						                          	<%
						                      		} else {
							                       	%>
							                        	${editorName}
							                       	<%
						                      		}
						                           	%>
                                                </span>
                                            </li>
                                            <li class="b-date-box">
                                                <span>수정일</span>
                                                <span>
                                                	<fmt:parseDate value="${searchBoard.update_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
                                                   	<fmt:formatDate value="${tmp}" pattern="yyyy.MM.dd"/>
                                             	</span>
                                            </li>
                                        </c:if>
                                        </ul>
                                    </div>
                                </div>
                                <div class="b-content-box">
                                    <!--
                            	        <p><div class="fr-view"><p>${searchBoard.contents}</p></div></p>
                                   	-->
	                               	<p><div class="fr-view">
	                               		${searchBoard.contents}
	                               		<textarea id="articleText" name="contents" class="b-input b-textarea jwvalid-must-contents ceditor" rows="10" cols="30" data-editor-height="500" style="height: 0px; border: none; position: absolute; left: -99999px;">
	                               		</textarea>
	                               	</div></p>
                                </div>
                                
							<c:if test="${fileListCnt gt 0}">
                               	<div class="b-file-box">
									<ul>
										<c:forEach items='${fileList}' var="item">
										<li>
											<a class="file-down-btn pptx" href="javascript:getDownLink(${item.file_no});">
												${item.file_nm}
											</a>
										</li>
										</c:forEach>
									</ul>
								</div>
                                <div class="b-etc-txt-box">
									<p class="b-etc-txt type01">"파일 명이 길 경우 브라우저 특성상 파일명이 잘릴 수 있습니다."</p>
								</div>
                            </c:if>
                            </div>
                            <div class="b-btn-wrap">
                            <%
                           	if (cuserId != null) {
                           		String board_cd = (String) pageContext.getAttribute("board_cd");
                           		String input_id = (String) pageContext.getAttribute("input_id");
                           		String update_id = (String) pageContext.getAttribute("update_id");
                           		String[] allowUser = {input_id, update_id};
                           		String[] bList = {"007001", "007002", "007003", "007004"};
                        		if(Arrays.asList(bList).contains(board_cd)) {
                        			if(Arrays.asList(allowAuth).contains(auth_code)) {
                           	%>
								<a class="b-btn-type01 b-btn-c-white" id="deleteArticle" onclick="javascript:checkDelete('/BoardDeleteAction.do?&num=${searchBoard.board_no}');" data-confirm="viewBtn.delete.msg">삭제</a>
								<a class="b-btn-type01 b-btn-c-white" href="/BoardUpdateForm.do?&num=${searchBoard.board_no}">수정</a>
								<a class="b-btn-type01 b-btn-c-white" href="/BoardWriteForm.do">등록</a>
                            <%
                        			}
                        		} else if(Arrays.asList(allowUser).contains(cuserId) || Arrays.asList(allowAuth).contains(auth_code)) {
                        	%>
								<a class="b-btn-type01 b-btn-c-white" id="deleteArticle" onclick="javascript:checkDelete('/BoardDeleteAction.do?&num=${searchBoard.board_no}');" data-confirm="viewBtn.delete.msg">삭제</a>
								<a class="b-btn-type01 b-btn-c-white" href="/BoardUpdateForm.do?&num=${searchBoard.board_no}">수정</a>
								<a class="b-btn-type01 b-btn-c-white" href="/BoardWriteForm.do">등록</a>
                        	<%
                        		}
							} 
							%>
								<a class="b-btn-type01 b-btn-c-blue" href="/BoardSearch.do">목록</a>
							</div>
                            <div class="b-pager-box">
                                <div>
                                    <p>이전글</p>
                                    <p>
                                    <c:choose>
                                    	<c:when test="${not empty prevBoard}">
                                        	<a href="javascript:getSingleBoard(${prevBoard.board_no});">
                                            	${prevBoard.title}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                        	<a href="#" title="이전글이 없습니다.">이전글이 없습니다.</a>
                                       	</c:otherwise>
                                    </c:choose>
                                    </p>
                                </div>
                                <div>
                                    <p>다음글</p>
                                    <p>
                                    <c:choose>
                                    	<c:when test="${not empty nextBoard}">
                                        	<a href="javascript:getSingleBoard(${nextBoard.board_no});">
                                            	${nextBoard.title}
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                        	<a href="#" title="다음글이 없습니다.">다음글이 없습니다.</a>
                                        </c:otherwise>
                                    </c:choose>
                                    </p>
                                </div>
                            </div>
                        </div>
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
   <!--  <script type="text/javascript">
		CKEDITOR.replace( 'articleText', {
			removePlugins: 'toolbar',
			enterMode: '2',
		    shiftEnterMode: '3',
			readOnly: true
		} );
	</script> -->
	<noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>
