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
 <br><br>
     <div class="container center apply-container w-700 p-20 mt-50 mb-50" id="apply-completed">
        <div class="cell list-box">
        
                <div class="cell">
                <img class="dummy" src="${pageContext.request.contextPath}s/image/fail.png" style="width:400px; height:300px">
                </div>
            </div>
        </div>
        </div>
    
</body>

</html>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>