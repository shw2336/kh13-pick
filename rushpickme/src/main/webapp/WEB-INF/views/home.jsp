<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 템플릿 페이지를 불러오는 코드 --%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .menu {
        text-align: center;
        margin-top: 10px; /* 타이틀과 메뉴 사이 간격 조절을 위한 추가 */
    }

    .slogan-container {
        display: flex;
        align-items: flex-start;
        justify-content: left;
        position: relative;
        flex-direction: column; /* 컬럼 방향으로 정렬 */
    }

    .slogan-img {
        width: 1300px;
        height: 800px;
    }

    .shop-img {
        display: flex;
        width: 250px;
        height: 250px;
        position: absolute; /* shop-img를 절대 위치로 변경 */
        top: 500px; /* 원하는 위치로 조절 */
        left: 1340px; /* 원하는 위치로 조절 */
    }

    .click-img {
        display: flex;
        position: absolute;
        top: 180px; /* 원하는 위치로 조절 */
        right: 270px;
        width: 300px;
        height: 300px;
    }

.how-img {
    width: 1100px;
    height: 550px;
    margin: auto; /* 수평 가운데 정렬을 위해 추가 */
}

.review-img {
    width: 1300px; /* 너비를 설정하세요 */
    height: 700px; /* 높이를 설정하세요 */
    top: calc(100% + 20px); /* 풋터 위에 위치하도록 설정 */
    left: 50%; /* 가운데 정렬을 위해 부모 요소의 가로 중앙에 위치하도록 설정 */
    transform: translateX(25%); /* 가운데 정렬을 위해 X축으로 -50% 이동 */
}
    }
</style>

<div class="section">
    <div class="article slogan-container">
        <img src="/image/slogan.png" class="slogan-img">
        <img src="/image/shop.png" class="shop-img">
        <img src="/image/click.png" class="click-img">
        <img src="/image/how.png" class="how-img">
	<img src="/image/review.png" class="review-img"></div>
        
    </div>
</div>

<%-- 템플릿 페이지를 불러오는 코드 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
