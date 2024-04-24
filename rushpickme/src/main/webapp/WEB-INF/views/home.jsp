<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>RUSHPICKME!</title>
    <!-- jQuery CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Swiper CDN -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <style>
        .container {
            display: flex;
            align-items: flex-start; 
            justify-content: flex-start;
            flex-direction: column;
        }
        .slogan {
            width: 50%; 
            margin-left: 20%; 
            display: flex; 
            align-items: center; 
             box-shadow: 0 4px 6px rgba(1, 1, 1, 0.15);
        }
        .slogan img {
            max-width: 100%; 
        }
        .additional-images {
            margin-top: -20px; 
            margin-left: auto; 
            align-self: flex-start; 
        }
        .additional-images img {
            width: 30%; 
            max-width: 100%; 
            margin-left: 18%;
        }
        /* Swiper 스타일 추가 */
        .swiper-container {
            width: 75%;
            position: relative; 
            overflow: hidden;
        }
        .swiper-slide img {
            max-width: 100%; 
            max-height: 100%; 
        }
            .swiper-container {
                margin-left: auto;
                margin-right: auto;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
    <div class="slogan">
        <img src="${pageContext.request.contextPath}/image/slogan.png">
        <img src="${pageContext.request.contextPath}/image/click.png" style="margin-top:-150px; width: 250px; height: auto; margin-left: 10px;"> <!-- click 이미지 크기 조정 -->
    </div>
    <div class="additional-images" style="margin-right: 70px; margin-top: -200px;"> <!-- 추가 이미지 상단 여백 조정 -->
         <a href="/point/charge"><img src="${pageContext.request.contextPath}/image/shop.png"></a>
    </div>
    <img src="${pageContext.request.contextPath}/image/how.png" style="width: 1200px; height: auto; margin-top:70px; margin-left:365px;">
    <img src="${pageContext.request.contextPath}/image/how2.png" style="width: 1200px; height: auto; margin-top:70px; margin-left:365px;">
    <!-- 슬라이더 컨테이너 추가 -->
    <div class="swiper-container">
        <!-- 슬라이드 항목을 감싸는 wrapper 추가 -->
        <div class="swiper-wrapper">
            <!-- 슬라이드 항목 추가 -->
            <div class="swiper-slide">
                <a href="/review/list"><img src="${pageContext.request.contextPath}/image/review1.png"></a>
            </div>
            <div class="swiper-slide">
                <a href="/review/list"><img src="${pageContext.request.contextPath}/image/review2.png"></a>
            </div>
        </div>
        <!-- Swiper 페이징 및 네비게이션 버튼 -->
        <div class="swiper-pagination"></div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script>
$(function(){
    // Swiper 초기화
    var options = {
        loop: true,
        effect: 'slide',
        autoplay: {
            delay: 4000,
        },
        pagination: {
            el: '.swiper-pagination',
            clickable: true,
            type: "bullets",
        },
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
            hideOnClick:true,
        },
    };
    $(".swiper-container").each(function(){
        var swiper = new Swiper(this, options);
    });
});
</script>
</body>
</html>
