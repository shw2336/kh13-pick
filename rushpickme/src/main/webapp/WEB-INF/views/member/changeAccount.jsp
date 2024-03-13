<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<form action="changeaccount" method="post" enctype="multipart/form-data" autocomplete="off">
	<div class="container w-500">

		<h1 align="center">개인정보 변경</h1>
	<div style="color:green" class="cell center"><h1>${memberDto.memberName}님</h1></div>
	<div class="cell">
	<label> 닉네임<b style="color:red">*</b></label>
	 <input type="text" name="memberNick" required value="${memberDto.memberNick}"> <br><br>
	</div>
	<div class="cell">
	<label>이메일<b style="color:red">*</b></label> 
	<input type="email" name="memberEmail" required value="${memberDto.memberEmail}"> <br><br>
	</div>
	
	<div class="cell">
	<label>생년월일<b style="color:red">*</b></label> 
	<input type="date" name="memberBirth" value="${memberDto.memberBirth}"> <br><br>
	</div>
	<div class="cell">
	연락처 <input type="tel" name="memberContact" value="${memberDto.memberContact}"> <br><br>
	</div>
	<div class="cell">
	<label>주소</label>
	<br>
	<input type="text" name="memberGreenPost" placeholder="우편번호" value="${memberGreenDto.memberGreenPost}" size="6" maxlength="6"> <br>
	<input type="text" name="memberGreenAddress1" placeholder="기본주소" value="${memberGreenDto.memberGreenAddress1}" size="50"> <br>
	<input type="text" name="memberGreenAddress2" placeholder="상세주소" value="${memberGreenDto.memberGreenAddress2}" size="50"> <br><br>
	</div>
	<div class="cell">
	<label>비밀번호 확인 <b style="color:red">*</b></label>
	 <input type="password" name="memberPw" required> <br><br>
	</div>
	<div class="cell center">
	<button type="submit" class="btn positive">변경하기</button>
	</div>
	</div>
</form>

<div class="cell center">
<c:if test="${param.error!= null}">
	<h3 style="color:red">입력한 정보가 올바르지 않습니다</h3>
</c:if>
</div>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
   