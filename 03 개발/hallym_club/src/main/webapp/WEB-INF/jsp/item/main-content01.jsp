<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<style>

.club {padding:20px 0 50px; background:#F3F3F3;}
.club .intro {overflow:hidden; width:1500px; margin:0 auto;}
.club h2 {position:absolute; overflow:hidden; width:1px; height:1px;}
.club ul {width:700px; margin:0 0 0 30px; padding:0; list-style:none;}
.club li {float:left; width:330px; height:132px; margin:30px 0 0 75px; padding:0; border:5px solid #B4B4B4; background:#FFF;}
.club .thm {float:left; overflow:hidden; width:100px; height:100px; margin:16px; border-radius:30px;}
.club .thm .logo {width:100px; height:100px;}
.club .tit {margin-top:12px; font-weight:600; font-size:18px;}
.club .note { padding-right:15px; line-height:1.6; height: 50px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; text-overflow: ellipsis;}
.club .tag {font-size:13px; color:#888;}


</style>
<body>
	<div class="main-content-box main-content-box01">
		<div class="main-mini-wrap">
			<div class="main-mini-box main-mini-box01">
				<h3 class="main-title">공지사항</h3>
				<div class="mini-board-content">
					<ul>
						<c:forEach items='${boardList}' var="item" varStatus="status">
							<li>
								<a class="articleTitle" href="/BoardReadForm.do?bdc=007001&num=${item.board_no}">
								<p><span class="mini-title">
									<c:if test='${item.board_fix eq "Y"}'>
										[공지]
									</c:if>
									${item.title}
								</span></p></a>
								<span class="mini-date">
									<fmt:parseDate value="${item.input_date}" var="tmp" pattern="yyyy-MM-dd HH:mm:ss.SSS"/>
									<fmt:formatDate value="${tmp}" var="inputDate" pattern="yyyy.MM.dd"/>
									${inputDate}
                            	</span>
							</li>
						</c:forEach>
					</ul>
				</div>
				<a href="#" title="공지사항 더보기" class="viewmore">더보기</a>
			</div>
			<div class="main-mini-box main-mini-box02">
				<h3 class="main-title">동아리</h3>
					<ul class="newclubListBox">
						<c:forEach items='${clubList}' var="item" varStatus="status">
						<li class="newclubList">
							<div class="newclubList_list">
								<div class="newclubList_list-left">
                                    <img src="upload/club/${item.intro_save_file_nm}" onerror="this.src='images/error/error.png'">
                                </div>
                                <div class="newclubList_list-right">
                                    <div class="newclubList_list-right-top">
                                        <span>#${item.gb_nm} #${item.at_nm}</span>
                                    </div>
                                    <div class="newclubList_list-right-middle">
                                    <c:choose>
										<c:when test="${userVO eq null}">
											<a href="clubSearch.do?search=${item.club_nm}"><h3>${item.club_nm}</h3></a>
										</c:when>
									    <c:otherwise>
											<a href="clubIntro.do?club_id=${item.club_id}"><h3>${item.club_nm}</h3></a>
										</c:otherwise>
									</c:choose>
                                    </div>
                                    <div class="newclubList_list-right-bottom">
                                        <div class="bottom-content">
                                            <p>${item.club_aim}</p>
                                        </div>
                                    </div>
                                </div>
							</div>
						</li>
						</c:forEach>
					</ul>
					<a href="clubSearch.do?page=1" title="동아리 더보기" class="viewmore">더보기</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>