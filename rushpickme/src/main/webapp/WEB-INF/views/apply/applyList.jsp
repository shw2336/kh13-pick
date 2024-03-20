
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container pick-container w-800 py-30 px-50 my-50">



	<style>
.pick-container {
	border-radius: 10px;
	border: 1px solid gainsboro;
	box-shadow: 0px 4px 4px 2px gainsboro;
}

table>tbody>.contents-tr {
	cursor: pointer;
	height: 40px;
}
</style>
	<script type="text/javascript">
		function state(no) {
			window.location.href = "stateList?applyNo=" + no;
		}
	</script>

	<div class="cell flex-cell pb-10">
		<div class="cell">
			<span
				style="color: rgb(66, 138, 66); font-size: 25px; font-weight: bold;">${applyDto.memberId}</span>
			님 신청내역 목록 리스트
		</div>
	</div>

	<div class="cell">
		<table class="table table-horizontal table-hover">
			<thead>
				<tr>
					<th>신청번호</th>
					<th>주소</th>
					<th>배출봉투</th>
					<th>신청일시</th>
					<th>수거희망일</th>
					<th>진행 여부</th>
				</tr>
			</thead>

			<tbody>
				<c:forEach var="applyList" items="${applyList}">
					<tr onclick="state('${applyList.applyNo}');" class="contents-tr">
						<td>${applyList.applyNo}</td>
						<td>${applyList.applyAddress1}</td>
						<td>${applyList.applyVinyl}</td>
						<td><fmt:formatDate value="${applyList.applyDate}"
								pattern="MM월 dd일" /></td>
						<td>${applyList.applyHopeDate}</td>
						<td>${applyList.applyState}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
