<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        margin: 0 auto;
        padding: 20px;
        border-radius: 10px;
        border: 1px solid #ddd;
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.1);
        width: 80%;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }

    th, td {
        border: 1px solid #ddd;
        padding: 10px;
        text-align: center;
    }

    th {
        background-color: #f2f2f2;
    }

    tbody tr:nth-child(even) {
        background-color: #f9f9f9;
    }

    tbody tr:hover {
        background-color: #f2f2f2;
    }

    .cell {
        margin-top: 20px;
    }

    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 20px;
    }

    .pagination a {
        display: inline-block;
        padding: 8px 16px;
        text-decoration: none;
        color: #333;
        border: 1px solid #ccc;
        border-radius: 4px;
        transition: background-color 0.3s;
    }

    .pagination a.active {
        background-color: #007bff;
        color: white;
    }

    .pagination a:hover:not(.active) {
        background-color: #ddd;
    }
</style>

<div class="center">
    <img src="/image/picklist.png">
</div>

<div class="container">
    <table>
        <thead>
            <tr>
                <th>접수번호</th>
                <th>신청번호</th>
                <th>증량</th>
                <th>금액</th>
                <th>수거예정일시</th>
                <th>수거상태</th>
                <th>수거거부상태</th>
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
                    <td>${checkList.pickDelete}</td>
                    <td>${checkList.pickReject}</td>
                    <td><fmt:formatDate value="${checkList.pickFinishDate}" pattern="MM월 dd일 HH:mm"/></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="cell">
    <%-- 네비게이터 --%>
    <jsp:include page="/WEB-INF/views/template/pickPageNavigator.jsp"></jsp:include>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
