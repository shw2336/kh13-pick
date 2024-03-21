<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script
	src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<style>
.form-input {
	font-size: 18px;
	padding: 0.3em;
	border: 1px solid #636e72;
	border-radius: 0.5em;
}

.wid {
	max-width: 10em;
}
.ff {
	color: #ff8080;
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

.fixed-height-td {
    height: 60px; /* 고정하려는 높이 설정 */
    width: 60px;
}

.fixed-height-td img {
    max-width: 60px; /* 이미지의 최대 너비를 100%로 설정하여 부모 요소에 맞춥니다. */
    max-height: 60px; /* 이미지의 높이를 자동으로 조절하여 비율을 유지합니다. */
}

</style>

<script>
	$(function() {
		//출력용
		$(".score").score({
			starColor : "#ff8080", //별 색상
			display : {//표시 옵션
				showNumber : false,//숫자 표시 여부
				textColor : "#ff8080", //글자 색상
				placeLimit : 0,//표시할 소수점 자리수
			},
		});
	});
</script>


<div class="container pick-container w-800 py-30 px-50 my-50">
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

<br>
	<div class="cell">
		<%-- 테이블 --%>
		<table class="table table-horizontal table-hover">
			<thead>
				<tr>
					<th>번호</th>
					<th class="ff">별점</th>
					<th width="40%">리뷰내용</th>
					<th>조회수</th>
					<th>글쓴이</th>
					<th>작성일</th>
				</tr>
			</thead>

			<tbody align="center">
				<c:forEach var="reviewDto" items="${list}">
					<tr>
						<td>${reviewDto.reviewNo}</td>
						<%-- 별점 --%>
						<td>
							<div class="cell">
								<div class="score" data-max="5.0"
									data-rate="${reviewDto.reviewStar}">
								</div>
							</div>
						</td>
						<td class="center ellipsis wid fixed-height-td">
							<%-- 내용 출력 --%> <a class="link link-animation"
							href="detail?reviewNo=${reviewDto.reviewNo}">
								${reviewDto.reviewContent} </a>
						</td>
						<td>${reviewDto.reviewHits}</td>
						<td>${reviewDto.memberIdStr}</td>
						<td>${reviewDto.reviewWriteStr}</td>
					</tr>
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




