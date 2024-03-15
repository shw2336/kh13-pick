<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>My Page</title>
    <!-- jQuery CDN -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <!-- Swiper CDN -->
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css">
</head>
<body>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="cell center container w-100">
    <img src="/image/slogan.png">
    <img src="/image/how.png">
    <div class="swiper">
        <div class="swiper-wrapper">
            <div class="swiper-slide">
            <a href=/review/list><img src="/image/review1.png"></a></div>
            <div class="swiper-slide"><a href=/review/list><img src="/image/review2.png"></a></div>
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
            autoplay: true,
            pagination: {
                el: '.swiper-pagination',
                clickable: true,
                type: "bullets",
            },
            navigation: {
                nextEl: '.swiper-button-next',
                prevEl: '.swiper-button-prev',
                hideOnClick: true,
            },
        };
        $(".swiper").each(function(){
            var swiper = new Swiper(this, options);
        });
    });
</script>

</body>
</html>
