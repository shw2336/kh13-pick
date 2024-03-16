<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        border-radius: 30px;
        border: 2px solid gainsboro;
        box-shadow: 0px 4px 4px 2px gainsboro;
        padding: 50px;
    }

    /* 수정된 부분: 버튼 스타일 */
    button {
        background-color: rgb(66,126,66);
        color: white;
        border: none;
        border-radius: 5px;
        padding: 10px 20px;
        cursor: pointer;
    }

    button:hover {
        background-color: darkgreen;
    }
</style>

<div class="container w-500 center">
    <h1>충전 상품 수정</h1>

    <form action="edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="pointNo" value="${pointDto.pointNo}">

        상품명 <input type="text" name="itemName" value="${pointDto.pointName}" required><br><br>
        판매가 <input type="number" name="itemPrice" value="${pointDto.pointSell}" required><br><br>
        충전액 <input type="number" name="itemCharge" value="${pointDto.pointCharge}" required><br><br>

        <input type="file" name="attach"><br><br>

        <img src="image?pointNo=${pointDto.pointNo}" width="100"><br><br>

        <!-- 수정된 부분: 버튼 스타일 적용 -->
        <button type="submit">변경</button>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
