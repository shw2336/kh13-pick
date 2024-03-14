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
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<!--     <link rel="stylesheet" type="text/css" href="/css/test.css"> -->

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- 스타일 -->
<style>
    /* 메뉴 글씨체 색상 및 메뉴 바탕색 */
    
    .header img {
            display: block; 
            margin: 0 auto; 
            max-width: 20%; 
            height: auto; 
        }
    .menu a {
        color: green;
        background-color: white;
        padding: 5px 10px;
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
</style>

<!--  jQuery CDN -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

</head>
<body>

<main>
    <div class="header">
        <h1 class="left"><img src="/image/title.png" ></h1>
        <div class="nav">
            <ul class="menu center">
                <li><a href="/">홈</a></li>
                
                <li><a href="#">수거서비스</a></li>
                
                <li class="board-menu"><a href="#">게시판</a>
                    <ul class="sub-menu">
                        <li><a href="/qna/list">문의게시판</a></li>
                        <li><a href="/">리뷰게시판</a></li>
                    </ul>
                </li>
                
                <li><a href="/point/charge">포인트</a></li>
                <li><a href="/member/login">로그인</a></li>
                <li><a href="/member/signUp">회원가입</a></li>
               
                <li class="menu-end">
                    <c:choose>
                        <c:when test="${sessionScope.loginId != null}">
                            <a href="/member/mypage"> <i class="fa-solid fa-user"></i>
                                ${sessionScope.loginId}
                            </a>
                            <ul>
                                <li><a href="/point/charge">포인트충전</a></li>
                                <li><a href="/member/logout">로그아웃</a></li>
                            </ul>
                            <c:if test="${sessionScope.loginLevel == '관리자'}">
                                <li class="board-menu"><a href="#">관리자메뉴</a>
                                    <ul class="sub-menu">
                                        <li><a href="/admin/member/search">회원관리</a></li>
                                        <li><a href="/admin/member/edit">회원수정</a></li>
                                        <li><a href="/admin/member/pickerlist">피커승인</a></li>
                                    </ul>
                                </li>
                            </c:if>
                        </c:when>
                    </c:choose>
                </li>       
            </ul>
        </div>
    </div>
  
    <div class="section">
        <div class="article">
