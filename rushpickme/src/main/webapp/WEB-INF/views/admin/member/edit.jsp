<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .container {
        text-align: center;
        margin: auto;
        width: 30%;
    }

    form {
        margin-top: 20px;
    }

    input[type="text"],
    input[type="tel"],
    select {
        padding: 10px;
        width: 100%;
        margin-bottom: 10px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        padding: 10px 20px;
        background-color: #4CAF50;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
    }

    button:hover {
        background-color: #45a049;
    }
</style>

<div class="container">
    <img src="${pageContext.request.contextPath}/image/memberedit.png">

    <form action="edit" method="post">
        <input type="hidden" name="memberId" value="${memberDto.memberId}">
        
        <label for="memberNick">닉네임</label>
        <input type="text" id="memberNick" name="memberNick" value="${memberDto.memberNick}" required> <br>
        
        <label for="memberContact">전화번호</label>
        <input type="tel" id="memberContact" name="memberContact" value="${memberDto.memberContact}" required> <br>
        
        <label for="memberType">등급</label>
        <select id="memberType" name="memberType" required >
            <option value="">선택하세요</option>
            <option value="그린" ${memberDto.memberType == '그린' ? 'selected' : ''}>그린</option>
            <option value="피커" ${memberDto.memberType == '피커' ? 'selected' : ''}>피커</option>
            <option value="관리자" ${memberDto.memberType == '관리자' ? 'selected' : ''}>관리자</option>
        </select>
        
        <button type="submit">변경</button>
    </form>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
