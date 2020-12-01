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
	<script type="text/javascript">
		function getSingleBoard(data1, data2) {
	     	location.href="/clubBoardReadForm.do?club_id=" + data1 + "&board_no=" + data2;
	     }
	</script>
</head>
<body>
	<div class="content-wrap new">
	    <div class="title">
	        <div class="jwxe_mnu_template jw-relative page-title">
	            <h3>${headTitle}</h3>
	        </div>
	    </div>
	    <div class="tab"></div>
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
	                    <div class="b-main-box ver2">
	                        <div class="b-top-box ver2">
	                            <p class="b-title-box"><span>${searchBoard.getTitle()}</span></p>
	                            <div class="b-etc-box">
	                                <ul>
	                                    <li class="b-hit-box">
	                                        <span>조회수</span>
	                                        <span>${searchBoard.getOpen_cnt()}</span>
	                                    </li>
	                                    <li class="b-writer-box">
	                                        <span>작성자</span>
	                                        <span>${writerName}</span>
	                                    </li>
	                                    <li class="b-date-box">
	                                        <span>작성일</span>
	                                        <fmt:parseDate value="${searchBoard.getInput_date()}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
											<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
	                                        <span>${inputDate}</span>
	                                    </li>
                                   	<c:if test='${not empty searchBoard.getUpdate_id()}'>
	                                    <li class="b-writer-box">
	                                        <span>수정자</span>
	                                        <span>${editorName}</span>
	                                    </li>
	                                    <li class="b-date-box">
	                                        <span>수정일</span>
	                                        <fmt:parseDate value="${searchBoard.getUpdate_date()}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
											<fmt:formatDate value="${tmp}" var="updateDate" pattern="yyyy.MM.dd"/>
	                                        <span>${updateDate}</span>

	                                    </li>
	                                </c:if>
	                                </ul>
	                            </div>
	                            <div class="b-etc-box">
                                	<ul>
                                    	<li class="b-date-box">
                                        	<span>기간</span>
                                        	<span>${start_date} ~ ${end_date}</span>
                                    	</li>
                                	</ul>
                            	</div>
	                        </div>
	                        <div class="b-content-box">
                               <div class="fr-view">
                               		${searchBoard.getContents()}
	                                <textarea id="articleText" name="contents" class="b-input b-textarea jwvalid-must-contents ceditor" rows="10" cols="30" data-editor-height="500" style="height: 0px; border: none; position: absolute; left: -99999px;">
	                                </textarea>
                                </div>
	                        </div>
	                    </div>
                    <c:if test="${fileListCnt gt 0}">
	                    <div class="b-file-box ver2">
	                        <ul>
	                        <c:forEach items='${fileList}' var="item">
	                            <li>
	                                <a class="file-down-btn pptx" href="javascript:getDownLink('${club_id}', '${board_cd}', '${item.getFile_no()}');">
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
							<a class="b-btn-type01 b-btn-c-white ver2" id="deleteArticle" href="/clubBoardDeleteAction.do?board_no=${searchBoard.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}" onclick="return confirm('삭제 하시겠습니까?');">삭제</a>
	                        <a class="b-btn-type01 b-btn-c-white ver2" href="/clubBoardUpdateForm.do?board_no=${searchBoard.getBoard_no()}&club_id=${club_id}&board_cd=${board_cd}">수정</a>
	                        <c:if test="${isStaff eq true}">
	                        <a class="b-btn-type01 b-btn-c-blue submit modify" href="/clubBoardList.do?club_id=${club_id}&board_cd=${board_cd}">목록</a>
	                        </c:if>
						</c:if>
	                    </div>
	                    <div class="b-pager-box">
	                        <div class="prever2">
	                            <p>이전글</p>
	                            <p>
	                            <c:choose>
									<c:when test="${not empty prevBoard}">
                                    	<a href="javascript:getSingleBoard('${club_id}', '${prevBoard.board_no}');">
                                        	${prevBoard.title}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                    	<a href="#" title="이전글이 없습니다.">이전글이 없습니다.</a>
                                   	</c:otherwise>
                                </c:choose>                                    
	                            </p>
	                        </div>
	                        <div class="nextver2">
	                            <p>다음글</p>
	                            <p>
	                            <c:choose>
                                	<c:when test="${not empty nextBoard}">
                                    	<a href="javascript:getSingleBoard('${club_id}', '${nextBoard.board_no}');">
                                        	${nextBoard.title}
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
</body>
</html>