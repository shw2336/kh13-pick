<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.detail-tool {
	font-size: 20px;
	padding: 0.5em 1em;
	outline: none;
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 1px solid #636e72;
}

.pick-container {
	border-radius: 10px;
	border: 1px solid gainsboro;
	box-shadow: 0px 4px 4px 2px gainsboro;
}
</style>

<script type="text/javascript">
	function reject (){
		window.location.href = "reject?applyNo=12";
	}
</script>

<div class="container pick-container w-600 px-50 pt-10 my-50">

	<div class="cell">
		<h1>
			<span>testuser1 님의</span>  신청 정보
		</h1>
	</div>
	<br>
	<div class="cell">
		<h2>주소</h2>
		<input class="detail-tool w-100" value="우편번호" readonly> <input
			class="detail-tool w-100" value="주소" readonly> <input
			class=" detail-tool w-100" value="상세주소" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>봉투개수</h2>
		<input class="detail-tool w-100" value="배출봉투" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>예상무게</h2>
		<input class="detail-tool w-100" value="예상무게" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>수거 희망 날짜</h2>
		<input class="detail-tool w-100" value="수거희망날짜" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>남기신 말</h2>
		<input class="detail-tool w-100" value="남기실말" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>배출사진</h2>
		<div class="cell">
<!-- 				<img src="image?applyNo=#"  -->
<!-- 					class="image" width="100%"> -->
		</div>
	</div>
	<br>
	<div class="cell right">
		<button class="btn">접수하기</button>
		<button class="btn"onclick="reject()">거부하기</button>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
