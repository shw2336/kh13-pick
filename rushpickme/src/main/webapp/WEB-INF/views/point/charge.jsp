<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .charge-item {
        width: 50%;
    }

    .container {
        border-radius: 30px;
        border: 2px solid gainsboro;
        box-shadow: 0px 4px 4px 2px gainsboro;
        padding: 50px;
    }

    .buy-button {
        background-color: rgb(66, 126, 66);
        color: white; /* 텍스트 색상 */
        padding: 10px 20px; /* 버튼 내부 여백 */
        border: none; /* 테두리 제거 */
        border-radius: 5px; /* 버튼 모서리 둥글게 */
        cursor: pointer;
        transition: background-color 0.3s; /* 배경색 변화에 대한 transition 효과 */
    }

    /* 호버 효과 */
    .buy-button:hover {
        background-color: rgb(46, 106, 46); /* 호버 시 변경될 배경색 */
    }
</style>

<div class="cell center container w-1000">
    <img src="/image/charge.png">

    <c:forEach var="pointDto" items="${list}">
        <div class="cell center"> 
            <img src="${pageContext.request.contextPath}/image?pointNo=${pointDto.pointNo}"> <br>
            <fmt:formatNumber value="${pointDto.pointSell}" pattern="#,##0"/>원

            <!-- 구매를 위한 form 생성 -->
            <form action="charge" method="post">
                <input type="hidden" name="pointNo" value="${pointDto.pointNo}">
                <input type="number" name="buyQty" value="1" size="5" required>
                <button class="buy-button">구매</button>
            </form>
            <script>
            </script>
        </div> <!-- 추가된 부분 -->
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
