<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>

.button-container {
	display: flex;
	justify-content: space-between;
	margin-top: 100px;  
}

.button-container::before, .button-container::after {
	content: "";
	flex-grow: 1;
}

.button-container button {
	width: calc(100% - 5px); 
}
</style>

 




<body>
	<div class="container w-1200">
		<div class="cell center">
			<h1 style="color:green">회원 가입</h1>
		</div>
		<h2 class="cell center">환영 합니다</h2>
		<img width="100%" src="https://picsum.photos/id/12/500/200">

		<div class="button-container">
			<button class="btn positive" type="button"
				onclick="location.href='signUpGreen'">일반회원</button>
			<button class="btn nagative" type="button"
				onclick="location.href='signUpPick'">수거회원</button>
		</div>
	</div>

</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
