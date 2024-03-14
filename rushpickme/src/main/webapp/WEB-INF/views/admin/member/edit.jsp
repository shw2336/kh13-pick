<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="cell center container w-800">
<h1>회원 정보 수정</h1>

<%--
	추가로 전달할 정보 - 아이디(hidden)
	수정할 정보 - 닉네임,이메일,생년월일,연락처,주소,(+등급,포인트)	
 --%>
 
<form action="edit" method="post">
	<input type="hidden" name="memberId" value="${memberDto.memberId}">
	
	닉네임<input type="text" name="memberNick" value="${memberDto.memberNick}" required> <br><br>
	전화번호<input type="tel" name="memberContact" value="${memberDto.memberContact}" required> <br><br>
	등급
	<select name ="memberType" required >
		<option value = "">선택하세요</option>
		<option value = "그린"  ${memberDto.memberType == '그린' ? 'selected' : ''}>그린</option>
		<option value = "피커"  ${memberDto.memberType == '피커' ? 'selected' : ''}>피커</option>
		<option value = "관리자"  ${memberDto.memberType == '관리자' ? 'selected' : ''}>관리자</option>
	</select>
	
	<button>변경</button>
</form>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>