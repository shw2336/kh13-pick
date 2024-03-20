<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 내가 구현한 스타일 -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .form-input {
        font-size: 18px;
        padding: 0.3em;
        border: 1px solid #636e72;
        border-radius: 0.5em;
    }
    
         .pick-container {
         border-radius: 10px;
         border: 1px solid gainsboro;
         box-shadow: 0px 4px 4px 2px gainsboro;
     }
     
     table > tbody > .contents-tr {
     	cursor: pointer;
     	height: 40px;
     }
</style>

<div class="container pick-container w-800 py-30 px-50 my-50">
	<div class="cell">
		<h1>Q&A</h1>
	</div>
	<div class="cell">무분별한 비방 또는 욕설은 경고 없이 삭제될 수 있습니다</div>
	<hr>
	<br>
	<div class="cell center">
		<%-- 검색창 --%>
		<form action="list" method="get">
			<select name="column" class="form-input">
				<option value="qna_title"
					${param.column == 'qna_title' ? 'selected' : ''}>제목</option>
				<option value="member_id"
					${param.column == 'member_id' ? 'selected' : ''}>작성자</option>
				<option value="qna_content"
					${param.column == 'qna_content' ? 'selected' : ''}>내용</option>
			</select> <input class="form-input" type="search" name="keyword"
				placeholder="검색어 입력" required value="${param.keyword}">
			<button class="btn positive form-input">검색</button>
		</form>
	</div>

	<div class="cell right">
		<h2>
			<a href="write" class="link">문의하기</a>
		</h2>
	</div>
	<div class="cell">
		<%-- 테이블 --%>
		<table class="table table-horizontal table-hover" >
			<thead>
				<tr>
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="qnaDto" items="${list}">
				<c:if test="${qnaDto.memberId=='adminuser1'}">
				<tr>
				<td>${qnaDto.qnaNo}</td>
						<%-- 제목 칸 --%>
						<td class="left">
							<%-- 답글일 경우만 이미지를 출력 --%> <c:if test="${qnaDto.qnaDepth > 0}">
                     →
                  </c:if> <%-- 제목 출력 --%> <a class="link link-animation"
							href="detail?qnaNo=${qnaDto.qnaNo}"> ${qnaDto.qnaTitle} </a>
						</td>
						<td>${qnaDto.memberIdStr}</td>
						<td>${qnaDto.qnaWriteStr}</td>
						<td>${qnaDto.qnaHits}</td>
					</tr>
				</c:if>
				</c:forEach>
				<c:forEach var="qnaDto" items="${list}">
				<c:if test="${qnaDto.memberId!='adminuser1'}">
					<tr>
						<td>${qnaDto.qnaNo}</td>
						<%-- 제목 칸 --%>
						<td class="left">
							<%-- 답글일 경우만 이미지를 출력 --%> <c:if test="${qnaDto.qnaDepth > 0}">
                     →
                  </c:if> <%-- 제목 출력 --%> <a class="link link-animation"
							href="detail?qnaNo=${qnaDto.qnaNo}"> ${qnaDto.qnaTitle} </a>
						</td>
						<td>${qnaDto.memberIdStr}</td>
						<td>${qnaDto.qnaWriteStr}</td>
						<td>${qnaDto.qnaHits}</td>
					</tr>
				</c:if>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<div class="cell">
		<%-- 네비게이터 --%>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
	</div>

</div>






<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>




