<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>충전 상품 목록</h1>

<h2><a href="add">신규등록</h2>

<table border="">
	<c:forEach var="pointDto" items="${list}">
	<tr>
		<td><img src="image?pointNo=${pointDto.pointNo}"></td>
		<td>${pointDto.pointName}</td>
		<td>${pointDto.pointSell}원</td>
		<td>${pointDto.pointCharge}포인트 충전</td>
		<td>
		<a href="edit?pointNo=${pointDto.pointNo}">수정</a>
			<a href="delete?pointNo=${pointDto.pointNo}">삭제</a>
		</td>
	</tr>
	</c:forEach>
</table>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>