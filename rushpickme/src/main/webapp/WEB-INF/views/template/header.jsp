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
        color: green;
        background-color: white;
        padding: 5px 10px;
        text-decoration: none;
    }

    .header {
        display: flex;
        justify-content: center; /* 가운데 정렬을 위한 수정 */
        align-items: center;
        flex-direction: column; /* 세로 방향으로 배치 */
    }

    .header h1 {
        margin: 0;
    }

    .header img {
        width: 200px;
        height: 200px;
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
        <h1 class="left"><img src="/image/title.png" ></h1>
        <div class="nav">
            <ul class="menu center">
                <li><a href="/">홈</a></li>
                <li><a href="#">수거서비스</a></li>
                <li><a href="/qna/list">문의사항</a></li>
                <li><a href="#">포인트</a></li>
                <li><a href="/member/login">로그인</a></li>
                <li><a href="#">회원가입</a></li>
            </ul>
        </div>
    </div>
  
    <div class="section">
        <div class="article">
            <!-- Your article content goes hered -->
        </div>
    </div>
  
</main>

</body>
</html>