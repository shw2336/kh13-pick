<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page = "/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>충전 상품 수정</h1>

<form action="edit" method="post" enctype="multipart/form-data">
<input type="hidden" name ="pointNo" value ="${pointDto.pointNo}">

상품명 <input type="text" name="itemName" value="${pointDto.pointName}" required><br><br>
판매가 <input type="number" name="itemPrice" value="${pointDto.pointSell}" required><br><br>
충전액 <input type="number" name="itemCharge" value="${pointDto.pointCharge}" required><br><br>

<input type = "file" name = "attach"><br><br>

<img src = "image?pointNo=${pointDto.pointNo}" width="100"><br><br>


<button>변경</button>

</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>