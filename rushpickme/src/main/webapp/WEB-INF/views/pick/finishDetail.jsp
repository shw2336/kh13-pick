<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

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

</style>

<script type="text/javascript">

	function finishList () {
		window.location.href = "finishList";
	}
	function deletePick () {
		if (confirm("정말 삭제하시겠습니까?")) {
			$("#form-type").attr("action", "deletePick").submit();
		}
	}

</script>

<div class="cell center" >
		<h1>
			<span style="color: rgb(66,138,66)">${pickNo}번</span> 수거 정보
			<img src="${pageContext.request.contextPath}/image/notebook.png" style="width:50px;" class="ps-10">
		</h1>
</div>

<div class="container pick-container w-600 px-50 pt-10 my-50">
	
	<input type="hidden" value="${applyNo}">
	<input type="hidden" value="${pickNo}">
	<br>
	
	<div class="cell">
		<h2>주소</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyPost}" readonly> <input
			class="detail-tool w-100" value="${findApplyDto.applyAddress1}" readonly> <input
			class=" detail-tool w-100" value="${findApplyDto.applyAddress2}" readonly>
	</div>

	<div class="cell mt-40">
		<h2>최종 중량</h2>
		<input class="detail-tool w-100" value="${findPickDto.pickWeight} kg" readonly>
	</div>

	<div class="cell mt-40">
		<h2>최종 금액</h2>
		<input class="detail-tool w-100" value="<fmt:formatNumber value="${findPickDto.pickPay}" pattern="#,##0"/> 원" readonly>
	</div>
	
	<div class="cell mt-40">
		<h2>수거 일시</h2>
		<input class="detail-tool w-100"  value="<fmt:formatDate value="${findPickDto.pickFinishDate}" pattern="MM월 dd일 (HH시 mm분)"/>" readonly>
	</div>

	<div class="cell mt-40">
		<h2>배출사진</h2>
		<div class="cell">
				<img src="${pageContext.request.contextPath}/image/apply?applyNo=${findApplyDto.applyNo}" class="image" width="100%">
		</div>
	</div>
	
	<div class="cell mt-40">
		<h2>수거사진</h2>
		<div class="cell">
				<img src="${pageContext.request.contextPath}/image/pick?pickNo=${pickNo}" class="image" width="100%">
		</div>
	</div>
	
	<form method="post" id="form-type">
		<input name="pickNo" type="hidden" value="${pickNo}"/>
		<div class="cell right mb-40">
			<button type="button" class="btn move" onclick="finishList();">
			<span class="btn-name">돌아가기</span></button>
			<span class="me-20"></span>
			
			<button class="btn move" onclick="deletePick();">
			<span class="btn-name">삭제하기</span></button>
		</div>
	</form>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
