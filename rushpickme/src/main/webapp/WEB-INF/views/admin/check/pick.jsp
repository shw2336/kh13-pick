<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<div class="cell container w-800 center">
<table>
    <thead>
        <tr>
            <th>접수번호</th>
            <th>신청번호</th>
            <th>증량</th>
            <th>금액</th>
            <th>수거예정일시</th>
            <th>수거상태</th>
            <th>수거거부멘트</th>
            <th>수거완료시간</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="checkList" items="${list}">
            <tr>
                <td>${checkList.pickNo}</td>
                <td>${checkList.applyNo}</td>
                <td>${checkList.pickWeight}</td>
                <td>${checkList.pickPay}</td>
                <td>${checkList.pickSchedule}</td>
                <td>${checkList.pickState}</td>
                <td>${checkList.pickReject}</td>
                <td><fmt:formatDate value="${checkList.pickFinishDate}" 
                pattern="MM월 dd일 HH:mm"/></td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<form action="checkList">
    <jsp:include page="/WEB-INF/views/template/pickNavigator.jsp"></jsp:include>
</form>

</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>