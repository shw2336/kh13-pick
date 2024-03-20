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
	
	</style>
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	</script>
<body>
    <div class="container apply-container w-650 mt-50 mb-50">
    <input type="hidden" value="신청완료" type="text" name="applyState" class="tool w-100">
       <div class="container w-500">
           <div class="cell center">
           
               <h1>리뷰</h1>
               
           </div>
           <div class="cell w-500 ">
               <h2> 별점 
                   <i class="fa-solid fa-truck"></i>
               </h2>
            </div>



           <div class="cell w-500">
               <h2>작성 내용</h2>
                <div class="text">
                    <textarea class="tool w-100" name="review"></textarea>
                </div>
           </div>
        </div>
    </div>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>