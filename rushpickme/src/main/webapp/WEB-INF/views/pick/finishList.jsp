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
	

</script>

<div class="container pick-container w-800 py-30 px-50 my-50">
	
	<div class="cell flex-cell pb-10">
		<div class="cell">
			<span style="font-size:25px; font-weight:bold;">수거완료 리스트</span>
		</div>
	</div>
	
	<div class="cell">
		<table class="table table-horizontal table-hover">
			<thead>
				<tr>
					<th>수거번호</th>
					<th>신청일시</th>
					<th>수거일시</th>
					<th>수거비용</th>
				</tr>
			</thead>
		
			<tbody>
				<c:forEach var="finishList" items="${finishList}">
					<tr class="contents-tr">
						<td>${finishList.pickNo}</td>
						<td><fmt:formatDate value="${finishList.applyDate}"
								pattern="MM월 dd일 HH시 mm분" /></td>
						<td><fmt:formatDate value="${finishList.pickFinishDate}"
								pattern="MM월 dd일 HH시 mm분" /></td>
						<td>${finishList.pickPay} 원</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>