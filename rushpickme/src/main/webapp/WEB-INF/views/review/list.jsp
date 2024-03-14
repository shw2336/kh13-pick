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
</style>

<div class="container w-800">
	<div class="cell">
		<h1>리뷰게시판</h1>
	</div>
	<div class="cell">무분별한 비방 또는 욕설은 경고 없이 삭제될 수 있습니다</div>
	<hr>
	<br>
	<div class="cell center">
		<%-- 검색창 --%>
		<form action="list" method="get">
			<select name="column" class="form-input">
				<option value="member_id"
					${param.column == 'member_id' ? 'selected' : ''}>작성자</option>
				<option value="review_content"
					${param.column == 'review_content' ? 'selected' : ''}>내용</option>
			</select> <input class="form-input" type="search" name="keyword"
				placeholder="검색어 입력" required value="${param.keyword}">
			<button class="btn positive form-input">검색</button>
		</form>
	</div>

	<div class="cell right">
		<h2>
			<a href="write" class="link">리뷰 작성</a>
		</h2>
	</div>
	<div class="cell">
		<%-- 테이블 --%>
		<table class="table table-horizontal">
			<thead>
				<tr bgcolor=#E9E9ED>
					<th>번호</th>
					<th>별점</th>
					<th width="40%">리뷰내용</th>
					<th>조회수</th>
					<th>글쓴이</th>
					<th>작성일</th>

				</tr>
			</thead>
			<tbody align="center">
				<c:forEach var="reviewDto" items="${topList}">
					<tr bgcolor="#ebf8fa">
						<td>${reviewDto.reviewNo}</td>
						<%-- 별점 칸 --%>
						<td>${reviewDto.reviewStar}</td>
						<td w-40 class="center">
							 <%-- 내용 출력 --%> <a class="link link-animation"
							href="detail?reviewNo=${reviewDto.reviewNo}"> ${reviewDto.reviewContent} </a>
						</td>
						<td>${reviewDto.reviewHits}</td>
						<td>${reviewDto.memberIdStr}</td>
						<td>${reviewDto.reviewWriteStr}</td>
					</tr>
				</c:forEach>
			</tbody>
			<tfoot align="center">
							<c:forEach var="reviewDto" items="${list}">
					<tr>
						<td>${reviewDto.reviewNo}</td>
						<%-- 제목 칸 --%>
						<td>${reviewDto.reviewStar}</td>
						<td w-40 class="center">
							 <%-- 내용 출력 --%> <a class="link link-animation"
							href="detail?reviewNo=${reviewDto.reviewNo}"> ${reviewDto.reviewContent} </a>
						</td>
						<td>${reviewDto.reviewHits}</td>
						<td>${reviewDto.memberIdStr}</td>
						<td>${reviewDto.reviewWriteStr}</td>
					</tr>
				</c:forEach>
			</tfoot>
		</table>
	</div>
	<div class="cell">
		<%-- 네비게이터 --%>
		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
	</div>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>




