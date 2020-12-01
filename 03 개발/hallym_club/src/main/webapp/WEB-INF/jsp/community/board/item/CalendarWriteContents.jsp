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
	<h1>
		<i class="far fa-calendar-alt"></i>${headTitle}
	</h1>
	<!--공지사항-->
	<div class="content" id="jwxe_main_content">
		<script type="text/javascript">
                        //<![CDATA[
                          var resPath = '/_custom/hallym/resource/', isEditorImageUpload = 'true' == 'false'? false: true, 
                          clientId = 'hallym', boardTy = 'common', boardNo = '1267', siteId = 'league';
                        //]]>
                    </script>
		<div class="ko board write co-board type01">
			<div class="bn-write-common01 type01">
				<!-- 사용여부를  게시판 수정시 기타 설정에서 선택할수 있는 필드  -->
				<form method="post" action="/clubBoardWriteAction.do" accept-charset="UTF-8" name="board_form" enctype="multipart/form-data" onsubmit="return check_form();">
					<fieldset>
						<legend class="hide">${headTitle} 등록</legend>
						<input type="hidden" name="csrfToken" value="cryjsjscbszhtaostgll">
						<input type="hidden" name="articleNo" value="">
						<input type="hidden" name="parentNo" value="0">
						<input type="hidden" name="htmlYn" value="Y">
						<input type="hidden" name="club_id" value="${club_id}">
						<input type="hidden" name="board_cd" value="${board_cd}">
						<div class="b-table-wrap">
							<!--제목-->
							<div class="b-table-box type01 b-subject-box">
								<div class="b-row-box">
									<div class="b-title-box ver2 b-required">
										<label for="articleTitle">제목</label>
									</div>
									<div class="b-con-box ver2">
										<input class="jwvalid-must-title b-input type01 ver2"
											type="text" id="articleTitle" name="title" value=""
											maxlength="120">
									</div>
								</div>
							</div>

							<!--비밀번호-->
							<!-- 
                                            <div class="b-table-box type01">
                                                <div class="b-row-box">
                                                    <div class="b-title-box b-required">
                                                        <label for="writerPw">비밀번호</label>
                                                    </div>  
                                                    <div class="b-con-box">
                                                        <div class="b-password-box">
                                                            <input type="password" id="writerPw" name="writerPw" maxlength="4" class="jwvalid-must-pwd b-input type01">
                                                            <span>비밀번호 4자리를 숫자로 입력해주세요</span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            -->
							
							<!--일정 기간 -->
                            <div class="b-table-box type01 b-notice-box">
                            	<div class="b-row-box">
                                	<div class="b-title-box ver2 newform">
                                        <label for="clubDates">일정 기간</label>
                                    </div>
                                    <div class="b-con-box ver2">
                                        <input name="start_date" title="시작 날짜" class="showdate ver2" id="leagueStart" type="text" maxlength="10" readonly="readonly" value="" data-valid-title="일정시작일">
                                        ~
                                        <input name="end_date" title="종료 날짜" class="showdate ver2" id="leagueEnd" type="text" maxlength="10" readonly="readonly" value="" data-valid-title="일정마감일">		
                                    </div>
                                </div>
                            </div>

							<!--작성자-->
							<div class="b-table-box type01">
								<div class="b-row-box">
									<div class="b-title-box ver2 b-required">작성자</div>
									<div class="b-con-box ver2">
										<label for="writerNm" class="hide">작성자</label> <input
											data-valid-title="작성자명"
											class="jwvalid-must b-input ver2 type02" type="text"
											id="writerNm_view" name="writer_view" value="${writerName}"
											disabled=""> <input data-valid-title="작성자"
											class="hide hide2" type="text" id="writerNm" name="writer"
											value="${writer}">
									</div>
								</div>
							</div>

							<!--내용-->
							<div class="b-table-box type01">
								<div class="b-row-box">
									<div class="b-title-box ver2 b-required">
										<label for="articleText">내용</label>
									</div>
									<div class="b-con-box ver2">
										<textarea id="articleText" name="contents"></textarea>
									</div>
								</div>
							</div>
							
							<!--첨부파일-->
							<div class="b-table-box type01">
								<div class="b-row-box">
									<div class="b-title-box ver2">첨부파일</div>
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
													<label for="attachCnt">파일 갯수를 지정해 주십시오. </label> <span
														class="privacy">※ 악성파일 또는 저작권 침해 파일 업로드 금지</span>
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
	                                                    <input type="text" id="file_view${fnum}" name="wr-file-name" class="b-input ver2" placeholder="첨부파일을 등록하세요" readonly="">  <!--  name="wr-file-name" -->
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
						<a class="b-btn-type01 b-btn-c-white ver2" title="취소" href="javascript:ListForm();">취소</a>
						<!-- 삭제버튼 -->
						<button type="submit"
							class="b-btn-type01 b-btn-c-blue submit modify">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>