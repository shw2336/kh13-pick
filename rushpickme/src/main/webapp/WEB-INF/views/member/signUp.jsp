<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
/* 버튼 호버 효과 */
.button-container button:hover {
    opacity: 0.8; /* 호버 효과 */
}


/* 수정된 스타일 끝 */
</style>

<body>
    <div class="container w-1200 center">
    <img src="/image/join.png">
        <div class="cell center">
        </div>
        <!-- 이미지 버튼으로 변경 -->
        <div class="button-container">
           <div class="btn" type="button" onclick="location.href='signUpGreen'">
                <img src="/image/il.png" alt="일반회원 이미지"> 
            </div>
            <div class="btn" type="button" onclick="location.href='signUpPick'">
                <img src="/image/su.png" alt="수거회원 이미지"> 
           </div>
        </div>
    </div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
