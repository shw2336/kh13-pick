<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <style>
    .detail-tool {
    font-size: 20px;
    padding: 0.5em 1em;
    outline: none;
    border-top: none;
    border-left: none;
    border-right: none;
    border-bottom: 1px solid #636e72;
}
    
    
    </style>
    		
    	<div class="container pick-container w-700 p-20 mb-50">
    	<div class="cell center">
    	<h2>비밀번호 찾기</h2>
    	</div>
    	<form action="changepassword" method="post">
    	<div class="cell center">
    	아이디<input type="text" name="memberId" required class="detail-tool">
    	</div>
    	<div class="cell center">
    	이메일<input type="email" name="memberEmail" class="detail-tool"required>
    	</div>
    	<div class="cell center">
    	<button class="btn submit" type="submit">전송</button>
    	</div>
    	</form>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>