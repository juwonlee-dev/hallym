<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  

<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="java.util.Arrays"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>게시판</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	    
	<!--link-->
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" /><!--  -->
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/m-mn.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/toastr.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/ui.datepicker.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/css/jquery.ui-selectBox.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/board.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/board/css/type01.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/custom/css/board.common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/user.css">
	
	<!--script-->
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-1.9.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/common/js/jquery/jquery-ui-1.11.4.min.js"></script>
	<script defer type="text/javascript" src="//translate.google.com/translate_a/element.js?cd=googleTranslateElementInit"></script>
	<script type="text/javascript">
	   //<![CDATA[
	       var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href,_so_ = false
	       ,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font',_reouscePath = '/res/league/'
	       ,editorVendor = 'froala',sslYN = 'N',sslPort = '8443', servicePort = '',developMode = false,device='pc',isMobile=false
	       ,_cfgUseDevMode = false, _siteId = 'league',printSelector = '#jwxe_main_content',ctx = '',rootPath = ''
	       ,locale= 'ko', localeScriptPath='${pageContext.request.contextPath}/custom/js/';
	   //]]>
	</script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/cms.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/control.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/menu/menu.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/league/js/m-mn.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/toastr.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/jquery-plugin/selectBox.min.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/custom/js/board.common.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/board/js/board.js"></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/res/league/js/user.js"></script>
	
	<script type="text/javascript">	        
	    function writeForm(){
	            location.href="/BoardWriteForm.do";   
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
	<!--style-->
	<style type='text/css'></style>

</head>

<body id="item_body" class="pc">
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		String auth_code = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = (UserVO) session.getAttribute("userVO");
			cuserId = cuserVO.getId();
			//auth_code = (String) session.getAttribute("auth_code");
		}
	%>
	<c:set var="board_cd" value="${board_cd}"/>
	<c:set var="writerAuthList" value="${writerAuthList}"/>
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
                        <li>게시판</li>
                        <li>공지사항</li>
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
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>공지사항</h3>
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
                    <div class="ko board list co-board type01">
                        <div class="common">
                            <!--검색창-->
                            <div class="bn-search01 type01">
                                <form method="post" action="/BoardSearch.do" name="boardForm" enctype="multipart/form-data">
                                    <fieldset class="b-search-wrap">
                                        <legend class="hide">게시글 검색</legend>
                                        <input type="hidden" name="mode" value="list">
                                        <!-- <div class="b-sel-box b-cate-basic" style="z-index: 0;">
                                        	<select class="b-sel-title" name="o1">
                                        		<option class=searchOption value="0">전체</option>
								                <option class=searchOption value="1">제목</option>
								                <option class=searchOption value="2">작성자(번호)</option>
								            </select>
								        </div> -->
                                        <label for="search_val" class="b-sel-label"><span>검색어</span></label>
                                        <input type="text" id="search_val" name="cdn" value placeholder="검색어를 입력해 주세요">
                                        <button type="submit" class="b-sel-btn">검색</button>
                                    </fieldset>
                                </form>
                            </div>
                            <!--검색창-->

                            <!--공지사항1-->
                            <div class="bn-list-common01 type01 bn-common bn-common">
                                <div class="b-top-info-wrap">
                                </div>
                                <table summary="게시판 > Notice" class=board-table>
                                    <caption class="hide">게시판 > Notice</caption>
                                    <colgroup>
                                        <col class="b-col01">
                                        <col class="b-col02">
                                        <col class="b-col03">
                                        <col class="b-col04">
                                        <col class="b-col05">
                                        <col class="b-col06">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">번호</th>
                                            <th scope="col">제목</th>
                                            <th scope="col">작성자</th>
                                            <th scope="col">작성일</th>
                                            <th scope="col" class="b-no-right">조회</th>
                                            <th scope="col">파일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items='${boardList}' var="item" varStatus="status">
									        <tr class>
									            <td class="b-num-box" id="id_${status.count}">
									            	<c:choose>
									            		<c:when test='${item.board_fix eq "Y"}'>
									            			<img src="images/board/ico-notice01.png" border="0" valign="middle" alt="고정글">
									            		</c:when>
									            		<c:otherwise>
									            			${item.board_no}
									            		</c:otherwise>
									            	</c:choose>
									            </td>
									            <td class="b-td-left">
	                                                <div class="b-title-box">
	                                                    <a href="/BoardReadForm.do?num=${item.board_no}" title="${item.title} 자세히 보기">
	                                                    	${item.title}
	                                                    </a>
	                                                    <div class="b-etc-box"></div>
	                                                    <div class="b-m-con">
	                                                        <span class="b-writer">
	                                                        	<c:forEach items='${writerList}' var="user" varStatus="status2">
	                                                        		<c:if test="${status.index eq status2.index}">
	                                                        			<c:forEach items='${writerAuthList}' var="userAuth" varStatus="status3">
	                                                        				<c:if test="${status2.index eq status3.index}">
	                                                        					<c:set var="tmpAuth" value="${userAuth}"/>
	                                                        						<%
                                                        							String tmpAuth = (String) pageContext.getAttribute("tmpAuth");
													                           		String[] allowAuth = {"010001", "010002", "010003"};
													                           		if(Arrays.asList(allowAuth).contains(tmpAuth)) {
														                           	%>
														                            	관리자(${user.name})
														                            <%
													                        		} else {
														                        	%>
															                        	${user.name}
														                        	<%
													                        		}
														                            %>
	                                                        				</c:if>
	                                                        			</c:forEach>
	                                                        		</c:if>
	                                                        	</c:forEach>
	                                                        </span>
	                                                        <span class="b-date">
	                                                        ${item.input_date}
	                                                        	<%-- <c:choose>
	                                                        		<c:when test='${empty item.update_date}'>
	                                                        			<fmt:formatDate value="${item.input_date}" pattern="yy.MM.dd" />
	                                                        		</c:when>
	                                                        		<c:otherwise>
	                                                        			<fmt:formatDate value="${item.update_date}" pattern="yy.MM.dd" />
	                                                        		</c:otherwise>
	                                                        	</c:choose> --%>
	                                                        </span>
	                                                        <span class="hit">조회수 ${item.open_cnt}</span>
	                                                    	<span class="b-file">첨부파일</span>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                            <td>
                                                   	<c:forEach items='${writerList}' var="user" varStatus="status2">
                                                   		<c:if test="${status.index eq status2.index}">
                                                   			<c:forEach items='${writerAuthList}' var="userAuth" varStatus="status3">
                                                   				<c:if test="${status2.index eq status3.index}">
                                                   					<c:set var="tmpAuth" value="${userAuth}"/>
                                                   						<%
                                               							String tmpAuth = (String) pageContext.getAttribute("tmpAuth");
										                           		String[] allowAuth = {"010001", "010002", "010003"};
										                           		if(Arrays.asList(allowAuth).contains(tmpAuth)) {
											                           	%>
											                            	관리자(${user.name})
											                            <%
										                        		} else {
											                        	%>
												                        	${user.name}
											                        	<%
										                        		}
											                            %>
                                                   				</c:if>
                                                   			</c:forEach>
                                                   		</c:if>
                                                   	</c:forEach>
	                                            </td>
	                                            <td>
	                                            ${item.input_date}
													<%-- <c:choose>
                                                   		<c:when test='${empty item.update_date}'>
                                                   			<fmt:formatDate value="${item.input_date}" pattern="yy.MM.dd" />
                                                   		</c:when>
                                                   		<c:otherwise>
                                                   			<fmt:formatDate value="${item.update_date}" pattern="yy.MM.dd" />
	                                                    </c:otherwise>
                                                   	</c:choose> --%>
												</td>
	                                            <td>${item.open_cnt}</td>
	                                            <td class="b-no-right">
	                                            	<c:choose>
									            		<c:when test='${item.attach_yn eq "Y"}'>
									            			<div class="b-file-box">
		                                                    	<span class="hide">첨부파일</span>
		                                                	</div>	
									            		</c:when>
									            		<c:otherwise>
									            			<span>-</span>
									            		</c:otherwise>
									            	</c:choose>
	                                            </td>
									        </tr>  
								    	</c:forEach>
								    	<c:if test="${boardListCount lt 1}">
									    	<tr>
												<td class="b-no-post" colspan="6">등록된 글이 없습니다.</td>
											</tr>
										</c:if>
                                    </tbody>
                                </table>
                            </div>
                            <!--공자사항1-->

                            <!--공지사항2-->
                            <div class="b-paging01 type03">
                                <div class="b-paging01 type01">
                                    <div class="b-paging-wrap">
										<ul>
											<c:if test="${totalPage > 1 and currPage ne prevPage}">
												<li class="first pager">
													<a href="javascript:getPage(1,'${board_cd}','${condition}');" title="첫 페이지로 이동하기">
														<span class="hide">첫 페이지로 이동하기</span>
													</a>
												</li>
												<li class="prev pager">
													<a href="javascript:getPage(${prevPage},'${board_cd}','${condition}');" title="이전 페이지로 이동하기">
														<span class="hide">이전 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											<c:forEach var="i" begin="1" end="${totalPage}">
												<li>
													<c:choose>
							                        	<c:when test="${i eq currPage}">
							                        		<a class="active" href="javascript:getPage(${i},'${board_cd}','${condition}');">${i}</a>
							                        	</c:when>
							                        	<c:otherwise>
							                        		<a class href="javascript:getPage(${i},'${board_cd}','${condition}');">${i}</a>
							                        	</c:otherwise>
							                        </c:choose>
						                        </li>
											</c:forEach>
											<c:if test="${totalPage > 1 and currPage ne nextPage}">
												<li class="next pager">
													<a href="javascript:getPage(${nextPage},'${board_cd}','${condition}');" title="다음 페이지로 이동하기">
														<span class="hide">다음 페이지로 이동하기</span>
													</a>
												</li>
												<li class="last pager">
													<a href="javascript:getPage(${totalPage},'${board_cd}','${condition}');" title="마지막 페이지로 이동하기">
														<span class="hide">마지막 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
										</ul>
									</div>
                                </div>
                            </div>
                            <!--공지사항2-->
                            <div class="b-btn-wrap">
                       		<%
                           	if (cuserId != null) {
                           		String board_cd = (String) pageContext.getAttribute("board_cd");
                           		String[] bList = {"007101", "007102", "007103", "007104"};
                           		String[] allowAuth = {"010001", "010002", "010003"};
                           		//System.out.println(auth_code);
                           		System.out.println(board_cd);
                        		if(Arrays.asList(bList).contains(board_cd)) {
                            		//if(Arrays.asList(allowAuth).contains(auth_code)) {
                           	%>
                            	<!-- <a class="b-btn-type01 b-btn-c-blue" href="javascript:writeForm();">등록</a> -->
                            <%
                            		}
                        		//} 
                        		else {
                        	%>
                        		<a class="b-btn-type01 b-btn-c-blue" href="javascript:writeForm();">등록</a>
                        	<%
                        		}
                            }
                            %>
                            </div>
                            <form name=admin-form method=post action="">
                                <input type="hidden" name="method">
                                <input type="hidden" name="articles">
                                <input type="hidden" name="confirMode">
                            </form>
                        </div>
                    </div>
                </div>
                <!--공지사항-->

            </div>
            <!--공지사항 본문-->
		</div>
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp"/></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp"/></div>
		</footer>
	</div>
</body>
</html>