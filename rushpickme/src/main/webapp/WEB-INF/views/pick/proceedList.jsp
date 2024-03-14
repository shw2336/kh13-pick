<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
     .pick-container {
         border-radius: 10px;
         border: 1px solid gainsboro;
         box-shadow: 0px 4px 4px 2px gainsboro;
     }
     
     table > tbody > .contents-tr {
     	cursor: pointer;
     	height: 40px;
     }
     
</style>

<script type="text/javascript">

	function detail (no){
		window.location.href = "proceedDetail?pickNo=" + no;
	}

</script>

<div class="container pick-container w-800 py-30 px-50 my-50">
	
	<div class="cell flex-cell pb-10">
		<div class="cell">
			<span style="font-size:25px; font-weight:bold;">수거 진행중...</span>
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
					<td>${proceedList.timePasses}</td>
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