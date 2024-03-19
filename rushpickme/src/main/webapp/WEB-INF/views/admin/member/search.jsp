<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
       .container {
        border-radius: 30px;
        border: 2px solid gainsboro;
        box-shadow: 0px 4px 4px 2px gainsboro;
        padding: 50px;
    }


    .search-container {
        margin: auto;
        width: 50%;
        text-align: center;
    }

    .search-container img {
        vertical-align: middle;
    }

    .search-select,
    .search-input,
    .search-button {
        margin: 5px;
        padding: 8px;
        border: none;
        border-radius: 5px;
    }

    .search-button {
        background-color: #4CAF50;
        color: #2d3436;
        cursor: pointer;
    }

    .search-button:hover {
        background-color: #45a049;
    }

    .member {
        margin: auto;
        width: 80%;
    }

    .member table {
        width: 100%;
        border-collapse: collapse;
    }

    .member th,
    .member td {
        padding: 8px;
        border: 1px solid #ddd;
    }

    .member th {
        background-color: #e9edc9;
    }

    .member tr:nth-child(even) {
        background-color: white;
    }
 .search-input {
        border: 1px solid #ddd; 
    }
    .member tr:hover {
        background-color: beige;
    }

    .detail-link {
        text-decoration: none;
        color: #ff8080;
    }
    
      .search-select {
        border: 1px solid #ddd;
    }

    .detail-link:hover {
        text-decoration: underline;
    }
</style>
<div class="container">
    <div class="search-container center">
        <img src="/image/search.png">
        <form action="search" method="get">
            <select name="column" class="search-select">
                <option value="member_id" ${param.column == 'member_id' ? 'selected' : ''}>아이디</option>
                <option value="member_nick" ${param.column == 'member_nick' ? 'selected' : ''}>닉네임</option>
                <option value="member_contact" ${param.column == 'member_contact' ? 'selected' : ''}>연락처</option>
                <option value="member_name" ${param.column == 'member_name' ? 'selected' : ''}>성함</option>
                <option value="member_type" ${param.column == 'member_type' ? 'selected' : ''}>회원유형</option>
                <option value="member_email" ${param.column == 'member_email' ? 'selected' : ''}>이메일</option>
                <option value="member_birth" ${param.column == 'member_birth' ? 'selected' : ''}>생년월일</option>
            </select>
            <input type="search" name="keyword" placeholder="검색어.." required value="${param.keyword}" class="search-input">
            <button type="submit" class="search-button">찾기</button>
        </form>
    </div>

    <hr>

    <c:choose>
        <c:when test="${list == null || list.isEmpty()}">
            <h2 class="center">검색 결과가 존재하지 않습니다</h2>
        </c:when>
        <c:otherwise>
            <div class="member">
                <table>
                    <thead>
                        <tr>
                            <th>아이디</th>
                            <th>닉네임</th>
                            <th>연락처</th>
                            <th>성함</th>
                            <th>회원유형</th>
                            <th>이메일</th>
                            <th>생년월일</th>
                            <th>상세정보</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="memberDto" items="${list}">
                            <tr>
                                <td>${memberDto.memberId}</td>
                                <td>${memberDto.memberNick}</td>
                                <td>${memberDto.memberContact}</td>
                                <td>${memberDto.memberName}</td>
                                <td>${memberDto.memberType}</td>
                                <td>${memberDto.memberEmail}</td>
                                <td>${memberDto.memberBirth}</td>
                                <td><a href="detail?memberId=${memberDto.memberId}" class="detail-link">상세보기</a></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:otherwise>
    </c:choose>

</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
