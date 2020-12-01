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
	<h1><i class="fas fa-exclamation"></i>${headTitle}</h1>
	<div class="content" id="jwxe_main_content_noticeList">
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
					<form method="post" action="/clubBoardList.do" name="boardForm" enctype="multipart/form-data">
						<fieldset class="b-search-wrap">
							<legend class="hide">게시글 검색</legend>
							<input type="hidden" name="mode" value="list">
							<div class="b-sel-box b-cate-basic league" style="z-index: 0;">
								<select class="b-sel-title leagueform ver2" name="opt">
									<option class="searchOption" value="0">전체</option>
									<option class="searchOption" value="1">제목</option>
									<option class="searchOption" value="2">내용</option>
								</select>
								<label for="notice_val" class="b-sel-label"><span>검색어</span></label>
								<input type="text" id="notice_val" name="cdn" value="" placeholder="검색어를 입력해 주세요">
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
							<col class="b-col01 noticeList">
							<col class="b-col02 noticeList">
                                  <col class="b-col03 noticeList">
							<col class="b-col04 noticeList">
							<col class="b-col05 noticeList">
							<col class="b-col06 noticeList">
						</colgroup>
						<thead>
							<tr>
								<th scope="col" class="hver2">번호</th>
								<th scope="col" class="hver2">제목</th>
								<th scope="col" class="hver2">작성자</th>
								<th scope="col" class="hver2">작성일</th>
								<th scope="col" class="hver2">조회수</th>
								<th scope="col" class="hver2">파일</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items='${clubBoardList}' var="item" varStatus="status">
							<tr class="">
								<td class="b-num-box">
			            	<c:choose>
			            		<c:when test='${item.board_fix eq "Y"}'>
									<img src="images/board/ico-notice01.png" valign="middle" alt="고정글">
			            		</c:when>
			            		<c:otherwise>
			            			${item.board_no}
			            		</c:otherwise>
			            	</c:choose>
								</td>
								<td class="b-td-left leagueKind">
									<span><a href="/clubBoardReadForm.do?board_no=${item.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}">${item.getTitle()}</a></span>
									<div class="b-title-box league">
										<!--반응형 모바일 부분-->
										<div class="b-etc-box leagueKind">
							            	<c:choose>
							            		<c:when test='${item.board_fix eq "Y"}'>
													<span><img src="images/board/ico-notice01.png" valign="middle" alt="고정글"></span>
							            		</c:when>
							            		<c:otherwise>
							            			[<span>${item.board_no}]</span>
							            		</c:otherwise>
							            	</c:choose>
                                               <span>${item.getTitle()}</span>
										</div>
										<div class="b-m-con">
											<span class="b-writer">${item.getInput_id()}</span>
											<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
											<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
											<span class="b-writer">${inputDate}</span>
											<span class="b-writer">${item.getOpen_cnt()}</span>           
										</div>
									</div>
								</td>
								<td>${item.getInput_id()}</td>
								<td>${inputDate}</td>
								<td>${item.getOpen_cnt()}</td>
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
								</td>
                                    	</tr>
						</c:forEach>
						<c:if test="${boardListCount lt 1}">
							<td class="b-no-post" colspan="5">
								등록된 글이 없습니다.
							</td>
						</c:if>
						</tbody>
					</table>          
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
				
				<div class="b-btn-wrap"></div>
                      <form name="admin-form" method="post" action="">
                       <input type="hidden" name="method">
                       <input type="hidden" name="articles">
                       <input type="hidden" name="confirMode">
				</form>
			</div>
		</div>
	</div>
</body>
</html>