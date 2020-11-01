<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>한림대학교 동아리</title>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/club_main.css?after">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/res/clubOld/css/table.css?after">
</head>
<body>

	<jsp:include page="clubPlatform.jsp"></jsp:include>

	<div class="main">
		<form method=post action="clubProductAction.do">
			<input type="hidden" value="${club_id}" name="club_id">
			<table id="table"
				style="margin: 0 auto; overflow: auto; display: block;">
				<tr>
					<th scope="col" style="width: 20%;">물품명</th>
					<th scope="col" style="width: 10%;">물품 수</th>
					<th scope="col" style="width: 60%; text-align: center;">물품 설명</th>
					<th scope="col" style="width: 10%; text-align: center;">*</th>
				</tr>

				<tbody id="my-tbody">
						<c:choose>
							<c:when test="${(isStaff eq true)}">
								<c:forEach items='${productList}' var="item" varStatus="status">
								<tr>
									<td style="border: 1px solid #dddddd;"><input type="text"
										value="${item.getProductNM()}"
										style="text-align: center; width: 99%; height: 30px;"
										name="product_nm"></td>

									<td style="border: 1px solid #dddddd;"><input type="text"
										value="${item.getTotCnt()}"
										style="text-align: center; width: 100%; height: 30px;"
										name="tot_cnt"
										onKeyup="this.value=this.value.replace(/^[0-9]*$/g,''); numberWithCommas(this);"></td>

									<td style="border: 1px solid #dddddd;"><input type="text"
										value="${item.getProductCont()}"
										style="text-align: center; width: 99%; height: 30px;"
										name="product_cont"></td>
									<td style="border: 1px solid #dddddd; width: 10%;"><span>삭제</span></td>
								</tr> 
								</c:forEach>
							</c:when>

							<c:otherwise>
								<c:forEach items='${productList}' var="item" varStatus="status">
								<tr>
									<td style="border: 1px solid #dddddd;"><input type="text"
										value="${item.getProductNM()}"
										style="text-align: center; width: 99%; height: 30px;"
										name="product_nm" readonly></td>

									<td style="border: 1px solid #dddddd;"><input type="text"
										value="${item.getTotCnt()}"
										style="text-align: center; width: 99%; height: 30px;"
										name="tot_cnt" readonly></td>

									<td style="border: 1px solid #dddddd;"><input type="text"
										value="${item.getProductCont()}"
										style="text-align: center; width: 99%; height: 30px;"
										name="product_cont" readonly></td>
									<td style="border: 1px solid #dddddd; width: 10%;"><span></span></td>
								</tr>
								</c:forEach>
							</c:otherwise>
						</c:choose>
					
				</tbody>

				<c:choose>
					<c:when test="${(isStaff eq true)}">
				<tfoot>
					<tr>
						<td colspan="3"></td>
						<th scope="row">
						<input
							type="submit" value="완료"
							style="float: center; background-color: white; border: 2px solid lightblue; font-size: 13px;">
							<button type="button" onclick="add_row()"
								style="float: center; background-color: white; border: 2px solid lightblue; font-size: 13px;">행
								추가</button>
					</tr>

				</tfoot>
					</c:when>
					<c:otherwise>
				<tfoot>
				</tfoot>
					</c:otherwise>
				</c:choose>
			</table>
		</form>

	</div>

	<script>
		function numberWithCommas(x) {
			var y = x.value;
			y = y.replace(/[^0-9]/g, ''); // 입력값이 숫자가 아니면 공백
			y = y.replace(/,/g, ''); // ,값 공백처리
			var x_id = x.getAttribute('id');
			$('#' + x_id).val(y.replace(/\B(?=(\d{3})+(?!\d))/g, ",")); // 정규식을 이용해서 3자리 마다 , 추가 
		}

		function add_row() {
			var newDiv = document.createElement("tr");
			newDiv.innerHTML = "<td style='border: 1px solid #dddddd;' ><input type='text' style='text-align: center; width: 100px; height: 30px;' name='product_nm'></td> <td style='border: 1px solid #dddddd;'><input type='text' style='text-align: center; width: 50px; height: 30px;' name='tot_cnt' onKeyup=this.value=this.value.replace(/[^0-9]/g,''); numberWithCommas(this);></td> <td style='border: 1px solid #dddddd;'><input type='text' style='text-align: center; width: 500px; height: 30px;' name='product_cont'></td> <td style='border: 1px solid #dddddd;'><span>삭제</span></td>";
			document.getElementById('my-tbody').appendChild(newDiv);
			var objDiv = document.getElementById("table");
			objDiv.scrollTop = objDiv.scrollHeight;
		}
	</script>

	<script type="text/javascript">
		$(function() {
			$("#table").on("click", "span", function() {
				$(this).closest("tr").remove();
			});
		});
	</script>
</body>
</html>