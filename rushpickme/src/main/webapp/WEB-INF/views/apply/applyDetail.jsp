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
      
      .apply-container {
          border-radius: 10px;
          border: 1px solid gainsboro;
          box-shadow: 0px 4px 4px 2px gainsboro;
      }
      
	</style>
   	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	function cancel(num) {
    	window.location.href = "cancel?applyNo=" + num;	
		console.log(num);
    	}
	$(function(){
		if($(".apply-state").val() === "신청완료") { //수거 상태가 신청 완료일때
			$(".btn-cancel").show(); 
		}
		else if ($(".apply-state").val() === "진행중") {//수거 상태가 진행 중 일때
			$(".btn-cancel").hide();
		}
		else if ($(".apply-state").val() === "수거완료") {//수거 상태가 수거 완료일때
			$(".btn-cancel").hide();
		}
		else if($(".apply-state").val() === "접수거부") {
			$(".btn-cancel").hide();
		}
		
	});
	
    	
	</script>
<body>
	<input type="hidden" value="${state}" class = "apply-state"/>
    <div class="cell center mt-30" >
		<h1>
		<span style="color: rgb(66,138,66)">${applyDto.memberId}</span> 님의 신청 정보
		</h1>
	</div>

	<div class="container apply-state apply-container w-600 px-50 pt-10 my-50">

	<br>
	<div class="cell">

		<h2>주소</h2>
		<input class="detail-tool w-100" value="${applyDetail.applyPost}" > <input
			class="detail-tool w-100" value="${applyDetail.applyAddress1}" > <input
			class=" detail-tool w-100" value="${applyDetail.applyAddress2}" >
	</div>
	<div class="cell">
        <h2>예상무게</h2>
		<input class="detail-tool w-100" value="${applyDetail.applyWeight}" readonly>
	</div>
	<br>
    <br>
    <div class="cell">
        <h2>봉투개수</h2>
        <input class="detail-tool w-100" value="${applyDetail.applyVinyl}" readonly>
    </div>
    <br>
	<div class="cell">
		<h2>수거 희망 날짜</h2>
		<input class="detail-tool w-100" value="${applyDetail.applyHopeDate}" readonly>
	</div>
	<br>
	<div class="cell">
		<h2>남기신 말</h2>
		<input class="detail-tool w-100" value="${applyDetail.applySay}" readonly>
	</div>
    <br>
    <div class="cell">
		<h2>출입 방법</h2>
		<input class="detail-tool w-100" value="${applyDetail.applyWay}" readonly>
	</div>
	<br>
	<br>
	<div class="cell apply-state right">
	 <form action="cancel" method="post" >
	 	<input type="hidden" name="applyNo" value="${applyDto.applyNo}" />
	 	 <input type="hidden" value="${applyDto.applyState}" name="apply-cancel">
			<button  type="submit" class="btn submit btn-cancel" onclick="cancel('${applyDto.applyNo}')">
				취소하기
            </button>
	</form>
	</div>

</div>

</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>