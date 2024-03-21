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
    	
    	<form action="findPw" method="post">
    	<div class="cell center">
    	<h2> 비밀번호변경 </h2>
    	</div>
    	<div class="cell center">
    	아이디<input class="detail-tool" type="text" name="memberId" required>
    	</div>
    	<div class="cell center">
    	이메일<input class="detail-tool" type="email" name="memberEmail"required>
    	</div>
    	<div class="cell center">
    	<button class="btn submit" type="submit">찾기</button>
    	</div>
    	</form>
    </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>