<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
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
	    var _thisHost = location.protocol+'//'+location.host, _thisUrl = document.location.href
	    ,_so_ = false,_cur_menu_cd = '4157',_edit_content = false,front_page_edit = true,zooInOutMode = 'font'
	    ,_reouscePath = '/_res/league/',editorVendor = 'froala',sslYN = 'N',sslPort = '8443',servicePort = ''
	    ,developMode = false,device='pc',isMobile=false,_cfgUseDevMode = false,_siteId = 'league',printSelector = '#jwxe_main_content',ctx = ''
	    ,rootPath = '',locale= 'ko',localeScriptPath='/_custom/hallym/resource/js/';
	//]]>
	</script>
<script type="text/javascript" src="common/cms.js"></script>
<script type="text/javascript" src="common/js/menu/menu.js"></script>
<script type="text/javascript" src="res/league/js/m-mn.js"></script>
<script type="text/javascript" src="common/js/toastr.js"></script>
<script type="text/javascript" src="custom/js/board.common.js"></script>
<script type="text/javascript" src="res/board/js/board.js"></script>
<script type="text/javascript" src="res/league/js/user.js"></script>
<script type="text/javascript" src="res/board/js/hclubDesign.js" defer></script>
<script type="text/javascript">
	function getPage(data1, data2) {
	    var urlpaging = "/clubApprovalList.do?";
		var page = data1; /* 페이지 번호 */
		var club_id = data2; /* club_id */

		var link = urlpaging + "&page=" + page +"&club_id=" + club_id;
		
		location.href = link; 
	}

	function getSingleApproval(data1, data2) {
     	location.href="/clubApproval.do?club_id=" + data1 + "&id=" + data2;
	}
    
</script>
</head>
<body id="item_body" class="pc">
	<ul id="go_main">
		<li><a href="#jwxe_main_content">본문 바로가기</a></li>
		<li><a href="#jwxe_main_menu">주메뉴 바로가기</a></li>
		<li><a href="#jwxe_sub_menu">서브메뉴 바로가기</a></li>
	</ul>

	<div class="sub-wrap">
		<header>
			<div class="top-header-wrap clubGreen"><jsp:include
					page="/WEB-INF/jsp/community/item/top-util.jsp" /></div>
			<div class="bottom-header-wrap"><jsp:include
					page="/WEB-INF/jsp/community/item/header.jsp" /></div>
		</header>
		<!--작은 바-->
		<div class="sub-visual-wrap"></div>
		<div class="path-wrap">
			<div class="path-box">
				<div class="jwxe_navigator jw-relative">
					<ul>
						<li><a href="/clubIntro.do?club_id=${club_id}"><img
								src="images/common/ico-home.png" alt="home"></a></li>
						<li>기타</li>
						<li class="clubonly">회원 승인</li>
					</ul>
				</div>
			</div>
		</div>

		<!--공지사항 보기-->
		<div class="sub-container newclub">
			<!--본문-->
			<h1>
				<i class="fas fa-user-cog"></i>회원 승인
			</h1>
			<div class="tabBtn">
			</div>
			<div class="content hleagueTab modify"
				id="jwxe_main_content_memberManageList">
				<script type="text/javascript">
						//<![CDATA[
						  var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
						  clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
						//]]>
					</script>
				<div class="ko board list co-board type01">
					<div class="common">

						<!--검색창-->
						<div class="bn-list-common01 type01 bn-common bn-common">
							<div class="b-top-info-wrap"></div>
							<table summary="게시판 > Notice" class="board-table">
								<caption class="hide">게시판 &gt; Notice</caption>
								<colgroup>
									<col class="b-col01 personList">
									<col class="b-col02 personList">
									<col class="b-col03 personList">
									<col class="b-col04 personList">

								</colgroup>
								<thead>
									<tr>
										<th scope="col" class="hver2">학번</th>
										<th scope="col" class="hver2">이름</th>
										<th scope="col" class="hver2">소속</th>
										<th scope="col" class="hver2">관리</th>
									</tr>
								</thead>
								<tbody>
								<c:choose>
									<c:when test="${not empty memberList}">
										<c:forEach items='${memberList}' var="item" varStatus="status">
										<tr class="" 
											onmouseover="this.style.backgroundColor='lightgray'"
											onmouseout="this.style.backgroundColor='white'">
											<td class="b-num-box" onclick="getSingleApproval('${club_id}','${item.student_id}');">
											<span>${item.student_id}</span>
											</td>
											<td class="b-td-left leagueKind">
											<span>${item.name}</span>
												<div class="b-title-box league">
													<!--반응형 모바일 부분-->
													<div class="b-etc-box leagueKind" onclick="getSingleApproval('${club_id}','${item.student_id}');">
														<span>이름: ${item.name}</span>
													</div>
													<div class="b-m-con">
														<span class="b-writer" onclick="getSingleApproval('${club_id}','${item.student_id}');">학번: ${item.student_id}</span> 
														<span class="b-writer" onclick="getSingleApproval('${club_id}','${item.student_id}');">소속: ${item.major}</span>
														<form method="post" action="/clubManageAction.do">
															<input type="hidden" name="club_id" value="${club_id}">
															<input type="hidden" name="student_id" value="${item.student_id}">
															<input type="submit" value="승인" name="submit" class="personBtn mobile2" onclick="return confirm('승인 하시겠습니까?');">
															<input type="submit" value="거부" name="submit" class="personBtn mobile2" onclick="return confirm('거부 하시겠습니까?');">
														</form>
	
													</div>
												</div></td>
											<td onclick="getSingleApproval('${club_id}','${item.student_id}');">${item.major}</td>
											
											
											<td>
											<form method="post" action="/clubManageAction.do">
												<input type="hidden" name="club_id" value="${club_id}">
												<input type="hidden" name="student_id" value="${item.student_id}">
												<input type="submit" value="승인" name="submit" class="personBtn" onclick="return confirm('승인 하시겠습니까?');">
												<input type="submit" value="거부" name="submit" class="personBtn" onclick="return confirm('거부 하시겠습니까?');">
											</form>
											</td>
										</tr>
										</c:forEach>
									</c:when>
									<c:otherwise>
										<td class="b-no-post" colspan="4">신청이 없습니다.</td>
									</c:otherwise>
								</c:choose>
								</tbody>
							</table>
						</div>

						<!--공지사항2-->
						<div class="b-paging01 type03">
							<div class="b-paging01 type01">
								<div class="b-paging-wrap">
									<ul>
										<c:if test="${totalPage > 1 and currPage ne prevPage}">
											<li class="first pager"><a
												href="javascript:getPage(1,'${club_id}');"
												title="첫 페이지로 이동하기"> <span class="hide">첫 페이지로
														이동하기</span>
											</a></li>
											<li class="prev pager"><a
												href="javascript:getPage(${prevPage},'${club_id}');"
												title="이전 페이지로 이동하기"> <span class="hide">이전 페이지로
														이동하기</span>
											</a></li>
										</c:if>
										<c:forEach var="i" begin="1" end="${totalPage}">
											<li><c:choose>
													<c:when test="${i eq currPage}">
														<a class="active"
															href="javascript:getPage(${i},'${club_id}');">${i}</a>
													</c:when>
													<c:otherwise>
														<a class=""
															href="javascript:getPage(${i},'${club_id}');">${i}</a>
													</c:otherwise>
												</c:choose></li>
										</c:forEach>
										<c:if test="${totalPage > 1 and currPage ne nextPage}">
											<li class="next pager"><a
												href="javascript:getPage(${nextPage},'${club_id}');"
												title="다음 페이지로 이동하기"> <span class="hide">다음 페이지로
														이동하기</span>
											</a></li>
											<li class="last pager"><a
												href="javascript:getPage(${totalPage},'${club_id}');"
												title="마지막 페이지로 이동하기"> <span class="hide">마지막
														페이지로 이동하기</span>
											</a></li>
										</c:if>
									</ul>
								</div>
							</div>
						</div>

						<div class="b-btn-wrap"></div>
						<form name="admin-form" method="post" action="">
							<input type="hidden" name="method"> <input type="hidden"
								name="articles"> <input type="hidden" name="confirMode">
						</form>




					</div>

				</div>
			</div>
		</div>

		<footer>
			<div class="top-footer-wrap"><jsp:include
					page="/WEB-INF/jsp/item/footer-top.jsp" /></div>
			<div class="bottom-footer-wrap"><jsp:include
					page="/WEB-INF/jsp/item/footer.jsp" /></div>
		</footer>
	</div>

</body>
</html>