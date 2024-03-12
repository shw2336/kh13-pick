<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    	
    	
    	
    	<div class="container w-1200">
    	<form action="findId" method="post">
    	닉네임<input type="text" name="memberNick" required>
    	<button type="submit">찾기</button>
    	</form>
    	
    	</div>
    
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>