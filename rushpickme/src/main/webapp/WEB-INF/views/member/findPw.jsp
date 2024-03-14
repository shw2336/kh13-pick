<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    	
    	<div class="container w-600"></div>
    	
    	<form action="findPw" method="post">
    	<div class="cell center">
    	<h2 style="color:green"> 비밀번호찾기</h2>
    	</div>
    	<div class="cell center">
    	아이디<input type="text" name="memberId" required>
    	</div>
    	<div class="cell center">
    	이메일<input type="email" name="memberEmail"required>
    	</div>
    	<div class="cell center">
    	<button class="btn positive" type="submit">찾기</button>
    	</div>
    	</form>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>