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
		<i class="fas fa-user-check"></i>${headTitle}
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
				<form method="post" action="/clubBoardUpdateAction.do" accept-charset="UTF-8" name="board_form" enctype="multipart/form-data" onsubmit="return check_form();">
					<fieldset>
						<legend class="hide">${headTitle} 등록</legend>
						<input type="hidden" name="csrfToken" value="cryjsjscbszhtaostgll">
						<input type="hidden" name="articleNo" value="">
						<input type="hidden" name="parentNo" value="0">
						<input type="hidden" name="htmlYn" value="Y">
						<input type="hidden" name="club_id" value="${club_id}">
						<input type="hidden" name="board_cd" value="${board_cd}">
						<input type="hidden" name="board_no" value="${board_no}">
						<div class="b-table-wrap">
							<!--제목-->
							<div class="b-table-box type01 b-subject-box">
								<div class="b-row-box">
									<div class="b-title-box ver2 b-required">
										<label for="articleTitle">제목</label>
									</div>
									<div class="b-con-box ver2">
										<input class="jwvalid-must-title b-input type01 ver2"
											type="text" id="articleTitle" name="title" value="${searchBoard.getTitle()}"
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
							<c:if test="${isStaff eq true}">
							<div class="b-table-box type01 b-notice-box">
								<div class="b-row-box">
									<div class="b-title-box ver2">공지여부</div>
									<div class="b-con-box ver2">
										<div class="b-period-box">
											<p>
												<input type="checkbox" id="fix_yn" name="fix_yn" class="b-chk ver2" value="Y"
												<c:if test='${searchBoard.board_fix eq "Y"}'>
			                               			checked
			                               		</c:if>
												>
												<!-- wr-notice-name -->
												<label for="fix_yn">공지여부 선택</label>
											</p>
											<!-- 
                                                           <div>
                                                               <label for="noticeStartDt" class="hide">공지시작일</label>
                                                               <input data-valid-title="공지시작일" title="시작 날짜" class="calendar datepicker b-input jwvalid-less-noticeStartDt-noticeEndDt hasDatepicker dark" maxlength="10" type="text" id="noticeStartDt" name="noticeStartDt" value="" readonly="readonly"><span>~</span>						
                                                               <label for="noticeEndDt" class="hide">공지종료일</label>
                                                               <input data-valid-title="공지종료일" title="마지막 날짜" class="calendar datepicker b-input jwvalid-greater-noticeStartDt-noticeEndDt hasDatepicker dark" maxlength="10" type="text" id="noticeEndDt" name="noticeEndDt" value="" readonly="readonly"> 
                                                           </div>
                                                            -->
										</div>
									</div>
								</div>
							</div>
							</c:if>

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
										<textarea id="articleText" name="contents">${searchBoard.getContents()}</textarea>
									</div>
								</div>
							</div>



							<!--첨부파일-->
							<div class="b-table-box type01">
								<div class="b-row-box">
									<div class="b-title-box ver2">첨부파일</div>
									<div class="b-con-box02 ver2">
									<c:if test="${fileListCnt gt 0}">
                                      	<div class="b-file-box type04">
                                        <c:forEach items='${fileList}' var="item" varStatus="status">
						      				<div class="attach-data">
												<div>
													<p>
													<input class="attch-del-check b-chk" type="checkbox" id="${item.file_no}" name="deleteAttach" value="${item.file_no}">
								                    <label for="${item.file_no}" class="del">${item.file_nm}</label>
													</p>
								                    <label class="txt-btn sm on" for="${item.file_no}"><span class="b-file-del-btn">삭제</span></label>
												</div>
												<!-- 
				                                <div class="b-guide-box">
				                                	<input type="hidden" name="editAttach${status}" value="${item.file_no}">
				                                    <label class="b-guide-txt hide" for="editAlt${status}">대체 텍스트 </label> 
				                                    <input data-valid-title="대체텍스트" class="b-input file-alt" type="text" id="editAlt${status}" name="editAlt${status}" value="" placeholder="대체텍스트를 입력해주세요.">
				                                </div>
				                                 -->
											</div>
										</c:forEach>
										</div>
                                    </c:if>
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

							<!-- 보안 문자 -->

							<!--개인정보 보호 동의-->
							<!--
                                            <div class="b-table-box type01">
                                                <div class="b-row-box">
                                                    <div class="b-title-box b-required">
                                                        <label>개인정보 보호 동의</label>
                                                    </div>
                                                    <div class="personal_info b-con-box">
                                                        <ul>
                                                            <li>개인정보보호법 제 15조에 의한 <span>개인정보 수집·이용 동의</span></li>
                                                            <li>고객님의 개인정보를 아래와 같이 처리함을 알려드립니다.</li>
                                                            <li>
                                                                <ul>
                                                                    <li>1. 개인정보의 수집·이용 목적 : 축구참가신청 서비스 제고를 위해 수집</li>
                                                                    <li>2. 수집 항목 : 필수 항목(성명,휴대전화,이메일)</li>
                                                                    <li>3. 보유 및 이용기간 : 개인정보취급방침에 따름</li>
                                                                    <li>4. 동의를 거부할 권리가 있으며, 동의거부 시 글쓰기가 불가하오니 양지하시기 바랍니다.</li>
                                                                </ul>
                                                            </li>
                                                            <li>개인정보보호법 제 15조에 따라 위 각호사항을 고지받고 개인정보 처리에 동의 합니다.</li>
                                                        </ul>
                                                        <div class="b-agree-box">
                                                            <input type="radio" class="b-radio" name="infoProtectYn" id="agree01" value="Y"><label for="agree01">동의함</label>
                                                            <input type="radio" class="b-radio" name="infoProtectYn" id="agree02" value="N"><label for="agree02">동의안함</label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            -->
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