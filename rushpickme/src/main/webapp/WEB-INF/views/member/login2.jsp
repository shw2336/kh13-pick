<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
* {
	padding: 0;
	margin: 0;
	border: none;
}

body {
	font-size: 14px;
	font-family: 'Roboto', sans-serif;
}

.login-wrapper {
	width: 400px;
	height: 350px;
	padding: 40px;
	box-sizing: border-box;
}

.login-wrapper>h2 {
	font-size: 24px;
	color: rgb(255, 128, 128);
	margin-bottom: 20px;
}

#login-form>input {
	width: 100%;
	height: 48px;
	padding: 0 10px;
	box-sizing: border-box;
	margin-bottom: 16px;
	border-radius: 6px;
	background-color: #F8F8F8;
}

#login-form>input::placeholder {
	color: #D2D2D2;
}

#login-form>input[type="submit"] {
	color: #fff;
	font-size: 16px;
	background-color: rgb(255, 128, 128);
	margin-top: 20px;
}

#login-form>input[type="checkbox"] {
	display: none;
}

#login-form>label {
	color: #999999;
}

#login-form input[type="checkbox"]+label {
	cursor: pointer;
	padding-left: 26px;
	background-image: url("checkbox.png");
	background-repeat: no-repeat;
	background-size: contain;
}

#login-form input[type="checkbox"]:checked+label {
	background-image: url("checkbox-active.png");
	background-repeat: no-repeat;
	background-size: contain;
}
</style>
<script>
	$(function() {

		$("#loginButton").click(function() {
			var memberId = $("[name=memberId]").val();
			var memberPw = $("[name=memberPw]").val();

			if (memberId.trim() === '' || memberPw.trim() === '') {
				alert("로그인 정보가 일치하지 않습니다");
			}
		});

		$("input[type=radio]").click(function() {
			$("input[type=radio]").removeClass("flicker_lick");
			$(this).addClass("flicker_lick");
		});
	});
</script>
<body>
<body>
	<div class="container w-1200 " align="center">
		<div class="login-wrapper ">
			<h2>Rush</h2>
			<form method="post" action="/member/login" id="login-form">
				<input type="text" name="memberId" placeholder="ID"> <input
					type="password" name="memberPw" placeholder="Password"> <label
					for="remember-check"> <input type="checkbox"
					id="remember-check">아이디 저장하기
				</label> <br>
				<br>
				<p class="findId">
					아이디 <a class="link" href="/member/findId">찾기</a>
				</p>
				<br>

				<p class="findPw">
					비밀번호 <a class="link" href="/member/findPw">찾기</a>
				</p>
				<br>


				<p class="signUp">
					아직 계정이 없으신가요? <a class="link" href="/member/signUp">회원가입</a>
				</p>
				<br>
				<input type="submit" value="Login">
			</form>
		</div>
</body>
</div>

</div>
</div>
</div>
<c:if test="${param.error != null}">
	<div class="cell center">
		<h3 style="color: red">로그인 정보가 일치하지 않습니다</h3>
	</div>
</c:if>
</div>
</body>


