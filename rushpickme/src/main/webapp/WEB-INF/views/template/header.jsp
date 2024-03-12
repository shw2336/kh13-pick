<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- 스타일 -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<style>
    /* 메뉴 글씨체 색상 및 메뉴 바탕색 */
    .menu a {
        color: green; /* 글자색을 초록색으로 설정 */
        background-color: white; /* 바탕색을 흰색으로 설정 */
        padding: 5px 10px; /* 텍스트 주변에 여백을 주기 위해 padding 추가 */
        text-decoration: none; /* 링크 텍스트의 밑줄 제거 */
    	
    }

    .header {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .header h1 {
        margin: 0; /* Remove default margin */
    }

    .header img {
        width: 200px; /* Adjust the width as needed */
        height: 200px; /* Adjust the height as needed */
    }
    
        .menu {
        text-align: center; /* 가운데 정렬을 위한 text-align 추가 */
    }
</style>

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- jQuery CDN -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<!-- 내가 만든 JS -->
<script src="/js/commons.js"></script>

</head>
<body>

<main>
    <div class="header">
        <h1 class="left"><img src="image/title.png" ></h1>
        <div class="nav">
            <ul class="menu center">
                <li><a href="/">홈</a></li>
                <li><a href="#">수거서비스</a></li>
                <li><a href="#">문의사항</a></li>
                <li><a href="#">포인트</a></li>
                <li><a href="#">로그인</a></li>
                <li><a href="#">회원가입</a></li>
            </ul>
        </div>
    </div>

    <div class="section">
        <div class="article">
            <!-- Your article content goes here -->
        </div>
    </div>
</main>

</body>
</html>
