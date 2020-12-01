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
	function getPage(data1, data2, data3, data4) {
	    var urlpaging = "/clubProduct.do?";
		var page = data1; /* 페이지 번호 */
		var club_id = data2; /* club_id */
		var select = data3; /* 물품 이름, 설명 */
		var cdn = data4; /* cdn */
		var link = urlpaging + "&page=" + page +"&club_id=" + club_id;
		
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
						<li class="clubonly">물품 관리</li>
					</ul>
				</div>
			</div>
		</div>


		<!--공지사항 보기-->
		<div class="sub-container newclub">

			<!--본문-->
			<h1>
				<i class="fas fa-newspaper"></i>물품 관리
			</h1>
			<div class="content" id="jwxe_main_content_articleList">
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
							<form method="post" action="/clubProduct.do?club_id=${club_id}" name="boardForm">
								<fieldset class="b-search-wrap">
									<legend class="hide">게시글 검색</legend>
									<input type="hidden" name="mode" value="list">
									<div class="b-sel-box b-cate-basic league" style="z-index: 0;">
										<select class="b-sel-title leagueform ver2" name="select">
											<option class="searchOption" value="1">물품명</option>
											<option class="searchOption" value="2">물품설명</option> 
										</select> <label for="search_val" class="b-sel-label"><span>검색어</span></label>
										<input type="text" id="article_val" name="cdn" value=""
											placeholder="검색어를 입력해 주세요">
										<button type="submit" class="b-sel-btn leagueSearchBtn ver2">검색</button>
									</div>

								</fieldset>
							</form>
						</div>
						<!--검색창-->
						<form method=post action="clubProductAction.do">
							<input type="hidden" value="${club_id}" name="club_id">

							<div class="bn-list-common01 type01 bn-common bn-common rowplus">
								<div class="b-top-info-wrap"></div>
								<table summary="게시판 > Notice" class="board-table"
									id="contentTable1">
									<caption class="hide">게시판 &gt; Notice</caption>
									<colgroup>
										<col class="b-col01 articleList">
										<col class="b-col02 articleList">
										<col class="b-col03 articleList">
										<col class="b-col04 articleList">
									</colgroup>

									<thead>
										<tr>
											<th scope="col" class="hver2"><input type="checkbox"
												id="checkArticle"></th>
											<th scope="col" class="hver2">물품명</th>
											<th scope="col" class="hver2">물품수</th>
											<th scope="col" class="hver2">물품설명</th>
										</tr>


									</thead>
									<tbody>
										<c:choose>
											<c:when test="${not empty productList}">
												<c:forEach items='${productList}' var="item"
													varStatus="status">
													
													<%-- <input type="hidden" value="${item.seq_no}" name="seq_no"> --%>
													<tr> 
														<td><input type="checkbox" id="checkArticle">
														</td>

														<td>
															<input type="text" value="${item.getProductNM()}"
																name="product_nm">
														</td>
														<td>
															<input type="text" value="${item.getTotCnt()}"
																name="tot_cnt"
																onKeyup="this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);">

														</td>
														<td>
															<input type="text"
																value="${item.getProductCont()}"
																name="product_cont">
														</td>
													</tr> 
												</c:forEach>
											</c:when>
											<c:otherwise>
												<td class="b-no-post" colspan="4">등록된 물품이 없습니다.</td>
											</c:otherwise>
										</c:choose> 
 
									</tbody>
								</table>
							</div>
							<!--공지사항1-->
							<c:if test="${empty cdn}">
								<c:if test="${isStaff eq true}">
								<div class="b-btn-wrap leagueKind">
								<button type="button" id="moneyAdd1"
									class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2">추가</button>
								<button type="button" id="moneyDel1"
									class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2">삭제</button>
								<button type="submit" value="완료" 
									class="b-btn-type01 b-btn-c-blue submit leaugeKind ver2">저장</button>
								</div>
								</c:if> 
							</c:if>

						</form>
						<!--공지사항2-->
						<div class="b-paging01 type03">
							<div class="b-paging01 type01">
								<%-- <div class="b-paging-wrap">
									<ul>
									<c:if test="${totalPage > 1 and currPage ne prevPage}">
										<li class="first pager">
											<a href="javascript:getPage(1,'${club_id}','${select}','${cdn}');" title="첫 페이지로 이동하기">
												<span class="hide">첫 페이지로 이동하기</span>
											</a>
										</li>
										<li class="prev pager">
											<a href="javascript:getPage(${prevPage},'${club_id}','${select}','${cdn}');" title="이전 페이지로 이동하기">
												<span class="hide">이전 페이지로 이동하기</span>
											</a>
										</li>
									</c:if>
									<c:forEach var="i" begin="1" end="${totalPage}">
										<li>
											<c:choose>
					                        	<c:when test="${i eq currPage}">
					                        		<a class="active" href="javascript:getPage(${i},'${club_id}','${select}','${cdn}');">${i}</a>
					                        	</c:when>
					                        	<c:otherwise>
					                        		<a class href="javascript:getPage(${i},'${club_id}','${select}','${cdn}');">${i}</a>
					                        	</c:otherwise>
					                        </c:choose>
				                        </li>
									</c:forEach>
									<c:if test="${totalPage > 1 and currPage ne nextPage}">
										<li class="next pager">
											<a href="javascript:getPage(${nextPage},'${club_id}','${select}','${cdn}');" title="다음 페이지로 이동하기">
												<span class="hide">다음 페이지로 이동하기</span>
											</a>
										</li>
										<li class="last pager">
											<a href="javascript:getPage(${totalPage},'${club_id}','${select}','${cdn}');" title="마지막 페이지로 이동하기">
												<span class="hide">마지막 페이지로 이동하기</span>
											</a>
										</li>
									</c:if>

									</ul>
								</div> --%>
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

	<script>
		$(function () {
		  $("#moneyAdd1").click(function () {
		    $("#contentTable1").append(
		      "<tr><td><input type='checkbox'></td>" +
		        "<td><input type='text' name='product_nm'></td>" +
		        "<td><input type='text' name='tot_cnt' onKeyup='this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);></td>"+
		        "<td><input type='text' name='product_cont'></td></tr>"
		    );
		  });
		  $("#moneyDel1").click(function () {
		    $("#contentTable1 tbody input[type='checkbox']:checked")
		      .parent()
		      .parent()
		      .remove();
		  });
		});
	</script>
	<script>
		function numberWithCommas(x) {
			var y = x.value;
			y = y.replace(/[^0-9]/g, ''); // 입력값이 숫자가 아니면 공백
			y = y.replace(/,/g, ''); // ,값 공백처리
			var x_id = x.getAttribute('id');
			$('#' + x_id).val(y.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
		}

		function add_row() {
			var newDiv = document.createElement("tr");
			newDiv.innerHTML = "<td style='border: 1px solid #dddddd;' ><input type='text' style='text-align: center; width: 100px; height: 30px;' name='product_nm'></td> <td style='border: 1px solid #dddddd;'><input type='text' style='text-align: center; width: 50px; height: 30px;' name='tot_cnt' onKeyup='this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);'></td> <td style='border: 1px solid #dddddd;'><input type='text' style='text-align: center; width: 500px; height: 30px;' name='product_cont'></td> <td style='border: 1px solid #dddddd;'><span>삭제</span></td>";
			document.getElementById('my-tbody').appendChild(newDiv);
			var objDiv = document.getElementById("table");
			objDiv.scrollTop = objDiv.scrollHeight;
		}
	</script>

	<script type="text/javascript">
		$(function() {
			$("#table").on("click", "span", function() {
				$(this).closest("tr").remove();
			});
		});
	</script>

</body>
</html>