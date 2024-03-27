<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!-- 내가 구현한 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">

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
     
     .wid {
	max-width: 10em;
     

.hei {
 height:3em; /* 원하는 높이로 조정 */
}

.bold-text {
    font-weight: bold;
}

.fixed-height-td {
    height: 60px; /* 고정하려는 높이 설정 */
    width: 60px;
}

</style>

<div class="container pick-container w-800 py-30 px-50 my-50">
	<div class="cell">
		<h1>Q&A / 공지사항</h1>
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
				<option value="member_nick"
					${param.column == 'member_nick' ? 'selected' : ''}>작성자</option>
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
				<tr class="hei">
					<th>번호</th>
					<th width="40%">제목</th>
					<th>작성자</th>
					<th>작성일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="qnaMemberNickVO" items="${list}">
				<c:if test="${qnaMemberNickVO.memberId=='adminuser1'}">
				<tr>
				<td class="bold-text">공지</td>
						<%-- 제목 칸 --%>
						<td class="center ellipsis wid fixed-height-td">
							<a class="link link-animation bold-text"
							href="detail?qnaNo=${qnaMemberNickVO.qnaNo}"> ${qnaMemberNickVO.qnaTitle} </a>
						</td>
						<td class="bold-text">${qnaMemberNickVO.memberNickStr}</td>
						<td class="bold-text">${qnaMemberNickVO.qnaWriteStr}</td>
						<td class="bold-text">${qnaMemberNickVO.qnaHits}</td>
					</tr>
				</c:if>
				</c:forEach>
				<c:forEach var="qnaMemberNickVO" items="${list}">
				<c:if test="${qnaMemberNickVO.memberId!='adminuser1'}">
					<tr>
						<td>${qnaMemberNickVO.qnaNo}</td>
						<%-- 제목 칸 --%>
						<td class="center ellipsis wid fixed-height-td">
							<%-- 답글일 경우만 이미지를 출력 --%> <c:if test="${qnaMemberNickVO.qnaDepth > 0}">
                     →
                  </c:if> <%-- 제목 출력 --%> <a class="link link-animation"
							href="detail?qnaNo=${qnaMemberNickVO.qnaNo}"> ${qnaMemberNickVO.qnaTitle} </a>
						</td>
						<td>${qnaMemberNickVO.memberNickStr}</td>
						<td>${qnaMemberNickVO.qnaWriteStr}</td>
						<td>${qnaMemberNickVO.qnaHits}</td>
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




