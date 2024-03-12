<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page ="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <h1>판매 상품 등록</h1>

    <form action = "add" method = "post" enctype = "multipart/form-data">
   	상품명 <input type = "text" name ="pointName" required> <br><br>
   	판매액<input type = "number" name = "pointPrice" required><br><br>
   	충전액<input type = "number" name ="pointCharge"required><br><br>

 	 이미지

   	<input type = "file" name = "attach" accept ="image/*">
   	<br><br>
   	<button>신규등록</button>
    
    </form>
    
    <jsp:include page ="/WEB-INF/views/template/footer.jsp"></jsp:include>
    