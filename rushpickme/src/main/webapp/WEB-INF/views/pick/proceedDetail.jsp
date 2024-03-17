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
	function reject (num) {
		window.location.href = "reject?applyNo=" + num;
	}
	
	function complete (num) {
		window.location.href = "complete?applyNo=" + num;
	}
	
</script>

	<div class="cell center" >
		<h1>
			<span style="color: rgb(66,138,66)">${findApplyDto.memberId}</span> 님의 
			<span style="color: rgb(66,138,66)">${applyNo}번</span> 신청 정보
		</h1>
		
	</div>

<div class="container pick-container w-600 px-50 pt-10 my-50">

	<br>
	<div class="cell">
		<h2>주소</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyPost}" readonly> <input
			class="detail-tool w-100" value="${findApplyDto.applyAddress1}" readonly> <input
			class=" detail-tool w-100" value="${findApplyDto.applyAddress2}" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>봉투개수</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyVinyl}" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>예상무게</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyWeight}" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>수거 희망 날짜</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyHopeDate}" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>남기신 말</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applySay}" readonly>
	</div>
	<br>
		<div class="cell">
		<h2>출입 불가시 이렇게 해 주세요. </h2>
		<input class="detail-tool w-100" style="color: rgb(66,138,66)" value="${findApplyDto.applyWay}" readonly>
		<input class="detail-tool w-100" value="전화번호는 ${memberContact} 입니다." readonly>
	</div>
	<br>
	<div class="cell">
		<h2>배출사진</h2>
		<div class="cell">
				<img src="image/apply?applyNo=${findApplyDto.applyNo}" class="image" width="100%">
		</div>
	</div>
	<br>
	<div class="cell right">
		<button class="btn" onclick="complete('${findApplyDto.applyNo}')">수거완료</button>
		<button class="btn" onclick="reject('${findApplyDto.applyNo}')">거부하기</button>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
