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
	
	function getDownLink(data1, data2, data3, data4) {
		var url = "/ActFileDownload.do?club_id=" + data1 + "&act_cd=" + data2 + "&act_no=" + data3 + "&num=" + data4;
		location.href = url;
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
	<c:choose>
		<c:when test="${act_cd eq '015001'}">
			<h1><i class="fas fa-building"></i>교내 활동</h1>
		</c:when>
		<c:when test="${act_cd eq '015002'}">
			<h1><i class="fas fa-building"></i>교외 활동</h1>
		</c:when>
	</c:choose>
			<div class="content-wrap new">
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
								<input type="hidden" name="articleNo" value="30582">
								<div class="b-main-box ver2 read">
									<script type="text/javascript">
                                          //<![CDATA[
                                          var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, clientId = 'hallym'
                                          , boardTy = 'common', boardNo = '1522', siteId = 'league';
                                          //]]>
                                          </script>
									<div class="ko board write co-board type01">
										<div class="bn-write-common01 type01">
											<div class="b-table-wrap">

												<!--종류-->
												<div class="b-table-box type01 b-subject-box">
													<div class="b-row-box">
														<div class="b-title-box ver2 b-required">
															<label for="clubKinds">종류</label>
														</div>
														<div class="b-con-box ver2">
															<input class="jwvalid-must-title b-input ver2 type01"
																type="text" id="clubKinds" name="act_kind_cd" value="${activityVO.act_kind_cd}"
																readonly
																required>

														</div>
														<div class="b-title-box ver2 b-required">
															<label for="clubDates">일시</label>

														</div>

														<div class="b-con-box ver2">
															<input class="jwvalid-must-title b-input ver2 type01"
																type="text" id="clubDates" name="act_date" value="${activityVO.act_date}"
																readonly
																required>
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
															<input class="jwvalid-must-title b-input ver2 type01"
																type="text" id="clubActive" name="act_title" value="${activityVO.act_title}"
																readonly
																required>
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
															<input class="jwvalid-must-title b-input ver2 type01"
																type="text" id="clubGround" name="act_place" value="${activityVO.act_place}"
																readonly
																required>
														</div>
														<div class="b-title-box ver2 b-required">
															<label for="clubPerson"></label>참석인원</label>
														</div>
														<div class="b-con-box ver2">
															<input class="jwvalid-must-title b-input ver2 type01"
																type="text" id="clubPerson" name="act_cnt" value="${activityVO.act_cnt} 명"
																readonly
																required>
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
															<textarea class="textareaBox ver2 modify"
																name="act_contents" required readonly>${activityVO.act_contents}</textarea>
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
															<textarea class="textareaBox ver2 modify" 
																name="act_temp"	required readonly>${activityVO.act_temp}</textarea> 
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<!-- <div class="b-file-box ver2 read">
									<ul>

										<li><a class="file-down-btn pptx"
											href="javascript:getDownLink(122);"> 파일첨부 부분.hwp </a></li>

									</ul>
								</div>
								<div class="b-etc-txt-box">
									<p class="b-etc-txt type01">"파일 명이 길 경우 브라우저 특성상 파일명이 잘릴 수
										있습니다."</p>
								</div> -->
							<c:if test="${fileListCnt gt 0}">
			                    <div class="b-file-box ver2 read">
			                        <ul>
			                        <c:forEach items='${fileList}' var="item">
			                            <li>
			                                <a class="file-down-btn pptx" href="javascript:getDownLink('${club_id}', '${act_cd}', '${act_no}', '${item.getFile_no()}');">
			                                   	 ${item.getFile_nm()}
			                                </a>
			                            </li>
			                        </c:forEach>
			                        </ul>
			                    </div>
			                    <div class="b-etc-txt-box">
			                        <p class="b-etc-txt type01">"파일 명이 길 경우 브라우저 특성상 파일명이 잘릴 수 있습니다."</p>
			                    </div>
		                    </c:if>
								
								<div class="b-btn-wrap">
								<c:if test='${isStaff eq true || isMyWrite eq true}'>
									<a class="b-btn-type01 b-btn-c-white ver2" id="deleteArticle"
										onclick="javascript:checkDelete('/clubActivityDeleteAction.do?club_id=${club_id}&act_cd=${act_cd}&act_no=${act_no}');"
										data-confirm="viewBtn.delete.msg">삭제</a> 
									<a class="b-btn-type01 b-btn-c-white ver2"
										href="/clubActivityUpdate.do?club_id=${club_id}&act_cd=${act_cd}&act_no=${act_no}">수정</a> 
									<c:if test='${isStaff eq true}'>
									<a class="b-btn-type01 b-btn-c-white ver2"
										href="/clubActivityWrite.do?club_id=${club_id}&act_cd=${act_cd}">등록</a>
									</c:if>
								</c:if>
									<a class="b-btn-type01 b-btn-c-blue submit modify"
										href="/clubActivityList.do?club_id=${club_id}&act_cd=${act_cd}">목록</a>
								</div>
								<div class="b-pager-box">
                                <div>
                                    <p>이전글</p>
                                    <p>
                                    <c:choose>
                                    	<c:when test="${not empty prevActivityVO}">
                                        	<a href="javascript:getSingleActivity('${club_id }', '${at_cd}',${prevActivityVO.act_no});">
                                            	${prevActivityVO.act_title}
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
                                    	<c:when test="${not empty nextActivityVO}">
                                        	<a href="javascript:getSingleActivity('${club_id }', '${at_cd}',${nextActivityVO.act_no});">
                                            	${nextActivityVO.act_title}
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