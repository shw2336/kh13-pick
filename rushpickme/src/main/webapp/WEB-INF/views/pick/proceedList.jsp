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
		window.location.href = "proceedDetail?pickNo=" + no;
	}
	function moveList (){
		window.location.href = "list";
	}
	function urgentList (){
		window.location.href = "urgentList";
	}
	function waitList (){
		window.location.href = "waitList";
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
		<button type="button" class="btn move" onclick="urgentList();">
			<span class="btn-name"><span style="color:red; font-size:15px;" >긴급</span>
			<span>&nbsp;</span>수거대기건</span>
		</button>
			<span>&nbsp;&nbsp;</span>
		<button type="button" class="btn move" onclick="waitList();">
			<span class="btn-name"><span style="color:rgb(66,138,66); font-size:15px;" >일반</span>
			<span>&nbsp;</span>수거대기건</span>
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
			<span style="font-size:25px; font-weight:bold;">수거 진행건</span>
			<span>&nbsp;</span>
			<span><i class="fa-solid fa-clock" style="color: rgb(255, 128, 128)"></i> 고객님의 
			<span style="color: rgb(66,138,66); font-weight:bold;">수거 희망일</span>이 지났을 경우 표시됩니다. </span>
		</div>
	</div>
	
	<div class="cell">
	<table class="table table-horizontal table-hover">
		<thead>
			<tr>
				<th>수거번호</th>
				<th>주소</th>
				<th>배출봉투</th>
				<th>신청일시</th>
				<th>수거희망일</th>
				<th></th>
			</tr>
		</thead>
	
		<tbody>
			<c:forEach var="proceedList" items="${proceedList}">
				<tr class="contents-tr" onclick="detail('${proceedList.pickNo}');">
					<td>${proceedList.pickNo}</td>
					<td>${proceedList.applyAddress1}</td>
					<td>${proceedList.applyVinyl}</td>
					<td><fmt:formatDate value="${proceedList.applyDate}"
							pattern="MM월 dd일 HH:mm" /></td>
					<td>${proceedList.applyHopeDate}</td>
					<c:choose>
						<c:when test="${proceedList.timePasses eq 'Y'}">
							<td><i class="fa-solid fa-clock" style="color: rgb(255, 128, 128)"></i></td>
						</c:when>
						<c:otherwise>
							<td><i class="fa-regular fa-clock" style="color: rgb(66,138,66)"></i></td>
						</c:otherwise>
					</c:choose>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<form action="proceedList">
		<jsp:include page="/WEB-INF/views/template/pickNavigator.jsp"></jsp:include>
	</form>
	
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>