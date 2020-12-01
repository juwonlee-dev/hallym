<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="hallym.club.user.vo.UserVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<%
		UserVO cuserVO = null;
		String cuserId = null;
		String cusername = null;
		//String auth_code = null;
		if (session.getAttribute("userVO") != null) {
			cuserVO = ((UserVO) session.getAttribute("userVO"));
			cuserId = cuserVO.getId();
			cusername = cuserVO.getName();
			//auth_code = (String) session.getAttribute("auth_code");
		}
	%>
	<div class="bottom-header-box">
		<a class="btn-menu" href="#a"><span class="hide">모바일 메뉴 열기</span></a>
		<h1>
			<a href="/clubIntro.do?club_id=${club_id}" title="${club_name} 커뮤니티 바로가기" > 
				<img src="${pageContext.request.contextPath}/images/common/img-logo.png" alt="한림대학교">
				<span>동아리</span>
				<span>${club_name}</span>
			</a>
		</h1>
		<div class="gnb">
			<ul class="gnb-ul jwxe-menu-ul newClub">
				<li>
				 	<a title="활동" href="/clubBudget.do?club_id=${club_id}&io_gb_cd=009001" class="">
				 		<span>활동</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/clubBudget.do?club_id=${club_id}&io_gb_cd=009001">예산 관리</a>
						</li>
						<li>
							<a href="/clubProduct.do?club_id=${club_id}">물품 관리</a>
						</li>
						<li>
							<a href="/clubActivityList.do?club_id=${club_id}&act_cd=015001">교내 활동</a>
						</li>
						<li>
							<a href="/clubActivityList.do?club_id=${club_id}&act_cd=015002">교외 활동</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="게시판" href="/clubBoardList.do?club_id=${club_id}&board_cd=007001" class="">
				 		<span>게시판</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007001">공지사항</a>
						</li>
						<li>
							<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007002">자유게시판</a>
						</li>
						<li>
							<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007003">갤러리</a>
						</li>
						<li>
							<a href="/clubCalendar.do?club_id=${club_id}&board_cd=007004">일정</a>
						</li>
					</ul>
				</li>
				<li>
				 	<a title="기타" href="/clubIntroView.do?club_id=${club_id}" class="">
				 		<span>기타</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/clubIntroView.do?club_id=${club_id}">소개</a>
						</li>
						<li>
							<a href="/clubMemberList.do?club_id=${club_id}">회원 목록</a>
						</li>
						<li>
							<a href="/leaveClubAction.do?club_id=${club_id}" onclick="return confirm('${club_name}에서 탈퇴 하시겠습니까?')">탈퇴하기</a>
						</li>
					</ul>
				</li>
				
				<!-- 임원일 때  --> 
				<c:if test="${isStaff eq true}">
				<li>
				 	<a title="관리" href="/clubUpdate.do?club_id=${club_id}" class="">
				 		<span>관리</span>
				 	</a>
					<ul class="sub-mn" style="display: none;">
						<li>
							<a href="/clubUpdate.do?club_id=${club_id}">정보 수정</a>
						</li>
						<li>
							<a href="/clubManageList.do?club_id=${club_id}">회원 관리</a>
						</li>
						<li>
							<a href="/clubApprovalList.do?club_id=${club_id}">회원 승인</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="alert('준비중입니다.'); return false;">단체 메일</a>
						</li>
						<li>
							<a href="javascript:void(0);" onclick="alert('준비중입니다.'); return false;">디자인 설정</a>
						</li>
					</ul>
				</li>
				</c:if>
			</ul>			
		</div>
	</div>
	<nav class="slideMenu">
		<div class="m-util">
			<ul>
				<li><a href="/index.do" title="HOME 바로가기">HOME</a></li>
				<li><a href="http://www.hallym.ac.kr/" target="_blank" title="한림대학교 사이트 새창열림">한림대학교</a></li>
				<li style="border-right: none;"><a href="#a" title="사이트맵 보기" class="sitemap-btn">Sitemap</a></li>
			<%	if(cuserId == null) { %>
				<li class="login"><a href="/login.do" class="login" title="Login">로그인</a></li>
				<li><a href="" class="" title="">&nbsp</a></li>
				<li style="border-right: none;"><a href="" class="" title="">&nbsp</a></li>
			<%	} else { %>
				<li><a href="" class="" title="사용자 이름"><%=cusername%>님</a></li>
				<li class="profile"><a href="/profile.do" class="profile" title="Profile">마이페이지</a></li>
				<li class="logout"><a href="/logout.do" class="logout" title="Logout">로그아웃</a></li>
			<%	} %>
			</ul>
		</div>
		<div class="m-gnb">
			<ul class="dep1 jwxe-menu-ul">
				<li>
					<a href="/clubBudget.do?club_id=${club_id}&io_gb_cd=009001">활동</a>
					<ul class="dep2">
						<li><a href="/clubBudget.do?club_id=${club_id}&io_gb_cd=009001">예산 관리</a></li>
						<li><a href="/clubProduct.do?club_id=${club_id}">물품 관리</a></li>
						<li><a href="/clubActivityList.do?club_id=${club_id}&act_cd=015001">교내 활동</a></li>
						<li><a href="/clubActivityList.do?club_id=${club_id}&act_cd=015002">교외 활동</a></li>
					</ul>
				</li>
				<li>
					<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007001">게시판</a>
					<ul class="dep2">
						<li><a href="/clubBoardList.do?club_id=${club_id}&board_cd=007001">공지사항</a></li>
						<li><a href="/clubBoardList.do?club_id=${club_id}&board_cd=007002">자유게시판</a></li>
						<li><a href="/clubBoardList.do?club_id=${club_id}&board_cd=007003">갤러리</a></li>
						<li><a href="/clubCalendar.do?club_id=${club_id}&board_cd=007004">일정</a></li>
					</ul>
				</li>
				<li>
					<a href="/clubIntroView.do?club_id=${club_id}">기타</a>
					<ul class="dep2">
						<li><a href="/clubIntroView.do?club_id=${club_id}">소개</a></li>
						<li><a href="/clubMemberList.do?club_id=${club_id}">회원 목록</a></li>
						<li><a href="/leaveClubAction.do?club_id=${club_id}" onclick="return confirm('${club_name}에서 탈퇴 하시겠습니까?')">탈퇴하기</a></li>
					</ul>
				</li>
				
				<!-- 임원일 때  --> 
				<c:if test="${isStaff eq true}">
				<li>
					<a href="/clubUpdate.do?club_id=${club_id}">관리</a>
					<ul class="dep2">
						<li><a href="/clubUpdate.do?club_id=${club_id}">정보 수정</a></li>
						<li><a href="/clubManageList.do?club_id=${club_id}">회원 관리</a></li>
						<li><a href="/clubApprovalList.do?club_id=${club_id}">회원 승인</a></li>
						<li><a href="javascript:void(0);" onclick="alert('준비중입니다.'); return false;">단체 메일</a></li>
						<li><a href="javascript:void(0);" onclick="alert('준비중입니다.'); return false;">디자인 설정</a></li>
					</ul>
				</li>
				</c:if>
			</ul>
		</div>
	</nav>
	<a href="#a" class="slide-close"><span class="hide">모바일 메뉴 닫기</span></a>
	<div class="m-gnb-bg">&nbsp;</div>
	<!-- 사이트 맵 -->
	<div class="sitemap-wrap">
		<div class="sitemap-box">
			<ul>
			
				<li id="menu_4137" class="depth_1 first">
					<a href="/clubBudget.do?club_id=${club_id}&io_gb_cd=009001" class="depth_1 ">활동</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubBudget.do?club_id=${club_id}&io_gb_cd=009001" class="depth_2 ">예산 관리</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubProduct.do?club_id=${club_id}" class="depth_2 ">물품 관리</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubActivityList.do?club_id=${club_id}&act_cd=015001" class="depth_2 ">교내 활동</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubActivityList.do?club_id=${club_id}&act_cd=015002" class="depth_2 ">교외 활동</a>
						</li>
					</ul>
				</li>
				
				<li id="menu_4137" class="depth_1 first">
					<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007001" class="depth_1 ">게시판</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007001" class="depth_2 ">공지사항</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007002" class="depth_2 ">자유게시판</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubBoardList.do?club_id=${club_id}&board_cd=007003" class="depth_2 ">갤러리</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubCalendar.do?club_id=${club_id}&board_cd=007004" class="depth_2 ">일정</a>
						</li>
					</ul>
				</li>
				
				<li id="menu_4137" class="depth_1 first">
					<a href="/clubIntroView.do?club_id=${club_id}" class="depth_1 ">기타</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubIntroView.do?club_id=${club_id}" class="depth_2 ">소개</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubMemberList.do?club_id=${club_id}" class="depth_2 ">회원 목록</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/leaveClubAction.do?club_id=${club_id}" class="depth_2 " onclick="return confirm('${club_name}에서 탈퇴 하시겠습니까?')">탈퇴하기</a>
						</li>
					</ul>
				</li>
				
				<!-- 임원일 때  --> 
				<c:if test="${isStaff eq true}">
				<li id="menu_4137" class="depth_1 first">
					<a href="" class="depth_1 ">관리</a>
					<ul class="depth_2">
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubUpdate.do?club_id=${club_id}"" class="depth_2 ">정보 수정</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubManageList.do?club_id=${club_id}"" class="depth_2 ">회원 관리</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="/clubApprovalList.do?club_id=${club_id}" class="depth_2 ">회원 승인</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="javascript:void(0);" onclick="alert('준비중입니다.'); return false;"
							class="depth_2 ">단체 메일</a>
						</li>
						<li id="menu_4142" class="depth_2 first">
							<a href="javascript:void(0);" onclick="alert('준비중입니다.'); return false;"
							class="depth_2 ">디자인 설정</a>
						</li>
					</ul>
				</li>
				</c:if>
			</ul>
			<a href="#" title="닫기" class="sitemap-close">
				<img src="${pageContext.request.contextPath}/images/board/btn-sitemap-close.png" alt="닫기">
			</a>
		</div>
	</div>
	<!-- //사이트 맵 -->
</body>
</html>