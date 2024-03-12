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
        width: 350px;
        height: 350px;
        position: absolute; /* shop-img를 절대 위치로 변경 */
        top: 450px; /* 원하는 위치로 조절 */
        left: 1300px; /* 원하는 위치로 조절 */
    }

    .click-img {
        display: flex;
        position: absolute;
        top: 150px; /* 원하는 위치로 조절 */
        right: 270px;
        width: 300px;
        height: 300px;
    }

    .how-img {
        width: 1100px;
        height: 550px;
        left: 20%; /* 가운데 정렬을 위해 왼쪽 위치 설정 */
        top: 70%; /* 가운데 정렬을 위해 위쪽 위치 설정 */
        transform: translate(35%, 0%); /* 가운데 정렬을 위한 변형(transform) 설정 */
    }
    }
</style>

<div class="section">
    <div class="article slogan-container">
        <img src="/image/slogan.png" class="slogan-img">
        <img src="/image/shop.png" class="shop-img">
        <img src="/image/click.png" class="click-img">
        <img src="/image/how.png" class="how-img">
        
    </div>
</div>

<%-- 템플릿 페이지를 불러오는 코드 --%>
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
