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

   </style>
<body>
   <input type="hidden" value="${applyNo}" name="applyNo" /> 
   <!-- 
    <input type="hidden" value="${applyState}"name="applyState"/>
    <input type="hidden" value ="${pickState}" name="pickState"/>
    <input type="hidden" value="${pickReject}" name="pickReject"/> --> 
    
     <div class="container apply-container w-750 p-20 mt-50" id="apply-completed">
        
        <div class="cell list-box">
            <div class="cell center">
                <h2 style="text-align: center;">신청완료</h2>
                <div class="right">
            <form action="requestCancel" method="post">
                	<button type="submit" class="btn negative">
                	<input type="hidden" value="y" name="applyCancel">
                    신청취소하기 
                </button>
            </form>
        </div>

                <hr>
            </div>
            <div class="cell center">
                <img class="dummy" src="/image/success.PNG" style="width:400px; height:300px">
            </div>
        </div>
    </div>
    
	
	<div class="cell center">
        <i class="fa-solid fa-chevron-down" style="font-size: 80px;color:rgb(66,138,66)"></i><br>
    </div>

    <div class="container apply-container w-750 p-20 mt-50">
        <div class="cell list-box">
            <div class="cell">
                <h2 style="text-align: center;">진행중</h2>
                <hr>
            </div>
            <div class="cell center">
                <img class="dummy" src="/image//picking.png" style="width:400px; height:300px">
            </div>
        </div>
        </div>
        
        <div class="cell center">
        <i class="fa-solid fa-chevron-down" style="font-size: 80px;color:rgb(66,138,66)"></i><br>
       </div>
    
        <div class="container apply-container w-750 p-20  p-20 mt-50">
        <div class="cell list-box">
            <div class="cell">
                <h2 style="text-align: center;">수거완료</h2>
                <hr>
            </div>
            <div class="cell center">
                <img class="dummy" src="/image/Picker.png" style="width:350px; height:250px">
            </div>
        </div>
    </div>






</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>