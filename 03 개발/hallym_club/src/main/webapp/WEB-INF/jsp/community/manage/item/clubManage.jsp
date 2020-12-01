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

	function ListForm(data1){
		location.href="/clubManageList.do?club_id=" + data1;
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
	                		<li class="clubonly">회원 관리</li>
					</ul>
				</div>
			</div>
		</div>


		<!--공지사항 보기-->
		<!--공지사항 보기-->
            <div class="sub-container newclub">

                <!--본문-->
            	<h1><i class="fas fa-user-cog"></i>회원 관리</h1>
                
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
							<form name="writeForm2" method="post" action="/clubStaffUpdateAction.do">
								<fieldset>
									<legend class="hide"></legend>
									<input name="csrfToken" type="hidden" value="mkktrnrrxrznvsjcvvyu">									
									<input type="hidden" name="articleNo" value="">
									<input name="articleNo" type="hidden" value="">
									<input name="parentNo" type="hidden" value="0">
									<input name="htmlYn" type="hidden" value="Y">
									<input type="hidden" name="club_id" value="${club_id}"> 
									<input type="hidden" name="student_id" value="${memberInfo.student_id}">
                                    <c:if test="${isPresident eq false}">
	                                 
                                    <div class="clubChair">
										<span>직위</span>
                                    <select class="b-sel-title leagueform ver2 chair" name="staff_cd">
                                        <option class="searchOption" value="004004">회원</option>
                                        <option class="searchOption" value="004002">부회장</option>
                                        <option class="searchOption" value="004003">총무</option>
                                    </select>
                                     <!-- <button type = "submit" class="clubChairman">직위변경</button>
                                     <button type = "submit" class="clubChairman">회장위임</button> -->
                                     
                                       <input class="clubChairman" type="submit" 
	                                            name="submit" value="직위변경" onclick="return confirm('직위를 변경하시겠습니까?');">
	                                     
										
										<c:if test="${staff_cd eq '004001'}">
											<input class="clubChairman" type="submit" 
										       name="submit" value="회장위임" onclick="return confirm('회장을 위임하시겠습니까?');">
										</c:if>
									 
                                    </div> 
                                 	</c:if>
									<div class="b-table-wrap">
										<!--직책-->
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box ver2 b-required">
                                                    <label for="clubStd">학과</label>
                                                    
												</div>
                                                <div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" 
													type="text" id="clubStd" name="clubStd" value="${memberInfo.major}" disabled>
												</div>
                                                <!--학년-->
												<div class="b-title-box ver2 b-required">
													<label for="clubstdYear">학년</label>
												</div>
												<div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" 
													type="text" id="clubstdYear" name="clubstdYear" value="${memberInfo.grade}" disabled>
												</div>
											</div>
										</div>
										<!--학번, 이름-->
										<div class="b-table-box type01 b-notice-box">
											<div class="b-row-box">
												<div class="b-title-box ver2 b-required">
													<label for="clubstdNum"></label>학번</label>
												</div>
												<div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" 
													type="text" id="clubstdNum" name="clubstdNum" value="${memberInfo.student_id}" disabled>
												</div>
												<div class="b-title-box ver2 b-required">
													<label for="clubName">성명</label>
												</div>
												<div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" 
													type="text" id="clubName" name="clubName" value="${memberInfo.name}"  disabled>
                                                </div>
											</div>
										</div>
                                      
                                        <!--전화번호 이메일-->
                                        <div class="b-table-box type01 b-notice-box">
											<div class="b-row-box">
												<div class="b-title-box ver2 b-required">
													<label for="clubtel">전화번호</label>
												</div>
												<div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" 
													type="text" id="clubtel" name="clubtel" value="${memberInfo.phone_no}" disabled>
												</div>
												<div class="b-title-box ver2">
													<label for="clubemail"></label>이메일</label>
												</div>
												<div class="b-con-box ver2">
													<input class="jwvalid-must-title b-input ver2 type01" 
													type="text" id="clubemail" name="clubemail" value="${memberInfo.email}" disabled>
												</div>
											</div>
										</div>
									

										<!--활동 계획-->
										<div class="b-table-box type01 b-subject-box">
											<div class="b-row-box">
												<div class="b-title-box ver2 b-required">
													<label for="clubPlan">활동 계획</label>
												</div>
												<div class="b-con-box ver2">
													<textarea class="textareaBox ver2 modify" name = "clubPlan" disabled>${memberInfo.plan}</textarea>	
												</div>
											</div>
										</div>
                                        
                                        
										<!--바라는 점-->
										<div class="b-table-box type01 b-subject-box">
                                            
											<div class="b-row-box">
												<div class="b-title-box ver2 b-required">
													<label for="clubHope">바라는 점</label>
												</div>
												<div class="b-con-box ver2">
													<textarea class="textareaBox ver2 modify" name = "clubHope" disabled>${memberInfo.hope}</textarea>	
												</div>
											</div>
                                        </div>
									
                                       
					
									</div> 
								</fieldset>  
                              
								<div class="b-btn-wrap">
									<a class="b-btn-type01 b-btn-c-white ver2" title="취소" href="javascript:ListForm('${club_id}');">취소</a>
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

</body>
</html>