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
            width: 20%; 
            max-width: 100%; 
            margin-left: 44%;
        }
        /* Swiper 스타일 추가 */
        .swiper-container {
            width: 80%;
            margin: auto;
            position: relative; /* 부모 요소에 대해 상대적 위치 설정 */
        }
        .swiper-slide img {
            width: 100%;
        }
        /* 방향 버튼 스타일 */
        .swiper-button-prev,
        .swiper-button-next {
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            z-index: 10; /* 다른 요소 위에 표시 */
            cursor: pointer; /* 마우스 커서를 포인터로 변경 */
        }
        .swiper-button-prev {
            left: 10px; /* 왼쪽 여백 설정 */
        }
        .swiper-button-next {
            right: 10px; /* 오른쪽 여백 설정 */
        }
    </style>
</head>
<body>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container">
    <div class="slogan">
        <img src="/image/slogan1.png">
        <img src="/image/click.png" style="margin-top:-150px; width: 250px; height: auto; margin-left: 10px;"> <!-- click 이미지 크기 조정 -->
    </div>
    <div class="additional-images" style="margin-right: 70px; margin-top: -150px;"> <!-- 추가 이미지 상단 여백 조정 -->
         <a href="/point/charge"><img src="/image/shop.png"></a>
    </div>
    <img src="/image/how.png" style="width: 1200px; height: auto; margin-top:70px; margin-left:160px;">
    <!-- 슬라이더 컨테이너 추가 -->
    <div class="swiper-container">
        <!-- 슬라이드 항목을 감싸는 wrapper 추가 -->
        <div class="swiper-wrapper">
            <!-- 슬라이드 항목 추가 -->
            <div class="swiper-slide">
                <a href="/review/list"><img src="/image/review1.png"></a>
            </div>
            <div class="swiper-slide">
                <a href="/review/list"><img src="/image/review2.png"></a>
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
        var swiper = new Swiper('.swiper-container', {
            loop: true,
            effect: 'slide',
            autoplay: {
                delay: 4000,
            },
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
            },
        });
    });
</script>
</body>
</html>
