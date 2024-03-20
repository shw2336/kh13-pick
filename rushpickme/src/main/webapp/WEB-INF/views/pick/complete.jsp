<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>    

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
        
		$("#uploadFile").change(function(event){
			
			if ($("#uploadFile").val().length == 0) {
				$("#imgArea").html("");
			}else {
				var fileType = $("#uploadFile").val().split(".");
				var regex = /^(jpeg|jpg|png|gif|bmp)$/;
				if(!regex.test(fileType[1])){
					$("#uploadFile").val("");
					$("#imgArea").html("");
					return alert("이미지 파일만 등록 가능합니다.");
				}
				$("#imgArea").html("");
				var file = event.target.files;

				var image = new Image();
				var imageTempUrl = window.URL.createObjectURL(file[0]);

				image.src = imageTempUrl;
				image.style.width = "280px";

				$("#imgArea").append(image);
			}
		});
		
		//수거완료시 후기작성 메일전송
        $(".check-form").submit(function(){
 		   $(this).find("[name]").blur();
		    if (!state.isOk()) {
		        // 입력 값이 유효하지 않으면 폼 제출을 중단하고 함수를 종료합니다.
		        event.preventDefault();
		        return false;
		    }else {
		    	 //이메일 불러오기
	            var inputEmail = $("[name=memberEmail]").val();
	            if (inputEmail.length == 0) return;
	            $.ajax({
	                url: "http://localhost:8080/rest/member/sendFinishMail",
	                method: "post",
	                data: {memberEmail : inputEmail},
	                success: function(response) {
	                },
	                error:function(){
	                    alert("!시스템 오류! 잠시 후 이용 해 주세요.");
	                }
	            });
		    }
        });
    });
    
    
</script>
    
<form action="complete" method="post" enctype="multipart/form-data" autocomplete="off" class="check-form">

	<input type="hidden" value="${applyNo}" name="applyNo" /> 
	<input type="hidden" value="${memberEmail}" name="memberEmail" />

		<div class="cell center mt-50" >
			<h1>
<%-- 				<span style="color: rgb(66,138,66)">${findApplyDto.memberId}</span> 님에게 --%>
				<span style="color: rgb(66,138,66)">완료 정보</span>를 알려주세요!
			</h1>
		</div>
	
	<div class="container w-500 pick-container p-30" style="margin-top: 50px; margin-bottom:80px;">
		
		<div class="cell mb-40">
			<h2>수거 중량</h2>
			<input name="pickWeight" class="tool input-tool w-100" placeholder="중량을 입력하세요." style="border-radius:10px">
			<div class="fail-feedback">숫자를 입력하세요</div>
		</div>

		<div class="cell mb-40">
			<h2>수거 금액</h2>
			<input name="pickPay" class="tool input-tool w-100" value="" style="border-radius:10px">
			<div class="fail-feedback">금액을 입력하세요</div>
		</div>
		
		<div class="cell mb-40">
			<h2>수거 이미지</h2>
			<input type="file" name="attach"id="uploadFile" class="image w-100">
			<div id="imgArea"></div>
		</div>
		
		<div class="cell flex-cell">
			<div class="cell">
				<button type="button" class="btn move w-100"  style="border-radius: 10px;" onclick="proceedDetail(${pickNo});">
				신청정보 다시보기</button>
			</div>
			<div class="cell width-fill right">
				<button type="submit" class="btn move btn-send-finish w-75" style="border-radius: 10px;">
				<i></i><span>등록하기</span></button>
			</div>
		</div>
	</div>

</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
