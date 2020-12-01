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
<meta name="viewport" content="width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no">

<!--font awesome-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
<!--css-->
<link rel="canonical" href="http://league.hallym.ac.kr/league/board/notice.do" />
<link rel="stylesheet" type="text/css" href="common/cms.css" />
<link rel="stylesheet" type="text/css" href="res/league/css/layout.css" />
<!--[if IE 8]>
    <link rel="stylesheet" type="text/css" href="/_common/ie8.css" />
<![endif]-->
<link rel="stylesheet" type="text/css" href="res/league/css/m-mn.css" />
<link rel="stylesheet" type="text/css" href="common/css/toastr.css" />
<link rel="stylesheet" type="text/css" href="common/css/ui.datepicker.css" />
<link rel="stylesheet" type="text/css" href="common/css/jquery.ui-selectBox.css" />
<link rel="stylesheet" type="text/css" href="res/board/css/board.css" />
<link rel="stylesheet" type="text/css" href="res/board/css/type01.css" />
<link rel="stylesheet" type="text/css" href="custom/css/board.common.css" />
<link rel="stylesheet" type="text/css" href="res/league/css/user.css" />
<link type="text/css" rel="stylesheet" charset="UTF-8" href="https://translate.googleapis.com/translate_static/css/translateelement.css">

<!--js-->
<script type="text/javascript" src="common/js/datepicker/datepicker.js" defer></script>
<script type="text/javascript" src="common/js/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="common/js/jquery/jquery-ui-1.11.4.min.js"></script>
<script defer="" type="text/javascript" src="https://translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/translate_static/js/element/main_ko.js"></script>
<script type="text/javascript" charset="UTF-8" src="https://translate.googleapis.com/element/TE_20181015_01/e/js/element/element_main.js"></script>
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
<script type="text/javascript" src="common/js/toastr.js" ></script>
<script type="text/javascript" src="common/js/jquery-plugin/selectBox.min.js" ></script>
<script type="text/javascript" src="custom/js/board.common.js" ></script>
<script type="text/javascript" src="res/board/js/board.js" ></script>
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
	
	function ListForm(data1, data2){
		location.href="/clubActivityList.do?club_id=" + data1 + "&act_cd=" + data2;
    }
	
	function getSingleActivity(data1, data2, data3) {
     	location.href="/clubActivityRead.do?club_id=" + data1 + "&at_cd=" + data2 + "&act_no=" + data3;
    
	}
	
	function checkDelete(data1) {
    	 
		if(confirm("게시글을 삭제 하시겠습니까?")) {
 		
			location.href = data1;
 		   	return true;
 		}
 		 
		return false;
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
								<li class="clubonly">교내 활동 작성</li>
							</c:when>
							<c:when test="${act_cd eq '015002'}">
								<li class="clubonly">교외 활동 작성</li>
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
					<h1><i class="fas fa-user-check"></i>교내 활동 작성</h1>
				</c:when>
				<c:when test="${act_cd eq '015002'}">
					<h1><i class="fas fa-user-check"></i>교외 활동 작성</h1>
				</c:when>
			</c:choose>
			<!-- New -->
			
			
		<div class="content" id="jwxe_main_content_clubModify">
			<script type="text/javascript">
			//<![CDATA[
			var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, clientId = 'hallym'
			, boardTy = 'common', boardNo = '1522', siteId = 'league';
			//]]>
			</script>
			<div class="ko board write co-board type01">
				<div class="bn-write-common01 type01">
					<!-- 사용여부를  게시판 수정시 기타 설정에서 선택할수 있는 필드  -->
					<form name="writeForm" method="post" action="/clubActivityWriteAction.do" enctype="multipart/form-data">
						<fieldset>
							<legend class="hide"></legend>
							<input name="csrfToken" type="hidden" value="mkktrnrrxrznvsjcvvyu"> 
							<input type="hidden" name="articleNo" value=""> 
							<input name="articleNo" type="hidden" value="">
						 	<input name="parentNo" type="hidden" value="0"> 
							<input name="htmlYn" type="hidden" value="Y">
							<input type="hidden" name="club_id" value="${club_id}">
							<input type="hidden" name="act_cd" value="${act_cd}">
									
							<div class="b-table-wrap">
								<!--동아리명-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box ver2 b-required">
											<label for="clubKinds">종류</label>
										</div>
										<div class="b-con-box ver2">
											<select class="b-sel-title clubver" name="act_kind_cd">
												<option class="searchOption" value="016001">일반</option>
												<option class="searchOption" value="016002">수상</option>
											</select>
										</div>
										<div class="b-title-box ver2 b-required">
                                        	<label for="clubStart">일시</label>
										</div>
                                        <div class="b-con-box ver2">
											<input class="jwvalid-must-title b-input ver2 type01" name="act_date" title="시작 날짜" id="clubStart" type="text" maxlength="10" readonly="readonly" value="" data-valid-title="공지시작일" style="width:100%;">
										</div>
									</div>
								</div>
								<!--활동명-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box ver2 b-required">
											<label for="clubActive">활동명</label>
										</div>
										<div class="b-con-box ver2">
											<input class="jwvalid-must-title b-input ver2 type01" type="text" id="clubActive" name="act_title" value="" required>
										</div>
									</div>
								</div>
								<!--장소, 참석인원-->
								<div class="b-table-box type01 b-notice-box">
									<div class="b-row-box">
										<div class="b-title-box ver2 b-required">
											<label for="clubGround">장소</label>
										</div>
										<div class="b-con-box ver2">
											<input class="jwvalid-must-title b-input ver2 type01" type="text" id="clubGround" name="act_place" value="" required>
										</div>
										<div class="b-title-box ver2 b-required">
											<label for="clubPerson"></label>참석인원</label>
										</div>
										<div class="b-con-box ver2">
											<input class="jwvalid-must-title b-input ver2 type01" type="text" id="clubPerson" name="act_cnt" value="" required>
										</div>
									</div>
								</div>
								<!--행사 내용-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box ver2 b-required">
											<label for="clubparty">행사내용</label>
										</div>
										<div class="b-con-box ver2">
											<textarea class="textareaBox ver2 modify" name="act_contents" required></textarea>	
										</div>
									</div>
								</div>
								<!--느낀점-->
								<div class="b-table-box type01 b-subject-box">
									<div class="b-row-box">
										<div class="b-title-box ver2">
											<label for="clubFeel">느낀점</label>
										</div>
										<div class="b-con-box ver2">
											<textarea class="textareaBox ver2 modify" name="act_temp" required></textarea>	
										</div>
									</div>
                                </div>
								<!--증빙 자료-->
                                <div class="b-table-box type01">
									<div class="b-row-box">
										<div class="b-title-box ver2 b-required">증빙자료</div>
										<div class="b-con-box02 ver2">
											<div class="b-file-box type01">
												<div>
													<select id="attachCnt" class="attach-select b-select ver2">
														<option value="0">선택</option>
														<option value="1">1</option>
														<option value="2">2</option>
														<option value="3">3</option>
														<option value="4">4</option>
														<option value="5">5</option>
														<option value="6">6</option>
														<option value="7">7</option>
														<option value="8">8</option>
														<option value="9">9</option>
														<option value="10">10</option>
													</select>
													<p class="b-guide-txt">
														<label for="attachCnt">파일 갯수를 지정해 주십시오. </label> 
														<span class="privacy">※ 악성파일 또는 저작권 침해 파일 업로드 금지</span>
														<!-- 
														<br class="pc-hide">[파일1개 당 00MB 이하 업로드]
														<span class="privacy">※ 개인정보 업로드 금지</span>
														-->
													</p>
												</div>
											</div>
											
										<c:forEach var="fnum" begin="1" end="10">
                                        	<div class="b-file-box type03 file-list" 
	                                        	<c:choose>
                                                	<c:when test="${fnum eq 1}">
                                                		style="display: block;"
                                                	</c:when>
                                                	<c:otherwise>
                                                		style="display: none;"
                                                	</c:otherwise>
                                                </c:choose>
                                            >
	                                            <div>
	                                            	<div>
		                                                <input type="text" id="file_view${fnum}" name="wr-file-name" class="b-input" placeholder="첨부파일을 등록하세요" readonly="">  <!--  name="wr-file-name" -->
		                                                <input class="outTable thumb hide" type="file" id="file_nm${fnum}" name="attachFile" onchange="javascript:document.getElementById('file_view${fnum}').value = this.value;">
		                                                <label for="file_nm${fnum}" class="b-file-btn ver2">찾아보기</label>
	                                                </div>
	                                                <!-- 
	                                                <div class="b-guide-box">
	                                                    <label class="b-guide-txt hide" for="fileAlt${fnum}">대체 텍스트 </label>
	                                                    <input data-valid-title="대체텍스트" class="b-input file-alt" type="text" id="fileAlt${fnum}" name="attachImageAlt" placeholder="대체텍스트를 입력해주세요.">
	                                                </div>
	                                                -->
	                                            </div>
											</div>
									</c:forEach>
										</div>
									</div>
								</div>
							</div>
						</fieldset>
							<div class="b-btn-wrap">
								<a class="b-btn-type01 b-btn-c-white ver2" title="취소" href="javascript:ListForm('${club_id}', '${act_cd}');">취소</a>
								<button type="submit" class="b-btn-type01 b-btn-c-blue submit modify">저장</button>
                        	</div>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- sub container -->
		<footer>
			<div class="top-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer-top.jsp" /></div>
			<div class="bottom-footer-wrap"><jsp:include page="/WEB-INF/jsp/item/footer.jsp" /></div>
		</footer>
	</div>
</body>
</html>