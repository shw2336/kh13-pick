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

	function detail (num){
		window.location.href = "rejectDetail?pickNo=" + num;
	}
	function moveList (){
		window.location.href = "list";
	}
	function urgentList (){
		window.location.href = "urgentList";
	}
	function waitList () {
		window.location.href = "waitList";
	}
	function proceedList (){
		window.location.href = "proceedList";
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
		<button type="button" class="btn move" onclick="proceedList();">
			<span class="btn-name">나의 진행건</span>
		</button>
			<span>&nbsp;&nbsp;</span>
		<button type="button" class="btn move" onclick="finishList();">
			<span class="btn-name">나의 완료건</span>
		</button>
	</div>
<!-- ------------- -->

<div class="container pick-container w-800 py-30 px-50 my-50">
	
	<div class="cell pb-10">
		<span style="font-size:25px; font-weight:bold;">수거 거부건</span>
	</div>
	
	<div class="cell">
	<table class="table table-horizontal table-hover">
		<thead>
			<tr>
				<th>신청번호</th>
				<th>수거번호</th>
				<th>신청자</th>
				<th>신청일시</th>
				<th>거부사유</th>
			</tr>
		</thead>
	
		<tbody>
			<c:forEach var="rejectList" items="${rejectList}">
				<tr class="contents-tr" onclick="detail('${rejectList.pickNo}');">
					<td>${rejectList.applyNo}</td>
					<td>${rejectList.pickNo}</td>
					<td>${rejectList.memberId}</td>
					<td><fmt:formatDate value="${rejectList.applyDate}"
							pattern="MM월 dd일 HH:mm" /></td>
					<td>${rejectList.pickReject}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	<form action="rejectList">
		<jsp:include page="/WEB-INF/views/template/pickNavigator.jsp"></jsp:include>
	</form>
	
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>