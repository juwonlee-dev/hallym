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
	<title>우수동아리</title>
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
        function getPage(data1, data2, data3, data4) {
            var urlpaging = "/topClub.do?";
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
        	var at_cd = "<%=session.getAttribute("at_cd") %>"
        	<%System.err.println("[topClub.jsp]: " + session.getAttribute("at_cd")); %>
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	<%System.err.println("at_cd: " +session.getAttribute("at_cd")); %>
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
        	switch(at_cd) {
        	case "002001":
        		msg = "공연";
        		msg2 = "우수동아리";
        		//code = 1;
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		break;
           	case "002002":
           		msg = "비공연";
           		msg2 = "우수동아리";
           		//code = 1;
           		sidemenu[0].classList.add('active');
           		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
           		break;
        	
        	default:
        		msg = "비공연22";
   				msg2 = "우수동아리22";
   				sidemenu[0].classList.add('active');
           		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
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
		if (session.getAttribute("userVO") != null) {
			cuserVO = (UserVO) session.getAttribute("userVO");
			cuserId = cuserVO.getId();
		}
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
                        <li>구분</li>
                        <li>우수동아리</li>
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
                            <h2>구분</h2>
                        </div>
                    </div>
                    <ul class="lnb-menu jwxe-menu-ul">
                    
<%--                     <c:choose>
                    	<c:when test="${(at_cd eq '002001') or (at_cd eq '002002') or (at_cd eq '002003') or (at_cd eq '002004') 
                    	or (at_cd eq '002005') or (at_cd eq '002006') or (at_cd eq '002007')}">
--%>	                        
						<li class="active"><a href="/topClub.do?at_cd=002001" class="active">공연</a></li>
                        <li><a href="/topClub.do?at_cd=002002">비공연</a></li>
                      
                        
                        <%-- </c:when>
                   </c:choose> --%>
                    </ul>
                </div>
            </div>
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>우수동아리</h3>
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
                            <!-- <div class="bn-search01 type01">
                                <form method="post" action="/clubSearch.do" name="clubForm" enctype="multipart/form-data">
                                    <fieldset class="b-search-wrap">
                                        <legend class="hide">게시글 검색</legend>
                                        <div class="b-sel-box b-cate-basic" style="z-index: 0;">
                                        	<select class="b-sel-title" name="gb_cd">
                                        		<option class=searchOption value="0">전체</option>
								                <option class=searchOption value="001001">증앙동아리</option>
								                <option class=searchOption value="001002">과동아리</option>
								            </select>
								        </div>
                                        <div class="b-sel-box b-cate-basic" style="z-index: 0;">
                                        	<select class="b-sel-title" name="at_cd">
								                <option class=searchOption value="002">전체</option>
                                        		<option class=searchOption value="002001">공연</option>
								                <option class=searchOption value="002002">학술</option>
								                <option class=searchOption value="002003">취미예술</option>
								                <option class=searchOption value="002004">종교</option>
								                <option class=searchOption value="002005">체육</option>
								                <option class=searchOption value="002006">봉사</option>
								                <option class=searchOption value="002007">기타</option>
								            </select>
                                        </div>
                                        <label for="search_val" class="b-sel-label"><span>검색어</span></label>
                                        <input type="text" id="search_val" name="search" value placeholder="검색어를 입력해 주세요">
                                        <button type="submit" class="b-sel-btn">검색</button>
                                    </fieldset>
                                </form> -->
                            </div>
                            <!--검색창-->

                            <!--공지사항1-->
                            <div class="bn-list-common01 type01 bn-common bn-common">
                                <div class="b-top-info-wrap">
                                </div>
                                <table summary="구분" class=board-table>
                                    <caption class="hide">구분 </caption>
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
                                            <th scope="col">순위</th>
                                            <th scope="col">동아리명</th>
                                            <th scope="col">회장</th>
                                            <th scope="col">작성일</th>
                                            <th scope="col" class="b-no-right">개설년도</th>
                                            <th scope="col">파일</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items='${clubList}' var="item" varStatus="status">
									        <tr class>
									            <td class="b-num-box" id="id_${status.count}">
									            ${status.count}
									            	<%-- <c:choose>
									            		<c:when test='${item.FIX_YN eq "Y"}'>
									            			<img src="images/board/ico-notice01.png" border="0" valign="middle" alt="고정글">
									            		</c:when>
									            		<c:otherwise>
									            			${item.SEQ_NO}
									            		</c:otherwise>
									            	</c:choose> --%>
									            </td>
									            <td class="b-td-left">
	                                                <div class="b-title-box">
	                                                    <a href="#" title="${item.club_nm}">
	                                                    	${item.club_nm}
	                                                    </a>
	                                                    <div class="b-etc-box"></div>
	                                                    <div class="b-m-con">
	                                                        <span class="b-writer">
	                                                        	<%-- <c:forEach items='${writerList}' var="user" varStatus="status2">
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
	                                                        	</c:forEach> --%>
	                                                        </span>
	                                                        <span class="b-date">
	                                                        	${item.open_dt}
	                                                        </span>
	                                                        <span class="hit">조회수 </span>
	                                                    	<span class="b-file">첨부파일</span>
	                                                    </div>
	                                                </div>
	                                            </td>
	                                            <td>
                                                   	
	                                            </td>
	                                            <td>
													
												</td>
	                                            <td>${item.open_dt}</td>
	                                            <td class="b-no-right">
	                                            	<span>-</span>
									            </td>
									        </tr>  
								    	</c:forEach>
								    	<c:if test="${clubListCount lt 1}">
									    	<tr>
												<td class="b-no-post" colspan="6">검색된 동아리가 없습니다.</td> 
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
										<%-- <ul>
											<c:if test="${totalPage > 1 and currPage ne prevPage}">
												<li class="first pager">
													<a href="javascript:getPage(1,'${gb_cd}','${at_cd}','${search}');" title="첫 페이지로 이동하기">
														<span class="hide">첫 페이지로 이동하기</span>
													</a>
												</li>
												<li class="prev pager">
													<a href="javascript:getPage(${prevPage},'${gb_cd}','${at_cd}','${search}');" title="이전 페이지로 이동하기">
														<span class="hide">이전 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											<c:forEach var="i" begin="1" end="${totalPage}">
												<li>
													<c:choose>
							                        	<c:when test="${i eq currPage}">
							                        		<a class="active" href="javascript:getPage(${i},'${gb_cd}','${at_cd}','${search}');">${i}</a>
							                        	</c:when>
							                        	<c:otherwise>
							                        		<a class href="javascript:getPage(${i},'${gb_cd}','${at_cd}','${search}');">${i}</a>
							                        	</c:otherwise>
							                        </c:choose>
						                        </li>
											</c:forEach>
											<c:if test="${totalPage > 1 and currPage ne nextPage}">
												<li class="next pager">
													<a href="javascript:getPage(${nextPage},'${gb_cd}','${at_cd}','${search}');" title="다음 페이지로 이동하기">
														<span class="hide">다음 페이지로 이동하기</span>
													</a>
												</li>
												<li class="last pager">
													<a href="javascript:getPage(${totalPage},'${gb_cd}','${at_cd}','${search}');" title="마지막 페이지로 이동하기">
														<span class="hide">마지막 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											
										</ul> --%>
									</div>
                                </div>
                            </div>
                            <!--공지사항2-->
                            <div class="b-btn-wrap">
                       		<%-- <%
                           	if (cuserId != null) {
                           		String board_cd = (String) pageContext.getAttribute("board_cd");
                           		String[] bList = {"007101", "007102", "007103", "007104"};
                           		String[] allowAuth = {"010001", "010002", "010003"};
                           		//System.out.println(auth_code);
                           		System.out.println(board_cd);
                        		if(Arrays.asList(bList).contains(board_cd)) {
                            		if(Arrays.asList(allowAuth).contains(auth_code)) {
                           	%>
                            	<a class="b-btn-type01 b-btn-c-blue" href="javascript:writeForm();">등록</a>
                            <%
                            		}
                        		} else {
                        	%>
                        		<a class="b-btn-type01 b-btn-c-blue" href="javascript:writeForm();">등록</a>
                        	<%
                        		}
                            }
                            %> --%>
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
</body>
</html>