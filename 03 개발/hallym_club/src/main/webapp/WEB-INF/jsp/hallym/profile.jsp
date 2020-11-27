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
	<title>한림대학교 동아리</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">
	<%-- <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css"> --%>
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/page.css">
	<style>
	.main {
		float: left;
		position: relative;
		width: 100%;
		height: 100%;
		margin-left: 20px;
	}
	
	table.type04 {
		border-collapse: collapse;
		text-align: center;
		line-height: 1.5;
		border-left: 1px solid #ccc;
		border-top: 3px solid #369;
		margin: auto;
		text-align: center;
		width: 100%;
		font-size: 25px;
	}
	
	table.type04 th {
		padding: 3px;
		font-weight: bold;
		vertical-align: top;
		color: #153d73;
		border-right: 1px solid #ccc;
		border-bottom: 1px solid #ccc;
	}
	
	table.type04 td {
		padding: 3px;
		border-right: 1px solid #ccc;
		border-bottom: 1px solid #ccc;
		vertical-align: middle;
	}
	
	.mainLeft {
		border: 1px solid #ccc;
		margin: 0 auto;
		display: block;
		padding: 10px;
		min-height: 75%;
		/*width: 100%; */
		overflow: auto;
	}
	
	.club_manage {
		text-decoration: none;
		color: black;
	}
	
	.club_manage:hover {
		text-decoration: underline;
		color: blue;
	}
	
	.club_picture {
		text-decoration: none;
		color: black;
	}
	
	.club_picture:hover {
		text-decoration: underline;
		color: blue;
	}
	
	</style>
	<!--link-->
	<link type="text/css" rel="stylesheet" charset="UTF-8"
		href="https://translate.googleapis.com/translate_static/css/translateelement.css">
	
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/common/cms.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/league/css/layout.css" />
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
	   
        $(document).ready(function() {
        	var page_cd = "<%=session.getAttribute("page_cd") %>"
        	var sidemenu = document.querySelector("#item_body > div > div.sub-container > div.lnb-wrap > div > ul").getElementsByTagName('li');
        	var activeNum = 0;
        	<%System.err.println("[profile.jsp] page_cd: " +session.getAttribute("page_cd")); %>
        	for(var i=0; i<sidemenu.length; i++) {
        		if(sidemenu[i].className == "active") {
        			activeNum = i;
        			break;
        		}
        	}
        	var msg = "";
        	var msg2 = "";
        	
    		sidemenu[activeNum].classList.remove('active');
    		sidemenu[activeNum].getElementsByTagName("a")[0].classList.remove("active");
        	switch(page_cd) {
	        	case "014001":
	        		msg = "가입신청 현황";
	        		msg2 = "마이 페이지";
	        		sidemenu[1].classList.add('active');
	        		sidemenu[1].getElementsByTagName("a")[0].classList.add("active");
	        		break;
	        	case "014002":
	        		msg = "개설신청 현황";
	        		msg2 = "마이 페이지";
	        		sidemenu[2].classList.add('active');
	        		sidemenu[2].getElementsByTagName("a")[0].classList.add("active");
	        		break;
	        	case "014003":
	        		msg = "내 정보 수정";
	        		msg2 = "마이 페이지";
	        		sidemenu[0].classList.add('active');
	        		sidemenu[0].getElementsByTagName("a")[0].classList.add("active");
	        		break;
	        	default:
	        		msg = "Null";
	        		msg2 = "마이 페이지";
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
                        <li>마이 페이지</li>
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
                        <li><a href="/profile.do">내 정보 수정</a></li>
						<li class="active"><a href="/profile.do?page_cd=014001" class="active">가입신청 현황</a></li>
                        <li><a href="/profile.do?page_cd=014002">개설신청 현황</a></li>
                    
                    </ul>
                </div>
            </div>
            <!--메뉴바-->
			<!--공지사항 본문-->
            <div class="content-wrap">
                <div class="title">
                    <div class="jwxe_mnu_template jw-relative page-title">
                        <h3>마이 페이지</h3>
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
                        <div class="bn-write-common01 type01">
                            <!--검색창-->
                            <!--검색창-->

			                <!--공지사항1-->
			                <c:choose>
			                	<c:when test="${page_cd  eq '014001'}">
			                	<div class="common">
                                </div>
                                <!--검색창-->
                            
                                <!--공지사항1-->
                                <div class="bn-list-common01 type01 bn-common bn-common hclub">
                                    <div class="b-top-info-wrap">
                                    </div>
									<table summary="구분" class="board-table">
                                        <caption class="hide">구분 </caption>
                                        <colgroup>
                                            <col class="b-col01-hclub">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <!-- 
                                                <th scope="col">순위</th>
                                                <th scope="col">동아리명</th>
                                                <th scope="col">회장</th>
                                                <th scope="col">회원수</th>
                                                <th scope="col" class="b-no-right">개설년도</th>
                                                <th scope="col">기타</th> 
                                                -->
                                            </tr>
                                        </thead>
                                        
                                        <tbody>
                                        <c:choose>
											<c:when test="${not empty waitJoinClub }">
												<c:forEach items='${waitJoinClub}' var="item" varStatus="status">
												<form method="post" action="applyClubDeleteAction.do">
												<input type="hidden" name="club_id" value="${item.club_id}">
	                                            <tr class="hclubRow clubRow">
	                                                <td class="hclubRowbox clubRow">
	                                                    <div class="hclublist_photo">
	                                                        <img class="logo" src="upload/club/${item.intro_save_file_nm}" onerror="this.src='images/error/error.png'" alt="" style="width: 100px; height: 100px;">
	                                                    </div>
	                                                    <div class="hclublist_content">
	                                                        <div class="hclublist_content_top">
	                                                            <span>#${item.club_gb_cd} #${item.club_at_cd}</span>
	                                                            
	                                                        </div>
	                                                        <div class="hclublist_content_middle">
	                                                            <strong class="hclub_jung">중</strong>
	                                                            <a href="/clubIntroView.do?club_id=${item.club_id}" target="_self">
	                                                                <strong>${item.club_nm}</strong>
	                                                            </a>
	                                                        </div>
	                                                        <div class="hclublist_content_bottom">
	                                                            <span>대표자 : ${item.president}</span>
	                                                            <span>개설일 : 
	                                                            ${item.open_dt}
	                                                            </span>
	                                                        </div>
	                                                        <div class="hclublist_content_bottom2 oneElement">
	                                                            <span>인원수 : ${item.cnt}</span>
	                                                            <!-- <span>지도교수 : 미지정</span> -->
	                                                        </div>
	                                                    </div>
	                                                    <div class="hclub_btn"> 
	                                                    <!--<button type="submit">신청취소</button> -->
                                                    	<button type="submit" value="신청 취소" name="submit"
														onclick="return confirm('${item.club_nm} 가입 신청을 취소하시겠습니까?');">신청취소</button>
	                                                    </div>
	                                                </td>
	                                            </tr>
												</form>
                                        		</c:forEach>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
                                        </tbody>
                                    </table>
								</div> <!-- end of  bn-list-common01 type01 bn-common bn-common hclub-->
			                	</c:when>
			                	<c:when test="${page_cd  eq '014002'}">
			                	<div class="common">
	                             </div>
									<div class="bn-list-common01 type01 bn-common bn-common hclub">
                                    	<div class="b-top-info-wrap">
                                    	</div>
										<table summary="구분" class="board-table">
                                        <caption class="hide">구분 </caption>
                                        <colgroup>
                                            <col class="b-col01-hclub">
                                        </colgroup>
                                        <thead>
                                            <tr>
                                                <!-- 
                                                <th scope="col">순위</th>
                                                <th scope="col">동아리명</th>
                                                <th scope="col">회장</th>
                                                <th scope="col">회원수</th>
                                                <th scope="col" class="b-no-right">개설년도</th>
                                                <th scope="col">기타</th> 
                                                -->
                                            </tr>
                                        </thead>
                                        <tbody>
                                        <c:choose>
											<c:when test="${not empty waitRegisterClubList}">
												<c:forEach items='${waitRegisterClubList}' var="item" varStatus="status">
	                                            <tr class="hclubRow clubRow">
	                                                <td class="hclubRowbox clubRow">
	                                                    <div class="hclublist_photo">
	                                                        <img class="logo" src="upload/club/${item.intro_save_file_nm}" onerror="this.src='images/error/error.png'" alt="" style="width: 100px; height: 100px;">
	                                                    </div>
	                                                    <div class="hclublist_content">
	                                                        <div class="hclublist_content_top">
	                                                            <span>#${item.club_gb_cd} #${item.club_at_cd}</span>
	                                                            
	                                                        </div>
	                                                        <div class="hclublist_content_middle">
	                                                            <strong class="hclub_jung">중</strong>
	                                                            <a href="" target="_self">
	                                                                <strong>${item.club_nm}</strong>
	                                                            </a>
	                                                        </div>
	                                                        <div class="hclublist_content_bottom">
	                                                            <span>대표자 : ${item.president}</span>
	                                                            <span>개설일 : 
	                                                            ${item.open_dt}
	                                                            </span>
	                                                            
	                                                        </div>
	                                                        <div class="hclublist_content_bottom2 oneElement">
	                                                         	
	                                                            <!-- <span>인원수 : 28명</span> -->
	                                                            <!-- <span>지도교수 : 미지정</span> -->
	                                                        </div>
	                                                    </div>
	                                                    <div class="hclub_btn">
	                                                    <!-- <button type="submit">신청취소</button> -->
	                                                    <form name="form" method="post" action="applyClubRegisterDeleteAction.do">
															<input type="hidden" name="club_id" value="${item.club_id}">
															<button type="submit" value="신청 취소" name="submit" 
															onclick="return confirm('${item.club_nm} 동아리 등록을 취소하시겠습니까?');">신청취소</button>
														</form>
	                                                    </div>
	                                                </td>
	                                            </tr> 
                                        		</c:forEach>
											</c:when>
											<c:otherwise>
											</c:otherwise>
										</c:choose>
                                        </tbody>
                                    </table>
								</div> <!-- end of  bn-list-common01 type01 bn-common bn-common hclub-->
			                	</c:when>
			                	<c:when test="${page_cd eq '014003'}">
			                	<div class="main">
			                	
									<form name="writeForm" method="post" action="clubMyInfoAction.do">
									<fieldset>
										<legend class="hide"></legend>
										<input name="csrfToken" type="hidden" value="mkktrnrrxrznvsjcvvyu">									
										<input type="hidden" name="articleNo" value="">
										<input name="articleNo" type="hidden" value="">
										<input name="parentNo" type="hidden" value="0">
										<input name="htmlYn" type="hidden" value="Y">
										<input type="hidden" name="plan" value="${plan}">
										<input type="hidden" name="hope" value="${hope}">
										<input type="hidden" name="club_id" value="${club_id}">
										<h2>
											
										</h2>
										
										<div class="b-table-wrap">
											<div class="b-table-box type01 b-subject-box">
												<div class="b-row-box">
													<div class="b-title-box b-required">
														<label for="articleTitle">학과</label>
													</div>
													<div class="b-con-box">
														 
														<input class="jwvalid-must-title b-input type01" 
														type="text" id="major" 
														name="major" value="${userVO.major}" required readOnly>
													</div>
												</div>
											</div>
										</div>
										
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">학번</label>
												</div>
												<div class="b-con-box">
													 
													<input class="jwvalid-must-title b-input type01" 
													type="text" id="student_id" 
													name="student_id" value="${userVO.id}" required readOnly>
												</div>
											</div>
										</div>
										
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">학년</label>
												</div>
												<div class="b-con-box">
													 
													<input class="jwvalid-must-title b-input type01" 
													type="text" id="grade" 
													name="grade" value="${userVO.grade}" required readOnly>
												</div>
											</div>
										</div>
									
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">성명</label>
												</div>
												<div class="b-con-box">
													 
													<input class="jwvalid-must-title b-input type01" 
													type="text" id="name" 
													name="name" value="${userVO.name}" required readOnly>
												</div>
											</div>
										</div>
									
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">전화번호 </label>
													<%--
													<span style="font-size: 7px; display: block;">(${phone_no})</span> 
													--%>
												</div>
												<div class="b-con-box">
													 
													<input class="jwvalid-must-title b-input type01" 
													type="text" id="phone_no" 
													name="phone_no" value="${phone_no}" placeholder="${userVO.phoneNumber}" required >
												</div>
											</div>
										</div>
									
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box b-required">
													<label for="articleTitle">이메일 </label>
													<%-- 
													<span style="font-size: 7px; display: block;">(${email})</span> 
													--%>
												</div>
												<div class="b-con-box">
													 
													<input class="jwvalid-must-title b-input type01" 
													type="text" id="email" 
													name="email" value="${email}" placeholder="${userVO.e_mail}" required >
												</div>
											</div> 
										</div>
										<div style="margin-top: 20px" class="bottom">위 정보는 기본적으로 통합정보시스템을 기반으로 하지만, 전화번호와 이메일의 경우 통합정보시스템과는 독립적으로 저장됩니다.</div>
										<div class="bottom">귀하가 수정한 내용은 귀하의 정보임에 틀림이 없으며, 나의 정보를 수정 하겠습니다.</div>
										<div class="bottom">이에 동의하지 않을 경우 거부할 수 있으나 서비스 이용이 제한될 수 있습니다.</div>
							 
										<div class="b-btn-wrap">
											<button type="submit" class="b-btn-type01 b-btn-c-blue submit" onclick="return confirm('동의하시겠습니까?');">수정 완료</button>
										</div>	  
										
										</fieldset> 
									</form>
								</div>
			                	</c:when>
			                	
			                </c:choose>
			                
                            <!--공지사항2-->
                            <div class="b-paging01 type03">
                                <div class="b-paging01 type01">
                                    
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
	
</body>
</html>