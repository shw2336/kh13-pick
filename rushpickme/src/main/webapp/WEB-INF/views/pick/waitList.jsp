<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container w-800 py-50">
	
	<div class="cell">
		<span style="font-size:20px; font-weight:bold;">접수 대기 리스트</span>
	</div>
	
	<div class="cell">
	<table class="table table-horizontal table-hover">
		<thead>
			<tr>
				<th>수거번호</th>
				<th>주소</th>
				<th>배출봉투</th>
				<th>신청일시</th>
				<th>수거희망일시</th>
			</tr>
		</thead>
	
		<tbody>
			<c:forEach var="waitList" items="${waitList}">
				<tr>
					<td>${waitList.applyNo}</td>
					<td>${waitList.applyAddress1}</td>
					<td>${waitList.applyVinyl}</td>
					<td><fmt:formatDate value="${waitList.applyDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${waitList.applyHopeDate}"
					pattern="yyyy-MM-dd HH:mm:ss" /></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	</div>
	
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
