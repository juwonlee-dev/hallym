<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>  

<%@page import="hallym.club.user.vo.UserVO"%>
<%@page import="hallym.club.club.vo.ClubVO"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<title>조회 및 가입</title>
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
    <script type = "text/javascript" src="${pageContext.request.contextPath}/res/board/js/hclubDesign.js" defer></script>
	<script type = "text/javascript" src="${pageContext.request.contextPath}/common/js/datepicker/datepicker.js"></script>
	
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
        	var at_cd = "<%=session.getAttribute("at_cd") %>"
        	var searchFilter2 = document.querySelector("#jwxe_main_content > div > div > div.bn-search01.type01 > form > fieldset > div:nth-child(3) > select").getElementsByTagName('option');
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	<%System.err.println("[clubSearch.jsp] at_cd: " +session.getAttribute("at_cd")); %>
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
        	
        	switch(at_cd) {
        	case "002001":
        		msg = "공연";
        		msg2 = "조회 및 가입";
        		sidemenu[1].classList.add('active');
        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[1].selected = true;
        		break;
        	case "002002":
        		msg = "학술";
        		msg2 = "조회 및 가입";
        		sidemenu[2].classList.add('active');
        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[2].selected = true;
        		break;
        	
        	case "002003":
        		msg = "취미예술";
        		msg2 = "조회 및 가입";
        		sidemenu[3].classList.add('active');
        		sidemenu[3].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[3].selected = true;
        		break;
        	case "002004":
        		msg = "종교";
        		msg2 = "조회 및 가입";
        		sidemenu[4].classList.add('active');
        		sidemenu[4].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[4].selected = true;
        		break;
        	case "002005":
        		msg = "체육";
        		msg2 = "조회 및 가입";
        		sidemenu[5].classList.add('active');
        		sidemenu[5].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[5].selected = true;
        		break;
        	case "002006":
        		msg = "봉사";
        		msg2 = "조회 및 가입";
        		sidemenu[6].classList.add('active');
        		sidemenu[6].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[6].selected = true;
        		break;
        	case "002007":
        		msg = "기타";
        		msg2 = "조회 및 가입";
        		sidemenu[7].classList.add('active');
        		sidemenu[7].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[7].selected = true;
        		break;
        		
        	default:
        		msg = "전체";
   				msg2 = "조회 및 가입";
        		sidemenu[0].classList.add('active');
        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
        		searchFilter2[0].selected = true;
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
                        <li>조회 및 가입</li>
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
                     
						<li class="active"><a href="/clubSearch.do?at_cd=002" class="active">전체</a></li>
                        <li><a href="/clubSearch.do?at_cd=002001">공연</a></li>
                        <li><a href="/clubSearch.do?at_cd=002002">학술</a></li>
                        <li><a href="/clubSearch.do?at_cd=002003">취미예술</a></li>
                        <li><a href="/clubSearch.do?at_cd=002004">종교</a></li>
                        <li><a href="/clubSearch.do?at_cd=002005">체육</a></li>
                        <li><a href="/clubSearch.do?at_cd=002006">봉사</a></li>
                        <li><a href="/clubSearch.do?at_cd=002007">기타</a></li>
                    
                    </ul>
                </div>
            </div>
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>조회 및 가입</h3>
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
                                </form>
                            </div>
                            <!--검색창-->

                            <!--공지사항1-->
                            <div class="bn-list-common01 type01 bn-common bn-common hclub">
                                <div class="b-top-info-wrap">
                                </div>
                                <table summary="구분" class=board-table>
                                    <caption class="hide">구분 </caption>
                                    <colgroup>
                                        <col class="b-col01-hclub">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                           
                                            <!-- 
                                            <th scope="col">사진</th>
                                            <th scope="col">동아리명</th>
                                            <th scope="col">회장</th>
                                            <th scope="col">인원</th>
                                            <th scope="col">개설년도</th>
                                            <th scope="col">기타</th> 
                                             -->
                                            
                                            
                                        </tr>
                                    </thead>
                                    <c:set var="clubList" value="${clubList}"></c:set>
                                    <tbody>
                                    <%
                                    	List<ClubVO> clubList = (List<ClubVO>) pageContext.getAttribute("clubList");
                                       	Date oldDate;
                                       	SimpleDateFormat oldFormat = new SimpleDateFormat("yyyyMMdd");
                                       	SimpleDateFormat newFormat = new SimpleDateFormat("yyyy.MM.dd"); // String 타입을 Date 타입으로 변환
                                       	
                                    	for(int i=0; i<clubList.size(); i++) {
                                    %>
                                    	<tr class="hclubRow">
                                    		<td class = "hclubRowbox">
	                                            <div class="hclublist_photo">
	                                                <img class="logo" src="upload/club/<%=clubList.get(i).getIntro_save_file_nm()%>" onerror="this.src='images/error/error.png'" alt="" style="width: 100px; height: 100px;">
	                                            </div>
	                                            <div class="hclublist_content">
	                                                <div class="hclublist_content_top">
	                                                	<span>#<%=clubList.get(i).getGb_nm()%> #<%=clubList.get(i).getAt_nm()%></span>
	                                                    <%-- <form method="post" action="/clubSignUpForm.do" target="w" onsubmit="return postPopUp();">
	                                                        <input type="hidden" name="club_id" value="<%=clubList.get(i).getClub_id()%>">
	                                                        <input type="hidden" name="club_nm" value="<%=clubList.get(i).getClub_nm()%>">
	                                                        <span><input type="submit" value="가입 신청하기"></span>
	                                                    </form> --%>
	                                                </div>
	                                                <div class="hclublist_content_middle">
	                                                    <strong class="hclub_jung">중</strong>
	                                                    <a href="/clubIntroView.do?club_id=<%=clubList.get(i).getClub_id()%>" target="_self">
	                                                        <strong><%=clubList.get(i).getClub_nm()%></strong>
	                                                    </a>
	                                                </div>
	                                                <div class="hclublist_content_bottom">
	                                                    <span>대표자 : <%=clubList.get(i).getPresident()%></span>
	                                                    <span>개설일 : 
	                                                    <%
	                                                    	try {
			                                                    oldDate = oldFormat.parse(clubList.get(i).getOpen_dt());
			                                                   	out.print(newFormat.format(oldDate));
	                                                    	} catch(Exception e){
	                                                    		out.print(clubList.get(i).getOpen_dt());
	                                                    	}
		                                                 
	                                                    %>
	                                                    </span>
	                                                </div>
	                                                <div class="hclublist_content_bottom2 oneElement">
	                                                    <span>인원수 : <%=clubList.get(i).getCnt()%>명</span>
	                                                    <!-- <span>지도교수 : 미지정</span> -->
	                                                </div>
	                                            </div>
	                                            <span class="hclublist_logo1 oneElement"> <!-- 뱃지가 하나이면 -->
	                                            	<img src="images/main/hclublist_logo1.png">
	                                            	<!-- 한림대학교 로고
	                                            	<img src="
	                                            	https://yt3.ggpht.com/a/AATXAJy-oZNcRRoXt-RnLhCrfJsMfWR_TTaQYhzbebi6uw=s68-c-k-c0x00ffffff-no-rj" style="height: 31px; width: 31px;">
	                                            	-->
	                                            </span>
	                                            <span class="hclublist_logo1_text">동아리연합회<br>중앙동아리입니다.</span>
	                                            <!-- 우수동아리 순위 뱃지
	                                            <span class="hclublist_logo2">
	                                                1
	                                            </span>
	                                            -->
	                                        </td>
                                        <%
                                        	i++;
                                        	if(i < clubList.size()) {
                                        %>
	                                        <td class = "hclubRowbox">
	                                            <div class="hclublist_photo">
	                                                <img class="logo" src="upload/club/<%=clubList.get(i).getIntro_save_file_nm()%>" onerror="this.src='images/error/error.png'" alt="" style="width: 100px; height: 100px;">
	                                            </div>
	                                            <div class="hclublist_content">
	                                                <div class="hclublist_content_top">
	                                                	<span>#<%=clubList.get(i).getGb_nm()%> #<%=clubList.get(i).getAt_nm()%></span>
	                                                    <%-- <form method="post" action="/clubSignUpForm.do" target="w" onsubmit="return postPopUp();">
	                                                        <input type="hidden" name="club_id" value="<%=clubList.get(i).getClub_id()%>">
	                                                        <input type="hidden" name="club_nm" value="<%=clubList.get(i).getClub_nm()%>">
	                                                        <span><input type="submit" value="가입 신청하기"></span>
	                                                    </form> --%>
	                                                </div>
	                                                <div class="hclublist_content_middle">
	                                                    <strong class="hclub_jung">중</strong>
	                                                    <a href="/clubIntroView.do?club_id=<%=clubList.get(i).getClub_id()%>" target="_self">
	                                                        <strong><%=clubList.get(i).getClub_nm()%></strong>
	                                                    </a>
	                                                </div>
	                                                <div class="hclublist_content_bottom">
	                                                    <span>대표자 : <%=clubList.get(i).getPresident()%></span>
	                                                    <span>개설일 : 
	                                                    <%
		                                                    try {
			                                                    oldDate = oldFormat.parse(clubList.get(i).getOpen_dt());
			                                                   	out.print(newFormat.format(oldDate));
	                                                    	} catch(Exception e){
	                                                    		out.print(clubList.get(i).getOpen_dt());
	                                                    	}
	                                                    %>
	                                                    </span>
	                                                </div>
	                                                <div class="hclublist_content_bottom2 oneElement">
	                                                    <span>인원수 : <%=clubList.get(i).getCnt()%>명</span>
	                                                    <!-- <span>지도교수 : 미지정</span> -->
	                                                </div>
	                                            </div>
	                                            <span class="hclublist_logo1 oneElement"> <!-- 뱃지가 하나이면 -->
	                                            	<img src="images/main/hclublist_logo1.png">
	                                            	<!-- 한림대학교 로고
	                                            	<img src="
	                                            	https://yt3.ggpht.com/a/AATXAJy-oZNcRRoXt-RnLhCrfJsMfWR_TTaQYhzbebi6uw=s68-c-k-c0x00ffffff-no-rj" style="height: 31px; width: 31px;">
	                                            	-->
	                                            </span>
	                                            <span class="hclublist_logo1_text">동아리연합회<br>중앙동아리입니다.</span>
	                                            <!-- 우수동아리 순위 뱃지
	                                            <span class="hclublist_logo2">
	                                                1
	                                            </span>
	                                            -->
	                                        </td>
                                        <%
                                        	}
                                        %>
                                    	</tr>
                                    <%
                                    	}
                                    %>
								    	<c:if test="${clubListCount lt 1}">
									    	<tr class="hclubRow clubRow">
	                                    		<td class = "hclubRowbox clubRow">
                                                    <div class="hclublist_photo">
                                                        <img class="logo" src="images/main/error.png" onerror="this.src='images/error/error.png'" alt="" style="width: 100px; height: 100px;">
                                                    </div>
                                                    <div class="hclublist_content">
                                                        <div class="hclublist_content_top">
                                                            <span></span>
                                                        </div>
                                                        <div class="hclublist_content_middle">
                                                            <strong>동아리를 찾을 수 없습니다.</strong>
                                                        </div>
                                                        
                                                    </div>
                                                </td>
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
											
										</ul>
									</div>
                                </div>
                            </div>
                            <!--공지사항2-->
                            <div class="b-btn-wrap">
                       		
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
	
	<script>
		var winRef;
		function postPopUp() {
		<%if (cuserId == null) {%>
			alert("로그인이 필요합니다.");
			location.href='/login.do';
			return false;
		<%} else {%>
		if(winRef == null){
			winRef = window.open("/clubSignUpForm.do", 'w', 'width=900,height=650,location=no,status=no');
			return true;
			
		} else {
			if(winRef.closed == false){
				winRef.focus();
				return true;
			}
			else {
				winRef = window.open("/clubSignUpForm.do", 'w', 'width=900,height=650,location=no,status=no');
				return true;
			}
		}
		<%}%>
		}
	</script>
</body>
</html>