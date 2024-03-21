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

    /* 버튼 스타일 */
    .btn-primary {
        background-color: #ff8080;
        border-color: #ff8080;
        border-radius: 10px;
        color: white;
    }

    .btn-primary:hover {
  		  cursor: pointer;
    }

    .btn-info,
    .btn-danger {
        background-color: beige;
        border-color: beige;
        border-radius: 10px;
    }

    .btn-info:hover,
    .btn-danger:hover {
    cursor: pointer;
    }

    /* 표 스타일 */
    table {
        width: 100%;
        border-collapse: collapse;
    }

    th, td {
        border: 1px solid #dddddd;
        text-align: left;
        padding: 8px;
    }

    th {
        background-color: #f2f2f2;
    }

    /* 중앙 정렬 */
    .center {
        text-align: center;
    }
</style>

<div class="container mt-5 center">
    <h1 class="text-center mb-4">충전 상품 목록</h1>

    <!-- 신규 등록 버튼 -->
    <div class="text-center mb-3">
        <a href="add" class="btn btn-primary">신규 등록</a>
    </div>

    <!-- 충전 상품 목록 테이블 -->
    <div class="table-responsive">
        <table>
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>상품명</th>
                    <th>가격</th>
                    <th>포인트 충전</th>
                    <th>수정/삭제</th>
                </tr>
            </thead>
            <tbody>
                <!-- 포인트 상품 반복 출력 -->
                <c:forEach var="pointDto" items="${list}">
                    <tr>
                        <td><img src="image?pointNo=${pointDto.pointNo}" alt="${pointDto.pointName}" class="img-thumbnail"></td>
                        <td>${pointDto.pointName}</td>
                        <td>${pointDto.pointSell}원</td>
                        <td>${pointDto.pointCharge}포인트 충전</td>
                        <td>
                            <a href="edit?pointNo=${pointDto.pointNo}" class="btn btn-info btn-sm">수정</a>
                            <a href="delete?pointNo=${pointDto.pointNo}" class="btn btn-danger btn-sm">삭제</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
