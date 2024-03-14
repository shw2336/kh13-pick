<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .charge-item {
        width: 50%;
    }

    .btn {
        background-color: white;
        cursor: pointer;
    }
    .container{
        box-shadow: 0 0 1px 1px rgb(66, 138, 66);
    }
</style>
<div class="cell center container w-1000">
    <img src="/image/charge.png">

    <c:forEach var="pointDto" items="${list}">
        <div class="cell center"> 
            <img src="image?pointNo=${pointDto.pointNo}"> <br>
            <fmt:formatNumber value="${pointDto.pointSell}" pattern="#,##0"/>원

            <!-- 구매를 위한 form 생성 -->
            <form action="charge" method="post">
                <input type="hidden" name="pointNo" value="${pointDto.pointNo}">
                <input type="number" name="buyQty" value="1" size="5" required>
                <button class="btn" type="submit">
                    <img src="/image/gumae.png">
                </button>
            </form>
            <script>
            </script>
        </div> <!-- 추가된 부분 -->
    </c:forEach>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
