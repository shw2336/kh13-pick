
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>RUSHPICKME!</title>

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- 내가 구현한 스타일 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/commons.css">
<!--     <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- 스타일 -->
<style>
    /* 메뉴 글씨체 색상 및 메뉴 바탕색 */
  
    .header {
        padding-top: 50px; /* 위 여백 설정 */
        padding-bottom: 100px; /* 아래 여백 설정 */
    }

    .header img {
            display: block; 
            margin: 0 auto; 
            max-width: 20%; 
            height: auto; 
            cursor: pointer; /* 홈으로 가는 버튼 커서 설정 */
        }
    .menu a {
        color: rgb(66,138,66);
        background-color: white;
        padding: 10px 10px;
        text-decoration: none;
    }

    .sub-menu {
        display: none;
        position: absolute;
        background-color: white;
        padding: 10px;
        z-index: 1;
    }

    .board-menu {
        position: relative;
    }
    
    .board-menu:hover .sub-menu {
        display: block;
    }
    
/*     ul > li > a:hover{ */
/*      background-color: rgba(253, 255, 134, 0.153); */
/*      border-radius:10px; */
/*     } */
</style>

<!--  jQuery CDN -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<script>
    $(document).ready(function(){
        $(".header img").click(function(){
            window.location.href = "/"; // 홈으로 이동하는 URL 설정
        });
    });
</script>

</head>
<body>

<main>
    <div class="header">
  
       <h1 class="left"><img src="${pageContext.request.contextPath}/image/title.png" style="max-width: 200px; height: auto;"></h1>
        <div class="nav">
            <ul class="menu center">
                <li><a href="/">홈</a></li>
                
                <c:if test="${sessionScope.loginLevel == '피커'}">
               <li><a href="${pageContext.request.contextPath}/pick/list">수거서비스</a></li>
               </c:if>
               
               
               <c:if test="${sessionScope.loginLevel == '그린'}">
               <li><a href="${pageContext.request.contextPath}/apply/request">수거서비스</a></li>
               <li><a href="${pageContext.request.contextPath}/apply/applyList">신청 목록</a></li>
               </c:if>
                
                <li class="board-menu"><a href="#">게시판</a>
                    <ul class="sub-menu">
                        <li><a href="${pageContext.request.contextPath}/qna/list">문의게시판</a></li>
                        <li><a href="${pageContext.request.contextPath}/review/list">리뷰게시판</a></li>
                    </ul>
                </li>
               
                
                
                
                
                
                <%-- 관리자 메뉴는 관리자에게만 출력 --%>
				<c:if test="${sessionScope.loginLevel == '관리자'}">
				
					 <li class="board-menu"><a href="#">관리자메뉴</a>
		
						<ul class="sub-menu">
                                        <li><a href="${pageContext.request.contextPath}/admin/member/search">회원관리</a></li>
                                        <li><a href="${pageContext.request.contextPath}/admin/point/add">포인트관리</a></li>
                                          <li><a href="${pageContext.request.contextPath}/admin/check/apply">신청관리</a></li>
                                          <li><a href="${pageContext.request.contextPath}/admin/check/pick">수거관리</a></li>
                                    </ul>
                                    <li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
				</c:if>

				<li class="menu-end">
						<c:choose>
						<c:when test="${sessionScope.loginId != null && sessionScope.loginLevel != '관리자'}">
							<a href="${pageContext.request.contextPath}/member/mypage"> <i class="fa-solid fa-user"></i>
								${sessionScope.loginId}
							</a>
					
								
								<li><a href="${pageContext.request.contextPath}/member/logout">로그아웃</a></li>
								<li><a href="${pageContext.request.contextPath}/point/charge">포인트충전</a></li>
								
						</c:when>
						<c:when test="${sessionScope.loginId != null && sessionScope.loginLevel eq '관리자'}">
								<a href="#"><i class="fa-solid fa-user"></i>${sessionScope.loginId}</a>
						</c:when>
						<c:when test="${sessionScope.loginId eq null}">
								<a href="${pageContext.request.contextPath}/member/login">로그인</a>
								<li><a href="${pageContext.request.contextPath}/member/signUp">회원가입</a><li>
						</c:when>
						
					</c:choose>
                
            </ul>
        </div>
    </div>
   </main>
  
    <div class="section">
        <div class="article">
