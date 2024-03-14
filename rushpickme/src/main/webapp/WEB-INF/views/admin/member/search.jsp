<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    
    <jsp:include page ="/WEB-INF/views/template/header.jsp"></jsp:include>
  	<div class="cell center">
    <h2>검색어를 입력하세요</h2>
    <form action="search" method="get">
	<select name="column">
		<option value="member_id" ${param.column == 'member_id' ? 'selected' : ''}>아이디</option>
		<option value="member_nick" ${param.column == 'member_nick' ? 'selected' : ''}>닉네임</option>
		<option value="member_contact" ${param.column == 'member_contact' ? 'selected' : ''}>연락처</option>
		<option value="member_name" ${param.column == 'member_name' ? 'selected' : ''}>성함</option>
		<option value="member_type" ${param.column == 'member_type' ? 'selected' : ''}>회원유형</option>
				<option value="member_email" ${param.column == 'member_email' ? 'selected' : ''}>이메일</option>
						<option value="member_birth" ${param.column == 'member_birth' ? 'selected' : ''}>생년월일</option>
	</select>
	<input type="search" name="keyword" placeholder="검색어.." required
			value="${param.keyword}">
	<button>찾기</button>
</form>

<hr>

<%-- 조회 결과는 list의 유무에 따라 다르게 출력 --%>
<c:choose>
	<c:when test="${list == null}">
		
	</c:when>
	<c:when test="${list.isEmpty()}">
		<h2>검색 결과가 존재하지 않습니다</h2>
	</c:when>
	<c:otherwise>
		<table border="1" width="800">
			<thead>
				<tr>
					<th>아이디</th>
					<th>닉네임</th>
					<th>연락처</th>
					<th>성함</th>
					<th>회원유형</th>
					<th>이메일</th>
					<th>생년월일</th>
				</tr>
			</thead>
			<tbody align="center">
				<c:forEach var="memberDto" items="${list}">
				<tr>
					<td>${memberDto.memberId}</td>
					<td>${memberDto.memberNick}</td>
					<td>${memberDto.memberContact}</td>
					<td>${memberDto.memberName}</td>
					<td>${memberDto.memberType}</td>
					<td>${memberDto.memberEmail}</td>
					<td>${memberDto.memberBirth}</td>
					<td>
					<a href = "detail?memberId=${memberDto.memberId}">	&raquo;</a>
					</td>
				</tr>
				</c:forEach>
			</tbody>
		</table>
	</c:otherwise>
</c:choose>
</div>
    
    
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>