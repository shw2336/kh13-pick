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
       
    </script>
</head>
<body>
    <div class="cell center mt-30" >
		<h1>
		<span style="color: rgb(66,138,66)">${applyDto.memberId}</span> 님의 결제 내역
		</h1>
	</div>

	<div class="container apply-container w-600 px-50 pt-10 my-50">

	<br>
    <div class="cell">

		<h2>신청번호</h2>
		<input class="detail-tool w-100" value="${applyDto.applyNo}" /> 
			 
			
	</div>
	<div class="cell">

		<h2>주소</h2>
		<input class="detail-tool w-100" value="${applyDto.applyPost}" > <input
			class="detail-tool w-100" value="${applyDto.applyAddress1}" > <input
			class=" detail-tool w-100" value="${applyDto.applyAddress2}" >
	</div>
    <br>
    <div class="cell">
        <h2>증량</h2>
        <input class="detail-tool w-100" value="${pickDto.pickWeight}" readonly>
    </div>
    <br>
    <br>
    <div class="cell">
        <h2>봉투개수</h2>
        <input class="detail-tool w-100" value="${applyDto.applyVinyl}" readonly>
    </div>
    <br>
    <div class="cell">
        <h2>수거 완료시각</h2>
		<input class="detail-tool w-100" value="${pickDto.pickFinishDate}" readonly>
	</div>
	<br>
    <div class="cell">
        <h2>금액</h2>
        <input class="detail-tool w-100" value="${pickDto.pickPay}" readonly>
    </div>
    <br>
	
	<div class="cell right">
	<form action="cancel" method="post" >
		<button class="btn positive" >결제하기</button>
		</form>
	</div>
	<br>
<!-- 커밋 연습 -->
</div>

</body>
</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>