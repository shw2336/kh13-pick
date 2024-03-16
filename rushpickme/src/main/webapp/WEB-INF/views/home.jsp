<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Page</title>
    <!-- jQuery CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Swiper CDN -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
    <style>
        .container {
            display: flex;
            align-items: flex-start; /* 상단 정렬 */
            justify-content: flex-start;
            flex-direction: column;
        }
        .slogan {
            width: 50%; /* 조정 가능한 너비 */
            margin-left: 5%; /* 왼쪽 여백 조정 */
            display: flex; /* Flexbox 사용 */
            align-items: center; /* 가운데 정렬 */
        }
        .slogan img {
            max-width: 100%; /* 이미지의 최대 너비 설정 */
        }
        .additional-images {
            margin-top: -20px; /* 이미지들 간 간격 조절을 위한 상단 여백 */
            margin-left: auto; /* 왼쪽 여백을 auto로 설정하여 오른쪽 정렬 */
            align-self: flex-start; /* 아래쪽 정렬 */
        }
        .additional-images img {
            width: 20%; /* 추가 이미지의 너비 설정 */
            max-width: 100%; /* 이미지의 최대 너비 설정 */
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
    <img src="/image/how.png" style="width: 1300px; height: auto; margin-top:70px;">
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
                <a href="/review/list"><img src="/image/review1.png"></a>
            </div>
            <div class="swiper-slide">
                <a href="/review/list"><img src="/image/review2.png"></a>
            </div>
        </div>
        <div class="swiper-pagination"></div>
        <div class="swiper-button-prev"></div>
        <div class="swiper-button-next"></div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>

<!-- Swiper JS -->
<script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
<script type="text/javascript">
    $(function(){
        var options = {
            loop: true,
            effect: "slide",
            autoplay: tr
