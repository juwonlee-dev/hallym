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
	function getPage(data1, data2, data3, data4, data5, data6) {
	    var urlpaging = "/clubActivityList.do?";
		var page = data1; /* 페이지 번호 */
		var club_id = data2; /* club_id */
		var act_cd = data3; /* act_cd */
		var act_kind_cd = data4; /* act_kind_cd */
		var select = data5; /* 물품 이름, 설명 */
		var cdn = data6; /* cdn */
		var link = urlpaging + "&page=" + page +"&club_id=" + club_id + "&act_cd=" + act_cd;
		if(act_kind_cd != null)
			link += "&act_kind_cd=" + act_kind_cd;
		if(select != null)
			link += "&select=" + select;
		
		if(cdn != null)
			link += "&cdn=" + cdn;
		
		
		location.href = link; 
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
						<c:choose>
							<c:when test="${act_cd eq '015001'}">
								<li class="clubonly">교내 활동</li>
							</c:when>
							<c:when test="${act_cd eq '015002'}">
								<li class="clubonly">교외 활동</li>
							</c:when>
						</c:choose>
					</ul>
				</div>
			</div>
		</div>


		<!--공지사항 보기-->
		<!-- sub container -->
		 <div class="sub-container newclub">

                <!--본문-->
                <c:choose>
					<c:when test="${act_cd eq '015001'}">
						<h1><i class="fas fa-school"></i>교내 활동</h1>
					</c:when>
					<c:when test="${act_cd eq '015002'}">
						<h1><i class="fas fa-school"></i>교외 활동</h1>
					</c:when>
				</c:choose>

				<div class="content hleagueTab modify" id="jwxe_main_content_activeSchool1">
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
								<form method="post" action="/clubActivityList.do" name="boardForm">
									<fieldset class="b-search-wrap">
										<legend class="hide">게시글 검색</legend>
										<input type="hidden" name="club_id" value="${club_id}">
										<input type="hidden" name="act_cd" value="${act_cd}">
										<input type="hidden" name="mode" value="list">
										<div class="b-sel-box b-cate-basic league" style="z-index: 0;">
											<select class="b-sel-title leagueform ver2" name="act_kind_cd">
												<option class="searchOption" value="016">전체</option> 
												<option class="searchOption" value="016001">일반</option>
												<option class="searchOption" value="016002">수상</option>
											</select>
											<select class="b-sel-title leagueform ver2" name="select">
												<option class="searchOption" value="1">활동명</option>
												<option class="searchOption" value="2">장소</option>
											</select>
											<label for="notice_val" class="b-sel-label"><span>검색어</span></label>
											<input type="text" id="notice_val" name="cdn" value="${condition}" placeholder="검색어를 입력해 주세요">
											<button type="submit" class="b-sel-btn leagueSearchBtn ver2">검색</button>
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
										<col class="b-col01 inner">
										<col class="b-col02 inner">
                                        <col class="b-col03 inner">
										<col class="b-col04 inner">
										<col class="b-col05 inner">
										<col class="b-col06 inner">
										<col class="b-col07 inner">
									</colgroup>
									<thead>
										<tr>
											<th scope="col" class="hver2">번호</th>
											<th scope="col" class="hver2">종류</th>
											<th scope="col" class="hver2">활동명</th>
											<th scope="col" class="hver2">장소</th>
											<th scope="col" class="hver2">일시</th>
											<th scope="col" class="hver2">참석인원</th>
											<th scope="col" class="hver2">증빙자료</th>
										</tr>
									</thead>
									<tbody>
									<c:choose>
										<c:when test="${not empty activityList}">
											<c:forEach items='${activityList}' var="item">
											<tr class="">
												<td class="b-num-box">
													<span>${item.act_no}</span>
												</td>
												<td class="b-td-left leagueKind">
													<span>${item.act_kind_cd}</span>
													<div class="b-title-box league">
														<!--반응형 모바일 부분-->
														<div class="b-etc-box leagueKind">
															<span>${item.act_no}.</span>
															<span><a href="/clubActivityRead.do?club_id=${club_id}&act_cd=${item.act_cd}&act_no=${item.act_no}" >
															활동명: ${item.act_title}
															</a></span>
														</div>
														<div class="b-m-con">
															<span class="b-writer">종류: ${item.act_kind_cd}</span>
															<span class="b-writer">장소: ${item.act_place}</span>
															<span class="b-date">일시: ${item.act_date}</span>
															<span class="b-writer">참석인원: ${item.act_cnt}명</span>

														</div>
													</div>
												</td>
												<td><a href="/clubActivityRead.do?club_id=${club_id}&act_cd=${item.act_cd}&act_no=${item.act_no}">${item.act_title}</a></td>
												<td>${item.act_place}</td>
												<td>${item.act_date}</td>
												<td>${item.act_cnt}명</td>
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
												<!-- <div class="b-file-box">
													<span class="hide">첨부파일</span>
												</div>	 -->
												</td>
											</tr>
											</c:forEach>
											</c:when>
											<c:otherwise>
												<td class="b-no-post" colspan="7">
													등록된 글이 없습니다.		
												</td>
											</c:otherwise>
										</c:choose> 
 
									</tbody>
								</table>          
                            </div>
                            
                            
							<!--공자사항1-->
							<div class="b-btn-wrap leagueKind">
								<form method="post" action="/clubActivityWrite.do" name="boardForm">
									<input type="hidden" name="club_id" value="${club_id}">
									<input type="hidden" name="act_cd" value="${act_cd}">
									<button type="submit" id = "school1" class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2" >추가</button>
								</form>
							</div>
							<!--공지사항2-->
							<div class="b-paging01 type03">
                                <div class="b-paging01 type01">
                                    <div class="b-paging-wrap">
                                    <!-- 페이징 -->
										<ul>		
											<c:if test="${totalPage > 1 and currPage ne prevPage}">
												<li class="first pager">
													<a href="javascript:getPage(1,'${club_id}','${act_cd}','${act_kind_cd}','${select}','${cdn}');" title="첫 페이지로 이동하기">
														<span class="hide">첫 페이지로 이동하기</span>
													</a>
												</li>
												<li class="prev pager">
													<a href="javascript:getPage(${prevPage},'${club_id}','${act_cd}','${act_kind_cd}','${select}','${cdn}');" title="이전 페이지로 이동하기">
														<span class="hide">이전 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
											<c:forEach var="i" begin="1" end="${totalPage}">
												<li>
													<c:choose>
							                        	<c:when test="${i eq currPage}">
							                        		<a class="active" href="javascript:getPage(${i},'${club_id}','${act_cd}','${act_kind_cd}','${select}','${cdn}');">${i}</a>
							                        	</c:when>
							                        	<c:otherwise>
							                        		<a class="" href="javascript:getPage(${i},'${club_id}','${act_cd}','${act_kind_cd}','${select}','${cdn}');">${i}</a>
							                        	</c:otherwise>
							                        </c:choose>
						                        </li>
											</c:forEach>
											<c:if test="${totalPage > 1 and currPage ne nextPage}">
												<li class="next pager">
													<a href="javascript:getPage(${nextPage},'${club_id}','${act_cd}','${act_kind_cd}','${select}','${cdn}');" title="다음 페이지로 이동하기">
														<span class="hide">다음 페이지로 이동하기</span>
													</a>
												</li>
												<li class="last pager">
													<a href="javascript:getPage(${totalPage},'${club_id}','${act_cd}','${act_kind_cd}','${select}','${cdn}');" title="마지막 페이지로 이동하기">
														<span class="hide">마지막 페이지로 이동하기</span>
													</a>
												</li>
											</c:if>
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
            </div>

		<!-- sub container -->
		<footer>
			<div class="top-footer-wrap"><jsp:include
					page="/WEB-INF/jsp/item/footer-top.jsp" /></div>
			<div class="bottom-footer-wrap"><jsp:include
					page="/WEB-INF/jsp/item/footer.jsp" /></div>
		</footer>
	</div>

	

</body>
</html>