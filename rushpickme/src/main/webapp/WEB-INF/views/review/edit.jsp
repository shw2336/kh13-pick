<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <!-- 내가 구현한 스타일 -->
    <link rel="stylesheet" type="text/css" href="../css/commons.css">

    <!-- jquery cdn -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>
    
    <!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
	<script src="commons.js"></script>
	
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
    
    <script type="text/javascript">
        $(function () {

        	$("[name=reviewContent]").summernote({
                //에디터 툴바(메뉴) 설정
                toolbar: [
                    // [groupName, [list of button]]
                    ['style', ['bold', 'italic', 'underline']],
                    ['fontsize', ['fontname', 'fontsize']],
                    ['color', ['forecolor', 'backcolor']],
                    ['para', ['style', 'ul', 'ol', 'paragraph']],
                    ['insert', ['picture', 'link', 'hr']],
                ],
                //기본높이 설정(단위 : px)
                height: 200,
                minHeight: 200,
                maxHeight: 300,
                //안내문구 설정
                placeholder: "내용을 입력하세요",

                //이미지 파일을 추가할 때 처리할 내용을 재정의
                callbacks: {
                    onImageUpload: function (files) {
                        //console.log("이미지 파일 선택됨");
                        //console.log(files);

                        //파일 업로드는 일반 데이터와 전송 방식이 다르다!(면접에서 무조건 물어봄)
                        //이 방식의 이름은 multipart/form-data 이다
                        //<form>은 enctype = multipart/form-data라고 쓰면 되는데..
                        //ajax로는 어떻게 하지?
                        //ajax를 post방식으로 전송하며 두 가지 설정을 추가한다
                        //processData: false, contentType: false,

                        //FormData는 전송을 위한 데이터 저장소(자바의 Map과 동일)
                        var formData = new FormData();
                        //formData.append("이름", 값);
                        for(var i=0; i < files.length; i++){
                        formData.append("attachList", files[i]);
                        }

                        $.ajax({
                          url: "${pageContext.request.contextPath}/rest/review_attach/upload",
                          method: "post",
                          data: formData,
                          processData: false,
                          contentType: false,
                          success: function(response){
                            //response에는 업로드된 이미지들의 번호 배열이 있다
                            if(response == null) return;

                            for(var i=0; i < response.length; i++) {
                              //response[i] == 이미지 번호 1개
                              var tag = $("<img>").attr("src", "${pageContext.request.contextPath}/download?attachNo="+response[i])
                              $("[name=reviewContent]").summernote("insertNode", tag[0]);
                            }
                          }
                        });
                    }
                }
            });

        });
    </script>

<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="reviewNo" value="${reviewMemberNickVO.reviewNo}">

<div class="container w-800">
	<div class="cell center"><h1>리뷰 수정</h1></div>

        
        <h2>
            <div class="score-edit" data-max="5.0" data-rate="${reviewMemberNickVO.reviewStar}"></div>
         </h2>

	<div class="cell">
		<%-- textarea는 시작태그와 종료태그 사이에 내용을 작성 --%>
		<textarea name="reviewContent" required rows="10">${reviewMemberNickVO.reviewContent}</textarea>
	</div>
	<div class="cell right">
		<a href="list" class="btn">목록</a>
		<button class="btn positive" type="submit">수정</button>
	</div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>