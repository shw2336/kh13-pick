<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.accept-btn, .submit-btn {
	border-radius: 10px !important;
	background-color: white;
	border: 1px solid gainsboro;
	box-shadow: 0px 4px 4px 2px gainsboro;
	font-weight: bold;
}

.selected-btn {
	background-color:rgb(114,188,114);
}

.btn.success {
	border-color: rgb(66,138,66) !important;
}

.btn.fail {
	border-color: red;
}

.btn.success ~.success-feedback, .btn.fail ~.fail-feedback {
	display: block;
}
</style>

<script type="text/javascript">
	$(function() {

		$(document).on("click", ".time-btn", function() {
			$(this).addClass("selected-btn");
			$(".accept-btn").not(this).removeClass("selected-btn");
			$("#pickSchedule").val($(this).text());
		});

		$(".check-form").submit(
			function() {
				var length = $(".selected-btn").length;
				$(".submit-btn").removeClass("success fail").addClass(length > 0 ? "success" : "fail");
			});
	});
	
</script>

<form action="accept" method="post" autocomplete="off" class="check-form">

	<input type="hidden" value="${applyNo}" name="applyNo" /> 
	<input type="hidden" id="pickSchedule" name="pickSchedule" />

	<div class="container w-400" style="margin-top: 50px; margin-bottom:80px;">

		<div class="cell center mb-40">
			<h2><span style="color: rgb(66,138,66)">언제</span> 수거 예정이세요?</h2>
		</div>

		<div class="cell center pb-10">
			<button type="button" class="btn accept-btn time-btn w-75">06시-09시</button>
		</div>

		<div class="cell center pb-10">
			<button type="button" class="btn accept-btn time-btn w-75">09시-12시</button>
		</div>

		<div class="cell center pb-10">
			<button type="button" class="btn accept-btn time-btn w-75">12시-15시</button>
		</div>
		
		<div class="cell center pb-10 mb-40">
			<button type="button" class="btn accept-btn time-btn w-75">15시-18시</button>
		</div>
	
		
		<div class="cell center">
			<button type="submit" class="btn submit-btn w-75" style="border-radius: 10px;">확 정</button>
			<div class="fail-feedback">시간을 선택하세요.</div>
		</div>

	</div>

</form>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>