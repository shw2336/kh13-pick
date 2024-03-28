<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
   	</head>

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
	
	</script>
	
	<body>
	<div class="cell center" >
		<h1>
			<span style="color: rgb(66,138,66)">${applyDto.applyNo}번</span> 수거 정보
			<%-- <span style="color:red; font-size:18px;">(거부됨)</span>
		</h1>
			<span style="font-weight:bold;">다시 진행하려면 아래의 <span style="color: rgb(66,138,66)">거부취소</span> 버튼을 눌러주세요.</span>
</div>

<div class="container pick-container w-600 px-50 pt-10 my-50">
	
	<div class="cell">
		<h2>신청번호 <span style="color: rgb(66,138,66)">${findPickDto.applyNo}</span> 번</h2>
	</div>

	<div class="cell mt-40">
		<h2>신청자</h2>
		<input class="detail-tool w-100" value="${findApplyDto.memberId}" readonly>
	</div>
	
	<div class="cell mt-40">
		<h2>신청 일시</h2>
		<input class="detail-tool w-100" value="<fmt:formatDate value="${findApplyDto.applyDate}" pattern="MM월 dd일 (HH시 mm분)"/>" readonly>
	</div>

	<div class="cell mt-40">
		<h2>거부 사유</h2>
		<input class="detail-tool w-100" value="${findPickDto.pickReject}" readonly>
	</div>

	<div class="cell mt-40">
		<h2>배출사진</h2>
		<div class="cell">
				<img src="image/apply?applyNo=${findPickDto.applyNo}" class="image" width="100%">
		</div>
	</div>
	
	<div class="cell my-40">
		<h2>수거사진</h2>
		<div class="cell">
				<img src="image/pick?pickNo=${findPickDto.pickNo}" class="image" width="100%">
		</div>
	</div>

	<form method="post" id="form-type">
		<!-- 	/rejectCancel controller에 넘겨줄 번호들 -->
		<input type="hidden" name="pickNo" value="${findPickDto.pickNo}" />
		<input type="hidden" name="applyNo" value="${findPickDto.applyNo}"/>
		<input type="hidden" name="pickSchedule" value="${findPickDto.pickSchedule}"/>
		
		<div class="cell right mb-40">
			<button type="button" class="btn move" onclick="rejectList();">
			<span class="btn-name">돌아가기</span></button>
			<span class="px-10"></span>
			
			<button class="btn move delete" onclick="rejectCancel();">
			<span class="btn-name">거부취소</span></button>
			<span class="px-10"></span>
			
			<button class="btn move delete" onclick="deletePickNo();">
			<span class="btn-name">삭제하기</span></button>
		</div>
	</form> --%>

</div>
	

</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>