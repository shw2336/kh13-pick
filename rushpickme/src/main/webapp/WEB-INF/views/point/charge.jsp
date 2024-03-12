<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
        
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>포인트 충전</h1>

<c:forEach var="pointDto" items="${list}">

<hr>
<div>
    <h2>${pointDto.pointName}</h2>
    <img src="image?pointNo=${pointDto.pointNo}"> <br>
    가격 : 
    <fmt:formatNumber value="${pointDto.pointPrice}" pattern="#,##0"/>원
    충전포인트 : 
        <fmt:formatNumber value="${pointDto.pointCharge}" pattern="#,##0"/>포인트

<%-- 구매를 위한 form 생성 --%>
<form action="charge" method="post">
<input type = "hidden" name="pointNo" value="${pointDto.pointNo}">
<input type = "number" name = "buyQty" value ="1" size="5" required>
<button>구매</button>
</form>

</div>
</c:forEach>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>