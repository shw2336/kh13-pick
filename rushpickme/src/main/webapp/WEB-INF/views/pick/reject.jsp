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
		}
	
		$(document).on("click", ".comment-btn", function() {
			$(".reject-comment").val("");
			$("#pickReject").val(""); // textarea값 초기화
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
				}
				var length = $(".selected-btn").length;
				$(".submit-btn").removeClass("success fail").addClass(
						length > 0 ? "success" : "fail");

			});
		
	});
	
	
</script>

	<form action="reject" method = "post" enctype="multipart/form-data" autocomplete="off" class="check-form">
	
	<div class="container w-300" style="margin-top: 50px; margin-bottom:80px;">
		<input type="hidden" value="${applyNo}" name="applyNo" />
		<input type="hidden" id="pickReject" name="pickReject" />
		<input type="hidden" value="${findApplyState}" name="applyState" class="applyState"/>

		<div class="cell center mb-30">
			<h2>거부 사유를 선택 해 주세요.</h2>
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
			<button type="button" class="btn reject-btn comment-btn w-100">봉투
				미사용</button>
		</div>
		<div class="cell center pb-10">
			<button type="button" class="btn reject-btn etc-btn w-100">
				기&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp타</button>
		</div>
		<div class="cell center">
			<textarea class="tool w-100 reject-comment"
				style="display: none; font-size: 13px; min-height: 100px; max-height: 100px; text-align: left;"
				placeholder="수거거부 사유를 입력 해 주세요 (100자 이내)">
                </textarea>
		</div>
		<br>
		
		<c:choose>
			<c:when test="${findApplyState eq '진행중'}">
				<div class="cell reject-btn mb-30 attach-file">
					<div class="cell left ps-10">
						<h3>현장 사진 등록하기</h3>
					</div>
					<div class="cell ps-10">
						<input type="file" name="attach" class="image w-100" >
					</div>
				</div>
			</c:when>
		</c:choose>

		<div class="cell center">
			<button type="submit" class="btn submit-btn w-100"
				style="border-radius: 10px;">등록하기</button>
			<div class="fail-feedback">사유를 선택하세요.</div>
		</div>
</div>
</form>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>