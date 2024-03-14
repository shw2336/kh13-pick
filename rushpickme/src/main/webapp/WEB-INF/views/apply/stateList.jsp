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
   <div class="container apply-container w-750 p-20 mt-50" >
   <input type="hidden" value="${applyNo}" name="applyNo" /> 
   <!-- 
    <input type="hidden" value="${applyState}"name="applyState"/>
    <input type="hidden" value ="${pickState}" name="pickState"/>
    <input type="hidden" value="${pickReject}" name="pickReject"/> --> 
    
    
    
        <div class="cell list-box">
    <div class="cell">
        <input type="hidden" id="applyState" name="applyState">
        <h2 style="text-align: center;">수거 현황 리스트</h2>
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
</div>

</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>