<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    
    <h1>수거 목록</h1>
    
    <div class="container">
    <h1>신청번호</h1>
    <tr>
    <td>${applyDto.applyNo}</td>
    </tr>
      <tr>
            <th>아이디</th>
            <td>${memberDto.memberId}</td>
        </tr>
      <tr>
            <th>이용지역</th>
            <td>${applyDto.applyArea}</td>
        </tr>
              <tr>
            <th>우편번호</th>
            <td>${applyDto.applyArea}</td>
        </tr>
              <tr>
            <th>기본주소</th>
            <td>${applyDto.applyAddress1}</td>
        </tr>
              <tr>
            <th>상세주소</th>
            <td>${applyDto.applyAdress2}</td>
        </tr>
              <tr>
            <th>출입불가코드</th>
            <td>${applyDto.applyWay}</td>
        </tr>
              <tr>
            <th>증량</th>
            <td>${applyDto.applyWeight}</td>
        </tr>
              <tr>
            <th>배출봉투</th>
            <td>${applyDto.applyrArea}</td>
        </tr>
    
    </div>
    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    