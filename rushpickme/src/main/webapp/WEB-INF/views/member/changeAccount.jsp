<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<h1>회원 정보 변경</h1>

<form action="edit" method="post">
	<input type="hidden" name="memberPw" required value="${dto.memberPw}">
	회원아이디 <input type="text" name="memberId" required value="${dto.memberId}"> <br><br>
	회원닉네임 <input type="text" name="memberNick" required value="${dto.memberNick}"> <br><br>
	생년월일 <input type="date" name="memberBirth" required value="${dto.memberBirth}"> <br><br>
	회원메일 <input type="text" name="memberEmail" required value="${dto.memberEmail}"> <br><br>
	
	
	<button>정보 수정</button>
	
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
