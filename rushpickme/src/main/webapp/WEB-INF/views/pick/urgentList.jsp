<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

table > tbody > .contents-tr {
	cursor: pointer;
	height: 40px;
}
     
</style>

<script type="text/javascript">

	function detail (no){
		window.location.href = "urgentDetail?applyNo=" + no;
	}
	function moveList (){
		window.location.href = "list";
	}
	function waitList (){
		window.location.href = "waitList";
	}
	function proceedList (){
		window.location.href = "proceedList";
	}	
	function rejectList (){
		window.location.href = "rejectList";
	}
	function finishList (){
		window.location.href = "finishList";
	}

</script>
	
<!-- 이동버튼 구역 -->
	<div class="container w-800">
		<button type="button" class="btn move" onclick="moveList();">
			<span class="btn-name">전체 목록 보기</span>
		</button>
			<span>&nbsp;&nbsp;</span>
		<button type="button" class="btn move" onclick="waitList();">
			<span class="btn-name"><span style="color:rgb(66,138,66); font-size:15px;">일반</span>
			<span>&nbsp;</span>수거대기건</span>
		</button>
			<span>&nbsp;&nbsp;</span>
		<button type="button" class="btn move" onclick="proceedList();">
			<span class="btn-name">나의 진행건</span>
		</button>
			<span>&nbsp;&nbsp;</span>
		<button type="button" class="btn move" onclick="rejectList();">
			<span class="btn-name">나의 거부건</span>
		</button>
			<span>&nbsp;&nbsp;</span>
		<button type="button" class="btn move" onclick="finishList();">
			<span class="btn-name">나의 완료건</span>
		</button>
	</div>
<!-- ------------- -->

	<div class="container pick-container w-800 py-30 px-50 my-50">
		
		<div class="cell flex-cell pb-10">
			<div class="cell">
				<span style="font-size:25px; font-weight:bold;">수거 대기건</span>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<i class="fa-solid fa-bomb red"></i>
				<span style="color: rgb(66,138,66); font-weight:bold;">수거 신청</span> 후 
				<span style="color: rgb(255, 128, 128); font-weight:bold;">6시간 지난</span> 건 입니다.
				고객님께 <span style="color: rgb(66,138,66); font-weight:bold;">접수 여부</span>를 알려주세요!
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
				</tr>
			</thead>
		
			<tbody>
				<c:forEach var="urgentList" items="${urgentList}">
					<tr onclick="detail('${urgentList.applyNo}');" class="contents-tr">
						<td>${urgentList.applyNo}</td>
						<td>${urgentList.applyAddress1}</td>
						<td>${urgentList.applyVinyl}</td>
						<td><fmt:formatDate value="${urgentList.applyDate}"
						pattern="MM월 dd일" /></td>
						<td>${urgentList.applyHopeDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
		<form action="urgentList">
			<jsp:include page="/WEB-INF/views/template/pickNavigator.jsp"></jsp:include>
		</form>
	</div>
	

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
