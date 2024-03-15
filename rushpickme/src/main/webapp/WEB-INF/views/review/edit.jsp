<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <!-- 내가 구현한 스타일 -->
    <link rel="stylesheet" type="text/css" href="../css/commons.css">

    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

    <!-- font awesome 아이콘 CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

    <script>
        $(function(){
            //작성용
                $(".score-edit").score({
                starColor: "#ff8080", //별 색상
                editable: true,//편집 가능 설정
                integerOnly: true,//정수만 선택 가능하도록 설정

                send:{//전송 옵션
                    sendable:true,//전송 허용
                    name:"score",//전송할 파라미터명
                },

                display:{//표시 옵션
                    showNumber: true,//숫자 표시 여부
                    textColor: "#ff8080", //글자 색상
                    placeLimit: 0,//표시할 소수점 자리수
                },

                point:{//점수 옵션
                    max:5,//최대 점수
                    rate:5,//최초 점수
                }
            });
        });
    </script>

<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="reviewNo" value="${reviewDto.reviewNo}">

<div class="container w-800">
	<div class="cell center"><h1>리뷰 수정</h1></div>

      <div class="cell">
            <h2>작성할 때</h2>
        </div>
        
        <div class="cell">
            <div class="score-edit" data-max="5.0" data-rate="${reviewDto.reviewStar}"></div>
        </div>

	<div class="cell">
		<label>내용</label>
		<%-- textarea는 시작태그와 종료태그 사이에 내용을 작성 --%>
		<textarea name="reviewContent" required class="tool w-100" rows="10">${reviewDto.reviewContent}</textarea>
	</div>
	<div class="cell right">
		<a href="list" class="btn">목록</a>
		<button class="btn positive" type="submit">수정</button>
	</div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>