<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .container {
        border-radius: 10px;
        border: 1px solid gainsboro;
        box-shadow: 0px 4px 4px 2px gainsboro;
        margin: 0 auto;
        text-align: center;
        width: 80%; /* 수정 가능한 부분: 컨테이너 너비 조정 */
    }

    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #dddddd;
        padding: 8px;
        text-align: center;
    }

    th {
        background-color: #f2f2f2;
    }
</style>
<div class="cell container center">    

 <h1>포인트 구매 내역</h1>


    <c:choose>
        <c:when test="${buyList.isEmpty()}">
            <h2 class="empty-msg">구매 내역이 존재하지 않습니다</h2>
        </c:when>
        <c:otherwise>
            <table class="info-table ">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>구매금액</th>
                        <th>구매일시</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="buyDto" items="${buyList}">
                        <tr>
                            <td>${buyDto.buyNo}</td>
                            <td>${buyDto.pointName}</td>
                            <td>${buyDto.buyQty}</td>
                            <td>
                                <fmt:formatNumber value="${buyDto.buyTotal}" pattern="#,##0"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${buyDto.buyDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
