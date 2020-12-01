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
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.1/css/all.css" integrity="sha384-vp86vTRFVJgpjF9jiIGPEEqYqlDwgyBgEF109VFjmqGmIY/Y4HV4d3Gp2irVfcrp" crossorigin="anonymous">
	
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
<script type="text/javascript" src="common/js/datepicker/datepicker.js"></script>

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
	                		<li class="clubonly">정보 수정</li>
					</ul>
				</div>
			</div>
		</div>


		<!--공지사항 보기-->
		<!--공지사항 보기-->
            <div class="sub-container newclub">

                <!--본문-->
            	<h1><i class="fas fa-user-edit"></i>정보 수정</h1>
                
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
							<form name="updateForm" method="post" action="/clubUpdateAction.do" onsubmit="return check_form();">
								<fieldset>
									<legend class="hide"></legend>
									<input name="csrfToken" type="hidden" value="mkktrnrrxrznvsjcvvyu">									
									<input type="hidden" name="articleNo" value="">
									<input name="articleNo" type="hidden" value="">
									<input name="parentNo" type="hidden" value="0">
									<input name="htmlYn" type="hidden" value="Y">
									<input type="hidden" name="club_id" value="${club_id}">
                                    <div class="b-table-wrap">
                                    	<!--동아리명-->
                                        <div class="b-table-box type01 b-subject-box">
                                        	<div class="b-row-box">
                                            	<div class="b-title-box newform ver2 b-required">
                                                	<label for="clubName">동아리명</label>
                                                </div>
                                                <div class="b-con-box ver2">
                                                	<input class="jwvalid-must-title b-input type01 ver2" type="text" id="clubName" name="clubName" value="${clubInfo.club_nm}" disabled>
                                                </div>
                                            </div>
                                       	</div>
                                       	<!-- 동아리 정보 -->
                                        <!-- <div class="b-table-box type01 b-subject-box">
                                        	<div class="b-row-box">
                                            	<div class="b-title-box newform ver2 b-required">
                                                	<label for="clubInfo">동아리 정보</label>
                                                </div>
                                                <div class="b-con-box ver2">
                                                	<input class="jwvalid-must-title b-input type01 ver2" type="text" id="clubInfo" name="clubInfo" value="">
                                                </div>                                                    
                                            </div>
                                        </div> -->
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box ver2 b-required">
													<label for="clubGround">동아리방</label>
												</div>
												<div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" type="text" id="clubGround" name="club_room" value="${clubInfo.club_room}" required>
												</div>
												
												<div class="b-title-box ver2 b-required">
                                                    <label for="clubStart">개설년도</label>
												</div>
                                                <div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" name="open_dt" title="시작 날짜" id="clubStart" type="text" maxlength="10" readonly="readonly" value="${clubInfo.open_dt}" data-valid-title="개설년도" style="width:100%;">
												</div>
											</div>
										</div>
                                        <!--동아리 목적-->
                                        <div class="b-table-box type01 b-subject-box">
                                        	<div class="b-row-box">
                                            	<div class="b-title-box newform ver2 b-required">
                                                	<label for="purposText">목적</label>
                                                </div>
                                                <div class="b-con-box ver2">
                                                	<textarea class="textareaBox league ver2" name="club_aim">${clubInfo.club_aim}</textarea>	
                                                </div>
                                            </div>
                                        </div>
                                        <!--동아리 활동-->
                                        <div class="b-table-box type01 b-subject-box">
                                        	<div class="b-row-box">
                                            	<div class="b-title-box newform ver2 b-required">
                                                	<label for="clubActive">활동</label>
                                                </div>
                                                <div class="b-con-box ver2">
                                                	<textarea class="textareaBox league ver2" name="club_active">${clubInfo.club_active}</textarea>	
                                                </div>
                                            </div>
                                        </div>
                                        <!--소개-->
                                        <!-- <div class="b-table-box type01">
                                        	<div class="b-row-box">
                                            	<div class="b-title-box ver2 b-required">
                                                	<label for="articleText">소개</label>
                                                </div>  
                                            	<div class="b-con-box ver2">
                                                    <textarea id = "clubContent" name = "clubContent"></textarea>
                                                </div>                                  
                                            </div>
                                        </div> -->
                                	</div>
								</fieldset>  
                              
								<div class="b-btn-wrap">
									<a class="b-btn-type01 b-btn-c-white ver2" title="취소" onclick="getclubIntro(${club_id});">취소</a>
                                   	<button type="submit" class="b-btn-type01 b-btn-c-blue submit modify">저장</button>
								</div>	 
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
		function check_form() {
			var ck_name = document.getElementById("club_nm").value;

			if (ck_name.trim() == "") {
				alert("동아리 이름을 입력해주세요");
				document.getElementById("club_nm").focus();
				return false;
			}

		}
		
		function getclubIntro(data1) {
	     	location.href="/clubIntro.do?club_id=" + data1;
		}
	</script>
    <noscript><p>이 사이트는 자바스크립트를 지원하지 않으면 정상적으로 보이지 않을수 있습니다.</p></noscript>
</body>
</html>