<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
</head>

<style>
        .apply-container {
            border-radius: 30px;
            border: 2px solid gainsboro;
           box-shadow: 0px 4px 4px 2px gainsboro;
            padding: 50px;

        }
        .success-container {
            border-radius: 30px;
            border: 5px solid rgb(255, 128, 128);
            box-shadow: 0px 4px 4px 2px rgb(255, 128, 128);
            padding: 50px;
        }
        
        

   </style>
   
   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

	<script type="text/javascript">
	
    	function detail(num) {
    	window.location.href = "applyDetail?applyNo=" + num;	
    	}
    	function finish(num) {
        	window.location.href = "finish?applyNo=" + num;	
    		console.log(num);
        	}
    	function rejectDetail(num) {
    		window.location.href = "rejectDetail?applyNo=" + num;
    	}
    	function stateDetail(num) {
    		window.location.href = "stateDetail?applyNo=" + num;
    	}

    	//${state}에 담겨있는 값에 따라 컨테이너박스에 디자인추가
    	//${state}가 신청완료, 진행중일 때는 '결제내역보기'버튼을 hide() 처리
    	$(function(){
    		if($(".apply-state").val() === "신청완료") { //수거 상태가 신청 완료일때
    			$(".apply-finish").removeClass("apply-container").addClass("success-container");//신청완료의 원래 컨테이너는 지우고 성공 컨테이너는 추가해
    			$(".btn-pick-finish").hide(); //결제 버튼pick-finish는 숨겨 
    			$(".apply-reject").hide(); //접수 거부 apply-reject 는 숨겨
    			$(".btn-rejectDetail").hide(); //거부 사유 버튼 btn-rejectDetail 숨겨
    			$(".btn-stateDetail").hide(); //거부 사유 버튼 btn-rejectDetail 보여줘
    			
    		}else if ($(".apply-state").val() === "진행중") {//수거 상태가 진행 중 일때
    			$(".apply-proceed").removeClass("apply-container").addClass("success-container");//진행중의 원래 컨테이너는 지우고 성공 컨테이너는 추가해
    			$(".btn-pick-finish").hide();//결제 버튼pick-finish는 숨겨 
    			$(".apply-reject").hide();//접수 거부 apply-reject 는 숨겨
    			$(".btn-rejectDetail").hide(); //거부 사유 버튼 btn-rejectDetail 숨겨
    			$(".btn-stateDetail").show(); //거부 사유 버튼 btn-rejectDetail 보여줘
    		}else if ($(".apply-state").val() === "수거완료") {//수거 상태가 수거 완료일때
    			$(".pick-finish").removeClass("apply-container").addClass("success-container");//진행중의 원래 컨테이너는 지우고 성공 컨테이너는 추가해
    			$(".apply-reject").hide();//접수 거부 apply-reject 는 숨겨
    			$(".btn-pick-finish").show();//결제 버튼pick-finish는 보여줘
    			$(".btn-rejectDetail").hide(); //거부 사유 버튼 btn-rejectDetail 숨겨
    			$(".btn-stateDetail").hide(); //거부 사유 버튼 btn-rejectDetail 보여줘
    			
    		}
    		else if($(".apply-state").val() === "접수거부") {
    			$(".apply-proceed").removeClass("apply-container").addClass("success-container");
    			$(".apply-reject").show();//접수 거부 apply-reject 는 보여줘
    			$(".btn-pick-finish").hide();//결제 버튼pick-finish는 숨겨 
    			$(".btn-rejectDetail").show(); //거부 사유 버튼 btn-rejectDetail 보여줘
    			$(".btn-stateDetail").hide(); //거부 사유 버튼 btn-rejectDetail 보여줘
    		}
    		
    	});
    	
	</script>
	
<body>
   <input type="hidden" value="${applyNo}" name="applyNo" />
   <input type="hidden" value="${state}" class = "apply-state"/><!-- 수거 상태 받은거를 히든으로 숨겨놓음  --> 
   <!-- 
    <input type="hidden" value="${applyState}"name="applyState"/>
    <input type="hidden" value ="${pickState}" name="pickState"/>
    <input type="hidden" value="${pickReject}" name="pickReject"/> --> 
    
     <div class="container apply-finish apply-container w-750 p-20 " id="apply-completed">
        
        <div class="cell list-box">
            <div class="cell center">
                <h2 style="text-align: center;">신청  완료</h2>
                <input type="hidden" value="${applyDto.applyState}" name="confirm">
                <div class="right">
                	<button type="submit" class="btn submit"onclick="detail('${applyNo}');" >
                	<!--<input type="hidden" value="${applyDto.applyState}" name="confirm">  -->
                    신청정보 상세내역 
                </button>
        		</div>
                <hr>
          </div>
            <div class="cell center">
                <img class="dummy" src="${pageContext.request.contextPath}/image/success.PNG" style="width:380px; height:280px">
            </div>
        </div>
        
    </div>
	
	<div class="cell center">
        <i class="fa-solid fa-chevron-down" style="font-size: 80px;color:rgb(66,138,66)"></i><br>
    </div>

    <div class="container apply-proceed apply-container w-750 p-20 mt-50">
        <div class="cell list-box">
            <div class="cell">
                <h2 style="text-align: center;">진행 중</h2>
                	<input type="hidden" value="${applyDto.applyState}" name="proceed">
                	<div class="right">
                	<button type="submit" class="btn submit btn-rejectDetail"onclick="rejectDetail('${applyNo}');" >
                    거부사유 보기 
                </button>
        		</div>
        			<div class="right">
                	<button type="submit" class="btn submit btn-stateDetail"onclick="stateDetail('${applyNo}');" >
                    수거진행 사항
                </button>
        		</div>
                <hr>
            </div>
            <%--안녕 --%>
            <div class="cell center">
                <img class="dummy" src="${pageContext.request.contextPath}/image/picking.png" style="width:400px; height:300px">
            </div>
            <div class="cell apply-reject">
            	<h2 style="text-align: center; color:rgb(255, 128, 128);">
            	접수거부 되었습니다. 재신청부탁드립니다.
            	<input type="hidden" value="접수거부" name="reject"/> </h2>
            </div>
        </div>
        </div>
        
        <div class="cell center">
        <i class="fa-solid fa-chevron-down" style="font-size: 80px;color:rgb(66,138,66)"></i><br>
       </div>
    
     <div class="container pick-finish apply-container w-750 p-20 mt-50">
        <div class="cell list-box">
            <div class="cell center">
                <h2 style="text-align: center;">수거  완료</h2>
                	<input type="hidden" value="${applyDto.applyState}" name="finish">
                <div class="right">
            <form action="finish" method="post" autocomplete="off" enctype="multipart/form-data">
                	
                	<input type="hidden" value="수거 완료" name="pickPay"/>
                	<button type="button" class="btn submit btn-pick-finish" onclick="finish('${applyNo}');" >
                    수거완료 상세내역  
                </button>
                </form>
        </div>
            </div>
                <hr>
            <div class="cell center">
                <img class="dummy" src="${pageContext.request.contextPath}/image/Picker2.png" style="width:400px; height:300px">
            </div>
        </div>
        </div>
        

</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>