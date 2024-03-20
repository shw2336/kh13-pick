<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

    <!-- jquery cdn -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

    <script src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

    <!-- summernote cdn -->
    <link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
    <script src="commons.js"></script>

<style>
        /* 제목 입력칸 스타일링 */
        .title-input {
            border-radius: 7px;
            border: 2px solid #888080;
            padding: 8px;
            font-size: 1.2rem;
            width: 100%; /* 최대 너비는 800px로 설정 */
            max-width: 800px; /* 최대 너비 설정 */
            margin: 0 auto;
            box-sizing: border-box; /* 테두리를 포함한 전체 너비를 설정 */
            transition-property: transform, border-color;
            transition-duration: 0.2s; /* 변화 속도 설정 */
            transition-timing-function: ease-out; /* 변화 방식 설정 */
        }

        /* 입력칸에 호버했을 때 애니메이션 효과 추가 */
        .title-input:hover {
            transform: scale(1.01); /* 확대 효과 */
        }
       

    </style>

<script type="text/javascript">
        $(function () {

        	$("[name=qnaContent]").summernote({
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
                          url: "http://localhost:8080/rest/qna_attach/upload",
                          method: "post",
                          data: formData,
                          processData: false,
                          contentType: false,
                          success: function(response){
                            //response에는 업로드된 이미지들의 번호 배열이 있다
                            if(response == null) return;

                            for(var i=0; i < response.length; i++) {
                              //response[i] == 이미지 번호 1개
                              var tag = $("<img>").attr("src", "http://localhost:8080/download?attachNo="+response[i])
                              $("[name=qnaContent]").summernote("insertNode", tag[0]);
                            }
                          }
                        });
                    }
                }
            });

        });
    </script>

<form action="edit" method="post" autocomplete="off">
	<input type="hidden" name="qnaNo" value="${qnaDto.qnaNo}">

<div class="container w-800">
	<div class="cell center"><h1>게시글 수정</h1></div>
	<div style="text-align: center; margin-top: 50px; margin-bottom: 20px;">
		<input type="text" name="qnaTitle" required class="title-input" value="${qnaDto.qnaTitle}" placeholder="제목을 입력하세요">
	</div>
	<div class="cell">
		<%-- textarea는 시작태그와 종료태그 사이에 내용을 작성 --%>
		<textarea name="qnaContent" required rows="10">${qnaDto.qnaContent}</textarea>
	</div>
	<div class="cell right">
		<a href="list" class="btn">목록</a>
		<button class="btn positive">수정</button>
	</div>
</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>