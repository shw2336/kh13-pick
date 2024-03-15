<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    		
    	<div class="container w-1200">
    	<div class="cell center">
    	<h2 style="color:green">비밀번호 찾기</h2>
    	</div>
    	<form action="changepassword" method="post">
    	<div class="cell center">
    	아이디<input type="text" name="memberId" required class="tool w-20">
    	</div>
    	<div class="cell center">
    	이메일<input type="email" name="memberEmail" class="tool w-20"required>
    	</div>
    	<div class="cell center">
    	<button class="btn positive" type="submit">전송</button>
    	</div>
    	</form>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>