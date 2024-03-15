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
	function proceedDetail (num) {
		window.location.href = "proceedDetail?pickNo=" + num;
	}
	
    $(function () {
        var state = {
            pickWeightValid: false,
            pickPayValid: false,
            isOk : function(){
                return this.pickWeightValid && this.pickPayValid;
            }
        };

        $("[name=pickWeight]").blur(function () {
            var regex = /^[0-9]+$/;
            state.pickWeightValid = regex.test($(this).val()) && $(this).val() > 0;
            $(this).removeClass("success fail").addClass(state.pickWeightValid ? "success" : "fail");
        });

        $("[name=pickPay]").blur(function () {
            var regex = /^[0-9]+$/;
            state.pickPayValid = regex.test($(this).val()) && $(this).val() > 0;
            $(this).removeClass("success fail").addClass(state.pickPayValid ? "success" : "fail");
        });
        
		$(".check-form").submit(function(){
			$(this).find("[name]").blur();
			return state.isOk();
		});
    });
</script>
    
<form action="complete" method="post" enctype="multipart/form-data" autocomplete="off" class="check-form">

	<input type="hidden" value="${applyNo}" name="applyNo" /> 

		<div class="cell center mt-50" >
			<h2>
				<span style="color: rgb(66,138,66)">${findApplyDto.memberId}</span> 님에게
				<span style="color: rgb(66,138,66)">완료 정보</span>를 알려주세요!
			</h2>
		</div>
	
	<div class="container w-500 pick-container p-30" style="margin-top: 50px; margin-bottom:80px;">
		
		<div class="cell">
			<h2>수거 중량</h2>
			<input name="pickWeight" class="tool input-tool w-100" placeholder="중량을 입력하세요." style="border-radius:10px">
			<div class="fail-feedback">숫자를 입력하세요</div>
		</div>

		<div class="cell">
			<h2>수거 금액</h2>
			<input name="pickPay" class="tool input-tool w-100" value="" style="border-radius:10px">
			<div class="fail-feedback">금액을 입력하세요</div>
		</div>
		
		<div class="cell">
			<h2>수거 이미지</h2>
			<input type="file" name="attach" class="image w-100">
		</div>
		
		<div class="cell flex-cell">
			<div class="cell">
				<button type="button" class="btn w-100"  style="border-radius: 10px;" onclick="proceedDetail(${pickNo});">
				신청정보 다시보기</button>
			</div>
			<div class="cell width-fill right">
				<button type="submit" class="btn w-75" style="border-radius: 10px;">등록하기</button>
			</div>
		</div>
	</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
