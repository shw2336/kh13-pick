<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
@import
	url('https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&display=swap')
	;

* {
	box-sizing: border-box;
	padding: 0;
	margin: 0;
}

body {
	width: 100%;
	height: 100vh;
	font-family: 'Roboto', sans-serif;
	font-size: 14px;
	font-weight: 400;
	color: #636e72;
	background-color: #f5f6fa;
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
	background-position: center;
	background-size: cover;
}

a {
	text-decoration: none;
	color: #636e72;
	font-weight: 700;
}

img {
	vertical-align: middle;
}

button {
	cursor: pointer;
}

.blind {
	display: none;
}

/* ================== login wrapper ================== */
.login__wrapper {
	width: 360px;
	height: 640px;
	background: linear-gradient(180deg, rgba(255, 255, 255, 0.05) 0%,
		rgba(255, 255, 255, 0) 100%);
	filter: drop-shadow(0px 20px 30px #dfe6e9);
	backdrop-filter: blur(25px);
	border-radius: 30px;
	border: 2px solid rgba(150, 210, 255, 0.2);
	position: relative;
}

header {
	width: 100%;
	height: 110px;
	padding: 40px 30px 0px 40px;
}

.title {
	font-size: 24px;
	font-weight: 500;
}

.title span {
	display: block;
	font-size: 16px;
	font-weight: 400;
}
.btn--back__container {
    position: absolute;
    top: 30px;
    right: 30px;
    width: 34px;
    height: 34px;
    padding: 5px;
    background: #f5f6fa;
    border: 1px solid rgba(255, 255, 255, 0.4);
    border-radius: 6px;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
}

.btn--back {
	width: 24px;
	height: 24px;
	/* background: linear-gradient(154.48deg, #636e72 27.32%, #636e72 95.74%); */
	border: 1px solid #636e72;
	border-radius: 4px;
	border: 1px solid #636e72;
}

/* ================== login content ================== */
.login__content {
	width: 360px;
	height: 530px;
	background: rgba(255, 255, 255, 0.2);
	border-radius: 30px;
	border: 2px solid rgba(255, 255, 255, 0.2);
	padding: 60px 60px 40px 60px;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	position: absolute;
	bottom: -2px;
	left: -2px;
}

.login__title {
	font-size: 24px;
	color: #636e72;
	padding-bottom: 30px;
}
/* ###### 1. email ###### */
.form-login {
	width: 100%;
}

.email__container, .password__container {
	margin-bottom: 16px;
}

.input__title {
	display: block;
	margin-bottom: 10px;
}

.input__container {
	width: 100%;
	height: 44px;
	background: rgba(255, 255, 255, 0.3);
	border: 1px solid rgba(255, 255, 255, 0.5);
	border-radius: 8px;
	display: flex;
	flex-direction: row;
	justify-content: space-between;
	align-items: center;
	padding: 10px;
	position: relative;
	transition: all 0.2s ease-in-out;
}

.input__container.active {
	border: 1px solid #ff6e84;
}

.input__container>span {
	margin-right: 6px;
}

.input__container input {
	width: 100%;
	height: 100%;
	background-color: transparent;
	border: none;
	padding-right: 18px;
	color: #444444;
}

.input__container input::placeholder {
	font-size: 12px;
	color: #1e3799;
}

.input__container input:focus {
	outline: none;
}

.btn--delete {
	width: 18px;
	height: 18px;
	background: rgba(175, 175, 175, 0.7);
	border-radius: 4px;
	border: none;
	display: none;
	justify-content: center;
	align-items: center;
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
}

.btn--delete.active {
	display: flex;
}

.error-message {
	font-size: 12px;
	color: #ff0000;
	margin-top: 6px;
}
/* ###### 3. remember ID ###### */
.check-id__container {
	margin-bottom: 20px;
}

.check-id__container input[type='checkbox'] {
	display: none;
}

.check-id__container input[type='checkbox']+label span {
	display: inline-block;
	width: 20px;
	height: 20px;
	cursor: pointer;
	margin-right: 6px;
}

.check-id__container input[type='checkbox']:checked+label span {
	background-color: #ccc;
}

.check-id__container label {
	display: flex;
	flex-direction: row;
	align-items: center;
}

/* ###### 4. submit button ###### */
.login__btn__container {
	width: 100%;
	height: 68px;
	background: #f5f6fa;
	border: 1px solid rgba(255, 255, 255, 0.4);
	border-radius: 10px;
	display: flex;
	flex-direction: row;
	justify-content: center;
	align-items: center;
}

.login__btn {
	width: 220px;
	height: 48px;
	background: linear-gradient(154.48deg, #dfe6e9 27.32%, #dfe6e9 95.74%);
	border: 1px solid #dfe6e9;
	border-radius: 8px;
	color: #fff;
	font-weight: 700;
}

/* ###### 5. direction ###### */
.direction__container {
	width: 100%;
	height: 100%;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
}

.direction__container p {
	text-align: center;
	margin-top: 10px;
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
	<div class="container w-1100" align="center">
		<div class="login__wrapper">
			<header>
				<div class="title">
					<a href="#none">Rush</a><span></span>
				</div>
				<div class="btn--back__container"></div>
			</header>
			<div class="login__content">
				<h1 class="login__title">로그인</h1>
				<!-- 0. form -->
				<form action="login" method="post" autocomplete="off"
					class="form-login">
					<!-- 1. email -->
					<div class="email__container">
						<!-- <label for="user-id" class="input__title">아이디</label> -->
						<div id="email-box" class="input__container">
							<span><i class="fa-solid fa-id-card"></i></span> <input
								name="memberId" id="user-email" type="text"
								placeholder="아이디를 입력하세요" onkeypress="emailKeyEvent()" />
							<button id="emailDelete" class="btn--delete"
								onclick="emailDeleteAll()">
								<img src="" alt="전체삭제 아이콘" />
							</button>
						</div>
						<div id="email-error" class="error-message"></div>
					</div>
					<!-- 2. password -->
					<div class="password__container">
						<!-- <label for="user-password" class="input__title">Password</label> -->
						<div id="pw-box" class="input__container">
							<span><i class="fa-solid fa-key"></i></span> <input
								name="memberPw" id="user-password" type="password"
								placeholder="비밀번호를 입력 하세요" onkeypress="pwKeyEvent()" />
							<button id="pwDelete" class="btn--delete" onclick="pwDeleteAll()">
								<img src="" alt="전체삭제 아이콘" />
							</button>
						</div>
						<div id="pw-error" class="error-message"></div>
					</div>
					<!-- 3. remember ID -->
					<div class="check-id__container">
						<input id="" type="checkbox" /> <label for="check-id"><span
							class="check-id__checkbox"></span>일반회원</label>

					</div>

					<div class="cell check-id__container ">
						<input id="" type="checkbox" /> <label for="check-id"><span
							class="check-id__checkbox"></span>수거회원</label>
					</div>
					<!-- 4. submit button -->
					<div class="login__btn__container">
						<button type="submit" id="loginButton" class="login__btn hover"
							onclick="login()">로그인</button>
					</div>
				</form>
				<!-- 5. direction -->
				<div class="direction__container">
				
					<p class="findId">
						아이디 <a href="/member/findId">찾기</a>
					</p>
					
					
					<p class="findPw">
						비밀번호 <a href="#none">찾기</a>
					</p>
					
					
					
					<p class="signUp">
						아직 계정이 없으신가요? <a href="/member/signUp">회원가입</a>
					</p>
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


