<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
 <script type="text/javascript">
	 function review(num) {
 	window.location.href = "/review/write?askNo=" + num;	
 	}
 	function applyList(num) {
     	window.location.href = "applyList?memebrId=" + num;	
 		console.log(num);
     	}
 	
 	/* function locationCharge() {
        window.alert("결제 되었습니다!");
        if(choice){
            window.open("http://localhost:8080/apply/finish?","naver","width500,height=500");
        }
    }

    function locationCharge() {
        // var choice =window.confirm("정말 이동할거에요?");    
        var choice =confirm("잔액이 부족합니다! 포인트를 충전하시겠습니까?");  
          // console.log(button);
        if(choice){ //확인을 누르면 이동해라
            window.open("http://localhost:8080/point/charge","charge","width500,height=500");
        }
    } */
    
    
    /* function checkBalance(memberId) {
        // memberId를 사용하여 잔액을 확인하는 AJAX 요청 등을 수행하고,
        // 해당 결과에 따라 결제할지 포인트를 충전할지를 결정합니다.
        
        // 임시로 잔액을 -100으로 가정합니다.
        var balance = -100; // 이 값은 AJAX 요청을 통해 실제 잔액을 확인해야 합니다.
        
        if (balance < 0) {
            // 잔액이 마이너스인 경우 포인트를 충전할 수 있도록 locationCharge 함수 실행
            locationCharge();
        } else {
            // 잔액이 마이너스가 아닌 경우 결제 완료 알림을 표시하고 결제 완료 페이지로 이동
            pay();
        }
    }

    function pay() {
        window.alert("결제 되었습니다!");
        // 결제 완료 페이지로 이동
        window.open("http://localhost:8080/apply/finish?", "_blank");
    }

    function locationCharge() {
        var choice = confirm("잔액이 부족합니다! 포인트를 충전하시겠습니까?");  
        if (choice) { 
            // 포인트 충전 페이지로 이동
            window.open("http://localhost:8080/point/charge", "_blank");
        }
    } */

 	
    </script>
</head>
<body>
    <div class="cell center mt-30" >
		<h1>
		<span style="color: rgb(66,138,66)">${findDto.memberId}</span> 님의 수거완료 상세 내역
		</h1>
	</div>

	<div class="container apply-container w-600 px-50 pt-10 my-50">

	<br>
    <div class="cell">

		<h2>신청번호</h2>
		<input class="detail-tool w-100" value="${findDto.applyNo}" /> 
			 
			
	</div>
	<div class="cell">  

		<h2>주소</h2>
		<input class="detail-tool w-100" value="${findDto.applyPost}" > <input
			class="detail-tool w-100" value="${findDto.applyAddress1}" > <input
			class=" detail-tool w-100" value="${findDto.applyAddress2}" >
	</div>
    <br>
    <div class="cell">
        <h2>수거 완료시각</h2>
		<input class="detail-tool w-100" value="${pickDto.pickFinishDate}" readonly>
	</div>
	<br>
    <div class="cell">
        <h2>증량</h2>
        <input class="detail-tool w-100" value="${pickDto.pickWeight}" readonly>
    </div>
    <br>
    <br>
    <div class="cell">
        <h2>보유 포인트</h2>
        <input class="detail-tool w-100" value="${greenDto.memberGreenPoint}" readonly>
    </div>
    <br>
    <div class="cell">
        <h2>수거 금액</h2>
        <input class="detail-tool w-100" value="${pickDto.pickPay}" readonly>
    </div>
    <br>
     <div class="cell">
        <h2>잔액</h2>
        <input class="detail-tool w-100" value="${resultPoint}" readonly>
    </div>
    <br>
	
	<div class="cell right">
		<div class="cell">
    		<button class="btn positive w-100" onclick="checkBalance('${findDto.memberId}');">결제하기</button>
		</div>
		
		<br>
		<button class="btn positive"  onclick="review('${applyDto.applyNo}');">리뷰쓰기</button>
		<button class="btn positive"  onclick="applyList('${applyDto.memberId}');">신청 리스트</button>
	</div>
	<br>
</div>

</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>