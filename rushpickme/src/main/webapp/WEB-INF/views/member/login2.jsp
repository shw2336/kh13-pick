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



<script>	
	$(document).ready(function(){
		// 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
	    var key = getCookie("key");
	    $("#id").val(key); 
	     
	    // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	    if($("#id").val() != ""){ 
	        $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
	            setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	            deleteCookie("key");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("#id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
	        }
	    });

	// 쿠키 저장하기 
	// setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
	function setCookie(cookieName, value, exdays) {
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value)
				+ ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
		document.cookie = cookieName + "=" + cookieValue;
	}

	// 쿠키 삭제
	function deleteCookie(cookieName) {
		var expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName + "= " + "; expires="
				+ expireDate.toGMTString();
	}
     
	// 쿠키 가져오기
	function getCookie(cookieName) {
		cookieName = cookieName + '=';
		var cookieData = document.cookie;
		var start = cookieData.indexOf(cookieName);
		var cookieValue = '';
		if (start != -1) { // 쿠키가 존재하면
			start += cookieName.length;
			var end = cookieData.indexOf(';', start);
			if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
				end = cookieData.length;
                console.log("end위치  : " + end);
			cookieValue = cookieData.substring(start, end);
		}
		return unescape(cookieValue);
	}
</script>



<body>
	<div class="container w-1200 " align="center">
		<div class="login-wrapper ">
			<h2>Rush</h2>
			<form method="post" action="/member/login" id="login-form">
				<input type="text" name="memberId" placeholder="ID"> <input
					type="password" name="memberPw" placeholder="Password">
					 <label
					for="remember-check"> <input type="checkbox"
					id="checkId">아이디 저장하기
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
	<br>
		<h3 style="color: red">로그인 정보가 일치하지 않습니다</h3>
	</div>
</c:if>
</div>
</body>


