<%@page import="hallym.club.budget.vo.BudgetVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>한림대학교 동아리 커뮤니티</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<!--font awesome-->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.15.1/css/all.css"
	integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp"
	crossorigin="anonymous">
<!--css-->
<link rel="canonical"
	href="http://league.hallym.ac.kr/league/board/notice.do" />
<link rel="stylesheet" type="text/css" href="common/cms.css" />
<link rel="stylesheet" type="text/css" href="res/league/css/layout.css" />
<!--[if IE 8]>
            <link rel="stylesheet" type="text/css" href="/_common/ie8.css" />
        <![endif]-->
<link rel="stylesheet" type="text/css" href="res/league/css/m-mn.css" />
<link rel="stylesheet" type="text/css" href="common/css/toastr.css" />
<link rel="stylesheet" type="text/css"
	href="common/css/ui.datepicker.css" />
<link rel="stylesheet" type="text/css"
	href="common/css/jquery.ui-selectBox.css" />
<link rel="stylesheet" type="text/css" href="res/board/css/board.css" />
<link rel="stylesheet" type="text/css" href="res/board/css/type01.css" />
<link rel="stylesheet" type="text/css"
	href="custom/css/board.common.css" />
<link rel="stylesheet" type="text/css" href="res/league/css/user.css" />
<link type="text/css" rel="stylesheet" charset="UTF-8"
	href="https://translate.googleapis.com/translate_static/css/translateelement.css">

<!--js-->
<script type="text/javascript" src="common/js/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript"
	src="common/js/jquery/jquery-ui-1.11.4.min.js"></script>
<script defer="" type="text/javascript"
	src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
<script type="text/javascript" charset="UTF-8"
	src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
<script type="text/javascript" charset="UTF-8"
	src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
<script type="text/javascript">
	//<![CDATA[
	var _thisHost = location.protocol + '//' + location.host, _thisUrl = document.location.href, _so_ = false, _cur_menu_cd = '4157', _edit_content = false, front_page_edit = true, zooInOutMode = 'font', _reouscePath = '/_res/league/', editorVendor = 'froala', sslYN = 'N', sslPort = '8443', servicePort = '', developMode = false, device = 'pc', isMobile = false, _cfgUseDevMode = false, _siteId = 'league', printSelector = '#jwxe_main_content', ctx = '', rootPath = '', locale = 'ko', localeScriptPath = '/_custom/hallym/resource/js/', maxCount = 0;

	//]]>
</script>
<script type="text/javascript" src="common/cms.js"></script>
<script type="text/javascript" src="common/js/menu/menu.js"></script>
<script type="text/javascript" src="res/league/js/m-mn.js"></script>
<script type="text/javascript" src="common/js/toastr.js"></script>
<script type="text/javascript"
	src="common/js/jquery-plugin/selectBox.min.js"></script>
<script type="text/javascript" src="custom/js/board.common.js"></script>
<script type="text/javascript" src="res/board/js/board.js"></script>
<script type="text/javascript" src="res/league/js/user.js"></script>
<script type="text/javascript" src="res/board/js/hclubDesign.js" defer></script>
<script type="text/javascript" src="common/js/datepicker/datepicker.js"
	defer></script>
<style>
</style>
</head>
<body>

	<%-- <%
		request.setCharacterEncoding("UTF-8");

		String io_gb_cd = "009001";

		if (request.getParameter("io_gb_cd") != null) {
			io_gb_cd = request.getParameter("io_gb_cd");
		}

		int club_id = 1;

		if (request.getParameter("club_id") != null) {
			club_id = Integer.parseInt(request.getParameter("club_id"));
		}
	%>

	<script>
		function move_url(x) {
			var io_gb_cd = x.value;
			var url = "clubBudget.do?club_id=" +
	<%=club_id%>
		+ "&io_gb_cd="
					+ io_gb_cd;
			location.href = url;
		}
	</script> --%>
	
	
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
						<li><a href="/clubIntro.do?club_id=${club_id}"><img
								src="images/common/ico-home.png" alt="home"></a></li>
						<li>활동</li>
						<li class="clubonly">예산 관리</li>
					</ul>
				</div>
			</div>
		</div>
		<div class="sub-container newclub">

               <!--본문-->
               <h1><i class="fas fa-search-dollar"></i>예산 관리</h1>

            <div class="tabBtn">
				<a href="#jwxe_main_content_incomeList" class="active">수입</a>
				<a href="#jwxe_main_content_expenditureList">지출</a>
				<a href="#jwxe_main_content_refereeInfo">월별보고서</a>
			</div>
		
			<div class="content hleagueTab money" id="jwxe_main_content_incomeList">
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
						<!-- <form method="post" action="/" name="boardForm">
							<fieldset class="b-search-wrap">
								<legend class="hide">게시글 검색</legend>
								<input type="hidden" name="mode" value="list">
		 
								
							</fieldset>
						</form>--> 
					</div> 
					<!--검색창-->
					<form method=post action="clubBudgetAction.do">
						<input type="hidden" value="${club_id}" name="club_id">
						<input type="hidden" value="${io_gb_cd}" name="io_gb_cd">
						<div class="bn-list-common01 type01 bn-common bn-common rowplus">
						<div class="b-top-info-wrap"></div>
						<table summary="게시판 > Notice" class="board-table" id="contentTable2">
							<caption class="hide">게시판 &gt; Notice</caption>
							<colgroup>
								<col class="b-col01 articleList">
								<col class="b-col02 articleList">
                                      <col class="b-col03 articleList">
                                      <col class="b-col04 articleList">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="hver2">
										<input type="checkbox" id= "checkArticle" name="ff">
									</th>
									<th scope="col" class="hver2">날짜</th>
									<th scope="col" class="hver2">금액</th>
									<th scope="col" class="hver2">사용내역</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
								<c:when test="${not empty incomeList}">
									<c:forEach items='${incomeList}' var="item" varStatus="status">
										<tr> 
											<td><input type="checkbox" id="checkArticle">
											</td>
											<td>
												<input type="text" value="${item.getUse_dt()}"
													name="income_use_dt">
											</td>
											<td>
												<input type="text" value="${item.price}"
													name="income_price">
											</td>
											<td>
												 <input type="text"
													value="${item.getContents()}"
													name="income_contents">
											</td>
										</tr> 
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td class="b-no-post" colspan="4">등록된 예산이 없습니다.</td>
								</c:otherwise>
							</c:choose> 
								 
                               </tbody>
                               <thead>
                               	
								<tr class="mobile-show">	
									<th scope="col" class="hver2"></th>
									<th scope="col" class="hver2">수입합계</th>
                                       <th scope="col" class="hver2">${incomeTotalPrice}</th>
                                       <th scope="col" class="hver2"></th>
								</tr>
							</thead>
						</table>          
						</div>
					<!--공자사항1-->
					<c:if test="${empty cdn}">
						<c:if test="${isStaff eq true}">
						<div class="b-btn-wrap leagueKind">
							<button type="button" id = "moneyAdd2" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2" >추가</button>
							<button type="button" id = "moneyDel2" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2" >삭제</button>
							<button type="submit" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2">저장</button>
						</div>
						</c:if>
					</c:if>
					</form>
					<!--공지사항2-->
					<div class="b-paging01 type03">
                              <div class="b-paging01 type01">
                                  <div class="b-paging-wrap">
								<ul>		
									<!-- 페이징 -->
								</ul>
							</div>
                              </div>
					</div>
					
					<div class="b-btn-wrap"></div>
                          <form name="admin-form" method="post" action="">
                              <input type="hidden" name="method">
                              <input type="hidden" name="articles">
                              <input type="hidden" name="confirMode">
					</form>
				</div>
			</div>
           	</div>
            	
			
			 <div class="content hleagueTab money" id="jwxe_main_content_expenditureList">
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
						<!-- <form method="post" action="/" name="boardForm">
							<fieldset class="b-search-wrap">
								<legend class="hide">게시글 검색</legend>
								<input type="hidden" name="mode" value="list">
		 
								
							</fieldset>
						</form>--> 
					</div> 
					<!--검색창-->
					<form method=post action="clubBudgetAction.do">
						<input type="hidden" value="${club_id}" name="club_id">
						<input type="hidden" value="${io_gb_cd}" name="io_gb_cd">
						<div class="bn-list-common01 type01 bn-common bn-common rowplus">
						<div class="b-top-info-wrap"></div>
						<table summary="게시판 > Notice" class="board-table" id="contentTable3">
							<caption class="hide">게시판 &gt; Notice</caption>
							<colgroup>
								<col class="b-col01 articleList">
								<col class="b-col02 articleList">
                                      <col class="b-col03 articleList">
                                      <col class="b-col04 articleList">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="hver2">
										<input type="checkbox" id= "checkArticle" name="ff">
									</th>
									<th scope="col" class="hver2">날짜</th>
									<th scope="col" class="hver2">금액</th>
									<th scope="col" class="hver2">사용내역</th>
								</tr>
							</thead>
							<tbody>
							<c:choose>
								<c:when test="${not empty expenseList}">
									<c:forEach items='${expenseList}' var="item" varStatus="status">
										<tr> 
											<td><input type="checkbox" id="checkArticle">
											</td>
											<td>
												<input type="text" value="${item.getUse_dt()}"
													name="expense_use_dt">
											</td>
											<td>
												<input type="text" value="${item.price}"
													name="expense_price">
											</td>
											<td>
												 <input type="text"
													value="${item.getContents()}"
													name="expense_contents">
											</td>
										</tr> 
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td class="b-no-post" colspan="4">등록된 예산이 없습니다.</td>
								</c:otherwise>
							</c:choose> 
								 
                               </tbody>
                               <thead>
                               	
								<tr class="mobile-show">	
									<th scope="col" class="hver2"></th>
									<th scope="col" class="hver2">지출합계</th>
                                       <th scope="col" class="hver2">${expenseTotalPrice}</th>
                                       <th scope="col" class="hver2"></th>
								</tr>
							</thead>
						</table>          
						</div>
					<!--공자사항1-->
					<c:if test="${empty cdn}">
						<c:if test="${isStaff eq true}">
						<div class="b-btn-wrap leagueKind">
							<button type="button" id = "moneyAdd3" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2" >추가</button>
							<button type="button" id = "moneyDel3" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2" >삭제</button>
							<button type="submit" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2">저장</button>
						</div>
						</c:if>
					</c:if>
					</form>
					<!--공지사항2-->
					<div class="b-paging01 type03">
                              <div class="b-paging01 type01">
                                  <div class="b-paging-wrap">
								<ul>		
									<!-- 페이징 -->
								</ul>
							</div>
                              </div>
					</div>
					
					<div class="b-btn-wrap"></div>
                          <form name="admin-form" method="post" action="">
                              <input type="hidden" name="method">
                              <input type="hidden" name="articles">
                              <input type="hidden" name="confirMode">
					</form>
				</div>
			</div>
           	</div>
			
			<div class="content hleagueTab money" id="jwxe_main_content_refereeInfo">
				<div class="common" id="jwxe_main_content_totalList">
					<!--검색창-->
					<button class="moneyBtn">통계</button> 
					<div class="bn-search01 type01">
						<form method="post" action="/clubBudget.do?club_id=${club_id}" name="boardForm">
							<fieldset class="b-search-wrap">
								<legend class="hide">게시글 검색</legend>
								<input type="hidden" name="mode" value="list">
								<div class="b-sel-box b-cate-basic league" style="z-index: 0;">
									<select class="b-sel-title leagueform ver2" name="year">
										<option class="searchOption" value="0">전체(년)</option>
										<option class="searchOption" value="2020">2020년</option>
										<option class="searchOption" value="2019">2019년</option>
										<option class="searchOption" value="2018">2018년</option>
										<option class="searchOption" value="2017">2017년</option>
									</select>
									<select class="b-sel-title leagueform ver2" name="month">
										<option class="searchOption" value="0">전체(월)</option>
										<option class="searchOption" value="01">1월</option>
										<option class="searchOption" value="02">2월</option>
										<option class="searchOption" value="03">3월</option>
										<option class="searchOption" value="04">4월</option>
										<option class="searchOption" value="05">5월</option>
										<option class="searchOption" value="06">6월</option>
										<option class="searchOption" value="07">7월</option>
										<option class="searchOption" value="08">8월</option>
										<option class="searchOption" value="09">9월</option>
										<option class="searchOption" value="10">10월</option>
										<option class="searchOption" value="11">11월</option>
										<option class="searchOption" value="12">12월</option>
									</select>
									<label for="money_val" class="b-sel-label"><span>검색어</span></label>
									<button type="submit" id="searchBtn" style="display: none;"></button>
									<script>
										function doSubmit() {
											document.getElementById('searchBtn').click();
											document.getElementsByClassName("tabBtn")[0].getElementsByTagName("a")[2].click();
										}
									</script>
									<button type="button" class="b-sel-btn leagueSearchBtn ver2" onclick="doSubmit();">검색</button>
								</div> 
								
							</fieldset>
						</form>
					</div>
					<!--검색창-->
					
					<div class="bn-list-common01 type01 bn-common bn-common">
						<div class="b-top-info-wrap"></div>
						<table summary="게시판 > Notice" class="board-table">
							<caption class="hide">게시판 &gt; Notice</caption>
							<colgroup>
								<col class="b-col01 dateAllList">
								<col class="b-col02 dateAllList">
								<col class="b-col03 dateAllList">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="hver2">수입</th>
									<th scope="col" class="hver2">지출</th>
									<th scope="col" class="hver2">총합계</th>
								</tr>
							</thead>
							<tbody>
								<!-- 예산 없을때
										<td class="b-no-post" colspan="4">
											등록된 예산이 없습니다.		
										</td>
								-->
								<tr class="">
									<!-- 수입 -->
									<td class="b-num-box">
										<span>${incomeTotalPrice2}
										</span>
									</td>
									<td class="b-td-left leagueKind">
										<!-- 지출 -->
										<span>${expenseTotalPrice2}</span>
										<div class="b-title-box league">
											<!--반응형 모바일 부분-->
												<div class="b-etc-box leagueKind">
													<span>총합계: ${totalPrice}</span>
												</div>
												<div class="b-m-con">
													<span class="b-writer">수입: ${incomeTotalPrice2}</span>
													<span class="b-writer">지출: ${expenseTotalPrice2}</span>          
												</div>
											</div>
										</td>
									<!-- 총합 -->
									<td>${totalPrice}</td>
								</tr>
							
							</tbody>
						</table>          
					</div>
					<!--공자사항1-->						
					<div class="b-btn-wrap"></div>
					<form name="admin-form" method="post" action="">
						<input type="hidden" name="method">
						<input type="hidden" name="articles">
						<input type="hidden" name="confirMode">
					</form>
				</div>
				<div class="common" id="jwxe_main_content_incomeList2">
					<!--검색창-->
					<button class="moneyBtn">수입</button>
					<!--검색창-->
					
					<div class="bn-list-common01 type01 bn-common bn-common">
						<div class="b-top-info-wrap"></div>
						<table summary="게시판 > Notice" class="board-table">
							<caption class="hide">게시판 &gt; Notice</caption>
							<colgroup>
								<col class="b-col01 dateList">
								<col class="b-col02 dateList">
								<col class="b-col03 dateList">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="hver2">날짜</th>
									<th scope="col" class="hver2">금액</th>
									<th scope="col" class="hver2">사용내역</th>
								</tr>
							</thead>
							<tbody>
								<!-- 수입 없을때
										<td class="b-no-post" colspan="3">
											등록된 물품이 없습니다.		
										</td>
										-->
							<c:choose>
								<c:when test="${not empty incomeList2}">
									<c:forEach items='${incomeList2}' var="item" varStatus="status">
									
									<tr class="">
									<td class="b-num-box">
										<span>${item.getUse_dt()}
										</span>
									</td>
									<td class="b-td-left leagueKind">
									<span>${item.str_price}</span>
									<div class="b-title-box league">
										<!--반응형 모바일 부분-->
											<div class="b-etc-box leagueKind">
												<span>금액: ${item.str_price}</span>
											</div>
											<div class="b-m-con">
												<span class="b-writer">날짜: ${item.getUse_dt()}</span>
												<span class="b-writer">사용내역: ${item.getContents()}</span>          
											</div>
										</div>
									</td>
									<td>${item.getContents()}</td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td class="b-no-post" colspan="4">등록된 예산이 없습니다.</td>
								</c:otherwise>
							</c:choose> 
								
							</tbody>
						</table>          
					</div>
					<!--공자사항1-->

					<!--공지사항2-->
					<div class="b-paging01 type03">
						<div class="b-paging01 type01">
							<div class="b-paging-wrap">
								<ul>	
									<!-- 페이징  -->
									
								</ul>
							</div>
						</div>
					</div>
					
					<div class="b-btn-wrap"></div>
					<form name="admin-form" method="post" action="">
						<input type="hidden" name="method">
						<input type="hidden" name="articles">
						<input type="hidden" name="confirMode">
					</form>
				</div>
				<div class="common" id="jwxe_main_content_expenditureList2">
					<!--검색창-->
				<button class="moneyBtn">지출</button>
					<!--검색창-->
					
					<div class="bn-list-common01 type01 bn-common bn-common">
						<div class="b-top-info-wrap"></div>
						<table summary="게시판 > Notice" class="board-table">
							<caption class="hide">게시판 &gt; Notice</caption>
							<colgroup>
								<col class="b-col01 dateList">
								<col class="b-col02 dateList">
								<col class="b-col03 dateList">
							</colgroup>
							<thead>
								<tr>
									<th scope="col" class="hver2">날짜</th>
									<th scope="col" class="hver2">금액</th>
									<th scope="col" class="hver2">사용내역</th>
								</tr>
							</thead>
							<tbody>
							
							<c:choose>
								<c:when test="${not empty expenseList2}">
									<c:forEach items='${expenseList2}' var="item" varStatus="status">
									
									<tr class="">
									<td class="b-num-box">
										<span>${item.getUse_dt()}
										</span>
									</td>
									<td class="b-td-left leagueKind">
									<span>${item.str_price}</span>
									<div class="b-title-box league">
										<!--반응형 모바일 부분-->
											<div class="b-etc-box leagueKind">
												<span>금액: ${item.str_price}</span>
											</div>
											<div class="b-m-con">
												<span class="b-writer">날짜: ${item.getUse_dt()}</span>
												<span class="b-writer">사용내역: ${item.getContents()}</span>          
											</div>
										</div>
									</td>
									<td>${item.getContents()}</td>
									</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<td class="b-no-post" colspan="4">등록된 예산이 없습니다.</td>
								</c:otherwise>
							</c:choose> 
							</tbody>
						</table>          
					</div>
					<!--공자사항1-->
 
					<!--공지사항2-->
					<div class="b-paging01 type03">
						<div class="b-paging01 type01">
							<div class="b-paging-wrap">
								<ul>
									<!-- 페이징  -->
								</ul>
							</div>
						</div>
					</div>
					
					<div class="b-btn-wrap"></div>
					<form name="admin-form" method="post" action="">
						<input type="hidden" name="method">
						<input type="hidden" name="articles">
						<input type="hidden" name="confirMode">
					</form>
				</div>
               </div>
			
        </div>	
	
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp" /></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp" /></div>
		</footer>
	</div>
	
	
</body>

</html>