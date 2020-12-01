<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@page import="hallym.club.user.vo.UserVO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>
	<h1><i class="fas fa-camera-retro"></i>${headTitle}</h1>
	<div class="content" id="jwxe_main_content">
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
					<form method="post" action="/clubBoardList.do" name="boardForm"
						enctype="multipart/form-data">
						<fieldset class="b-search-wrap">
							<legend class="hide">게시글 검색</legend>
							<input type="hidden" name="mode" value="list">
							<div class="b-sel-box b-cate-basic league" style="z-index: 0;">
								<select class="b-sel-title leagueform ver2" name="opt">
									<option class="searchOption" value="0">전체</option>
									<option class="searchOption" value="1">제목</option>
									<option class="searchOption" value="2">내용</option>
								</select> <label for="search_val" class="b-sel-label"><span>검색어</span></label>
								<input type="text" id="article_val" name="cdn" value=""
									placeholder="검색어를 입력해 주세요">
								<button type="submit" class="b-sel-btn leagueSearchBtn ver2">검색</button>
							</div>

						</fieldset>
					</form>
				</div>
				<!--검색창-->

				<!--공지사항1-->
				<div class="bn-list-img01 type01">
					<div class="b-top-info-wrap"></div>
					<ul class="newul">
					<c:forEach items='${clubBoardList}' var="item" varStatus="status">
						<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
						<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
						
						<li class="newbox-main">
							<div class="newbox-hover">
								<a class="a_top" href="#">
									<div class="newbox-text">
										<span></span>
										<h2>${item.getTitle()}</h2>
										<h3>${inputDate}</h3>
									</div>
								</a> <a class="a_top" href="/clubBoardReadForm.do?board_no=${item.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}">
									<div class="newbox-footer">
										<p>자세히 보기</p>
									</div>
								</a>
								<div class="b-box01">
									<div class="b-num-box">
										<!-- 번호 -->
										<c:choose>
						            		<c:when test='${item.board_fix eq "Y"}'>
												<img src="images/board/ico-notice01.png" valign="middle" alt="고정글">
						            		</c:when>
						            		<c:otherwise>
						            			${item.board_no}
						            		</c:otherwise>
						            	</c:choose>
										<!-- 공지 -->
									</div>
									<div class="b-img-box newclub">
										<a href="/clubBoardReadForm.do?board_no=${item.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}" title="${item.getTitle()} 자세히 보기">
									<c:choose>
										<c:when test="${empty thumbnailList[status.index]}">
											<img alt="기본썸네일이미지" src="custom/img/tmp_gallery_thumb.png" />
										</c:when>
										<c:otherwise>
											<img alt="${thumbnailList[status.index].getFile_nm()}" src="${fn:replace(thumbnailList[status.index].getFile_path(), '/home/club/files','')}" />
											<%-- <img alt="${thumbnailList[status.index].getFile_nm()}" src="/upload/thumbnail/${thumbnailList[status.index].getFile_path()}" /> --%>
										</c:otherwise>
									</c:choose>
										</a>
									</div>
								</div>
								<div class="b-box02">
									<div class="b-title-box top">
										<span></span>
									</div>
									<div class="b-title-box new">
										<a href="/clubBoardReadForm.do?board_no=${item.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}" title="${item.getTitle()} 자세히 보기">
											<strong>${item.getTitle()}</strong>
										</a>
									</div>
									<ul class="b-info-box new">
										<li class="b-hit"><span>조회수</span><span>${item.getOpen_cnt()}</span></li>
										<li class="b-writer"><span>작성자</span>${item.getInput_id()}</li>
										<li class="b-date"><span>작성일</span>${inputDate}</li>
									</ul>
								</div>
							</div>
						</li>
					</c:forEach>
					<c:if test="${boardListCount lt 1}">
						<div class="nophoto">
                            <span>등록된 사진이 없습니다.</span>
                        </div>
					</c:if>
					</ul>
				</div>
				<!--공자사항1-->
				<div class="b-btn-wrap leagueKind">
			<c:choose>
				<c:when test='${board_cd eq "007002"}'>
					<a class="btn b-btn-type01 b-btn-c-blue submit leaugeKind ver2" href="clubBoardWriteForm.do?club_id=${club_id}&board_cd=${board_cd}">등록</a>
				</c:when>
				<c:otherwise>
					<c:if test="${isStaff eq true}">
						<a class="btn b-btn-type01 b-btn-c-blue submit leaugeKind ver2" href="clubBoardWriteForm.do?club_id=${club_id}&board_cd=${board_cd}">등록</a>
					</c:if>
				</c:otherwise>
			</c:choose>
				</div>
				<!--공지사항2-->
				<div class="b-paging01 type03">
                   	<jsp:include page="/WEB-INF/jsp/community/board/item/paging.jsp" />
				</div>
				<!--공지사항2-->
				<div class="b-btn-wrap"></div>
				<form name="admin-form" method="post" action="">
					<input type="hidden" name="method"> <input type="hidden"
						name="articles"> <input type="hidden" name="confirMode">
				</form>
			</div>
		</div>
	</div>
</body>
</html>