<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        margin: 0 auto;
        padding: 20px;
        text-align: center;
        border-radius: 30px;
        border: 2px solid gainsboro;
        box-shadow: 0px 4px 4px 2px gainsboro;
 		padding: 50px;
    }

  .info-table {
        margin-top: 20px;
        border-collapse: collapse;
        width: 40%;
        margin: 0 auto;
    }
    .info-table th,
    .info-table td {
        padding: 10px;
        border: 1px solid #ddd;
    }

    .info-table th {
        background-color: #e9edc9;
    }

    .info-table tr:nth-child(even) {
        background-color: white;
    }

    .info-table tr:hover {
        background-color: beige;
    }

    .actions {
        margin-top: 20px;
    }

    .actions a {
        display: inline-block;
        margin-right: 20px;
        padding: 10px 20px;
        background-color: #ff8080;
        color: white;
        text-decoration: none;
        border: none;
        border-radius: 10px;
     
    }

    .actions a:hover {
    background-color: #f56a6a; 
        	  cursor: pointer;
    }

    .empty-msg {
        margin-top: 20px;
    }
</style>

<div class="container">
    <h1>${memberDto.memberId} 님의 회원 정보</h1>

    <table class="info-table">
        <tr>
            <th width="30%">아이디</th>
            <td>${memberDto.memberId}</td>
        </tr>
        <tr>
            <th>닉네임</th>
            <td>${memberDto.memberNick}</td>
        </tr>
        <tr>
            <th>전화번호</th>
            <td>${memberDto.memberContact}</td>
        </tr>
        <tr>
            <th>이름</th>
            <td>${memberDto.memberName}</td>
        </tr>
        <tr>
            <th>회원유형</th>
            <td>${memberDto.memberType}</td>
        </tr>
        <tr>
            <th>이메일</th>
            <td>${memberDto.memberEmail}</td>
        </tr>
        <tr>
            <th>생년월일</th>
            <td>${memberDto.memberBirth}</td>
        </tr>
    </table>

    <div class="actions">
        <a href="edit?memberId=${memberDto.memberId}">회원정보 변경</a>
        <a href="delete?memberId=${memberDto.memberId}">회원 강제탈퇴</a>
    </div>

    <hr>

    <h1>포인트 구매 내역</h1>

    <c:choose>
        <c:when test="${buyList.isEmpty()}">
            <h2 class="empty-msg">구매 내역이 존재하지 않습니다</h2>
        </c:when>
        <c:otherwise>
            <table class="info-table">
                <thead>
                    <tr>
                        <th>번호</th>
                        <th>상품명</th>
                        <th>수량</th>
                        <th>구매금액</th>
                        <th>구매일시</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="buyDto" items="${buyList}">
                        <tr>
                            <td>${buyDto.buyNo}</td>
                            <td>${buyDto.pointName}</td>
                            <td>${buyDto.buyQty}</td>
                            <td>
                                <fmt:formatNumber value="${buyDto.buyTotal}" pattern="#,##0"/>
                            </td>
                            <td>
                                <fmt:formatDate value="${buyDto.buyDate}" pattern="yyyy-MM-dd HH:mm"/>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
