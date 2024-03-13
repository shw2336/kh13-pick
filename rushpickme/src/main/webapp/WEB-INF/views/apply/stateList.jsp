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
    <div class="container apply-container w-700 p-20 mt-25 mb-25">
        <div class="cell list-box">
            <div class="cell">
                <h2 style="text-align: center;">신청완료</h2>
                <hr>
            </div>
            <div class="cell center">
                <img class="dummy" src="/image/pickreject.PNG" style="width:200px; height:200px">
            </div>
        </div>
    </div>

    <div class="cell center">
        <i class="fa-solid fa-chevron-down" style="font-size: 80px;color:rgb(66,138,66)"></i><br>
    </div>

    <div class="container apply-container w-750 p-20 mt-25 mb-25">
        <div class="cell list-box">
            <div class="cell">
                <h2 style="text-align: center;">진행중</h2>
                <hr>
            </div>
            <div class="cell center">
                <img class="dummy" src="/image/picking.png" style="width:200px; height:200px">
            </div>
        </div>

    </div>
    <div class="cell center">
        <i class="fa-solid fa-chevron-down" style="font-size: 80px;color:rgb(66,138,66)"></i><br>
    </div>

    <div class="container apply-container w-750 p-20 mt-25 mb-50">
        <div class="cell list-box">
            <div class="cell">
                <h2 style="text-align: center;">수거완료</h2>
                <hr>
            </div>
            <div class="cell center">
                <img class="dummy" src="/image/Picker.png" style="width:200px; height:200px">
            </div>
        </div>
    </div>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>