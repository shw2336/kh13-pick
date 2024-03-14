<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>    
.pick-container {
	border-radius: 10px;
	border: 1px solid gainsboro;
	box-shadow: 0px 4px 4px 2px gainsboro;
}
.submit-btn {
	border-radius: 10px !important;
	background-color: white;
	border: 1px solid gainsboro;
	box-shadow: 0px 4px 4px 2px gainsboro;
	font-weight: bold;
}
</style>

<script type="text/javascript">

</script>
    
<form action="complete" method="post" enctype="multipart/form-data" autocomplete="off" class="check-form">

	<input type="hidden" value="${applyNo}" name="applyNo" /> 

	<div class="container w-500 pick-container p-30" style="margin-top: 50px; margin-bottom:80px;">
		<div class="cell">
			<h2>수거 중량</h2>
			<input name="pickWeight" class="tool w-100" placeholder="중량을 입력하세요.">
		</div>

		<div class="cell">
			<h2>수거 금액</h2>
			<input name="pickPay" class="tool w-100" value="">
		</div>
		
		<div class="cell">
			<h2>수거 이미지</h2>
			<input type="file" name="attach" class="image w-100">
		</div>
		
		<div class="cell flex-cell">
			<div class="cell">
				<button type="button" class="btn w-100"  style="border-radius: 10px;">신청정보 다시보기</button>
			</div>
			<div class="cell width-fill right">
				<button type="submit" class="btn w-75" style="border-radius: 10px;">등록하기</button>
			</div>
		</div>
	</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
