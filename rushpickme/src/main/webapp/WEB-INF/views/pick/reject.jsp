<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.reject-btn, .submit-btn {
	border-radius: 10px !important;
	background-color: white;
	border: 1px solid gainsboro;
	box-shadow: 0px 4px 4px 2px gainsboro;
	font-weight: bold;
}
.submit-btn:hover {
	background-color: #ff8080; 
	color:white;
	border-radius: 10px;
	font-weight: bold;
}
.sub-text {
	color: gray;
	font-size: 15px;
}
.selected-btn {
	background-color: rgb(114,188,114);
}
.btn.success {
	border-color: rgb(114,188,114) !important;
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
		$(".reject-comment").val("");

		if ($(".applyState").val() === "진행중") {
			$(".attach-file").show();
		}else if ($(".applyState").val() === "신청완료") {
			$(".attach-file").hide();
		}
	
		$(document).on("click", ".comment-btn", function() {
			$(".reject-comment").val("");
			$("#pickReject").val(""); // textarea값 초기화
			$(".submit-btn").removeClass("success fail");
			$(this).addClass("selected-btn");
			$(".reject-btn").not(this).removeClass("selected-btn");
			$(".reject-comment").hide();
			$("#pickReject").val($(this).text());
		});
		$(".etc-btn").click(function() {
			$(this).addClass("selected-btn");
			$(".reject-btn").not(this).removeClass("selected-btn");
			$("#pickReject").val("");
			$(".reject-comment").show();
		});

		$(".check-form").submit(
			function() {
				if ($(".reject-comment").val().trim().length > 0) {
					$("#pickReject").val($(".reject-comment").val());
				}else  {
					if ($("#pickReject").val().trim().length == 0) {
						alert("기타 사유를 입력하세요.");
						return false;
					}
				}
				var length = $(".selected-btn").length;
				$(".submit-btn").removeClass("success fail").addClass(
						length > 0 ? "success" : "fail");
				return length > 0 ;
			});
		
	});
	
	//이미지 미리보기 (자바스크립트에서 사용할 수 있는 Web API : 브라우저에서 공통 지원/ 자바스크립트 내장 함수)
	$(function(){
		$("#uploadFile").change(function(event){
			//파일 선택한게 없다면 (취소버튼 눌렀을 때)
			if ($("#uploadFile").val().length == 0) {
				$("#imgArea").html("");
			}else { //파일 선택한게 있다면
				var fileType = $("#uploadFile").val().split(".");	//확장자 체크 :	 .을 기준으로 나누기
				var regex = /^(jpeg|jpg|png|gif|bmp)$/;	//이미지파일 확장자 정규표현식 검사
				if(!regex.test(fileType[1])){	// .뒤에붙은 확장자가 이미지가 아닌경우
					$("#uploadFile").val("");	//input 파일값 초기화
					$("#imgArea").html("");	//이미지 미리보기 화면 초기화
					return alert("이미지 파일만 등록 가능합니다."); 
				}
				$("#imgArea").html("");	//이미지파일이라면, 일단 이미지 미리보기 화면 초기화 (밑에 계속 추가되는거 방지)
				var file = event.target.files;	//파일 입력 요소에서 선택한 파일을 가져와서 변수 file에 저장

				var image = new Image();	//이미지 객체 생성 (이미지 파일을 로드하고 화면에 표시)
				var imageTempUrl = window.URL.createObjectURL(file[0]); //임시 이미지 URL생성 (현재 선택한파일)

				image.src = imageTempUrl; //이미지 src속성에 임시 URL 할당
				image.style.width = "280px";

				$("#imgArea").append(image); //미리보기 구역에 붙이기 
			}
		});
	});
	
</script>

	<form action="reject" method = "post" enctype="multipart/form-data" autocomplete="off" class="check-form">
	
	<div class="container w-300" style="margin-bottom:80px;">
		<input type="hidden" value="${applyNo}" name="applyNo" />
		<input type="hidden" id="pickReject" name="pickReject" />
		<input type="hidden" value="${findApplyState}" name="applyState" class="applyState"/>

		<div class="cell center mb-30">
			<h2><span style="color: rgb(255, 128, 128)">거부 </span>사유를 선택 해 주세요.</h2>
		</div>

		<div class="cell center pb-10">
			<button type="button" class="btn reject-btn comment-btn w-100">
				대형폐기물 포함<span class="sub-text"> (유모차, 캐리어 등)</span>
			</button>
		</div>

		<div class="cell center pb-10">
			<button type="button" class="btn reject-btn comment-btn w-100">
				공업용품 포함<span class="sub-text"> (시멘트, 페인트 등)</span>
			</button>
		</div>

		<div class="cell center pb-10">
			<button type="button" class="btn reject-btn comment-btn w-100">봉투 미사용</button>
		</div>
		<div class="cell center pb-10">
			<button type="button" class="btn reject-btn etc-btn w-100">
				기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;타</button>
		</div>
		<div class="cell center">
			<textarea class="tool w-100 reject-comment"
				style="display: none; font-size: 13px; min-height: 100px; max-height: 100px; text-align: left;"
				placeholder="수거거부 사유를 입력 해 주세요 (100자 이내)">
                </textarea>
		</div>
		<br>
		
		<div class="cell reject-btn mb-30 attach-file">
			<div class="cell left ps-10">
				<h3>현장 사진 등록하기</h3>
			</div>
			<div class="cell ps-10">
				<input type="file" name="attach" id="uploadFile" class="image w-100"  accept="image/gif, image/jpeg, image/png">
				<div id="imgArea" class="w-100"></div>
			</div>
		</div>

		<div class="cell center">
			<button type="submit" class="btn submit-btn w-100"
				style="border-radius: 10px;">등록하기</button>
			<div class="fail-feedback pt-20">사유를 선택하세요.</div>
		</div>
</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>