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
                starColor: "#0984e3", //별 색상
                editable: true,//편집 가능 설정
                integerOnly: true,//정수만 선택 가능하도록 설정

                send:{//전송 옵션
                    sendable:true,//전송 허용
                    name:"score",//전송할 파라미터명
                },

                display:{//표시 옵션
                    showNumber: true,//숫자 표시 여부
                    textColor: "#0984e3", //글자 색상
                    placeLimit: 1,//표시할 소수점 자리수
                },

                point:{//점수 옵션
                    max:10,//최대 점수
                    rate:1,//최초 점수
                }
            });
        });
    </script>

<form action="write" method="post" autocomplete="off">

<div class="container w-800">
	<div class="cell center"><h1>리뷰 작성</h1></div>

      <div class="cell">
            <h2>작성할 때</h2>
        </div>
        
        <div class="cell">
            <div class="score-edit" data-max="5.0" data-rate="3.5"></div>
        </div>
          
	<div class="cell">
		<label>내용</label>
		<%-- 
			여러 줄 입력하고 싶다면 textarea 태그를 사용한다 
			<input type="text" name="boardContent" required>
			
			textarea 태그는 종료 태그가 필요하며, type과 value를 설정할 수 없다
			 <textarea name="boardContent" required></textarea>
		--%>
		<textarea name="reviewContent" required class="tool w-100" rows="10"></textarea>
	</div>
	<div class="cell right">
		<a href="list" class="btn">목록</a>
		<button class="btn positive" type="submit">등록</button>
	</div>
</div>
	
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>