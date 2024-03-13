<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!-- 구글 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<!-- 스타일 -->
<link rel="stylesheet" type="text/css" href="/css/commons.css">
<style>
    /* 메뉴 글씨체 색상 및 메뉴 바탕색 */
    .menu a {
        color: green;
        background-color: white;
        padding: 5px 10px;
        text-decoration: none;
    }

    .header {
        display: flex;
        justify-content: center; /* 가운데 정렬을 위한 수정 */
        align-items: center;
        flex-direction: column; /* 세로 방향으로 배치 */
    }

    .header h1 {
        margin: 0;
    }

    .header img {
        width: 200px;
        height: 200px;
    }

  
</style>

<!-- font awesome 아이콘 CDN -->
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">

<!-- jQuery CDN -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>

<!-- 내가 만든 JS -->
<script>
	$(function() {
		var options = {
			//에디터 툴바(메뉴) 설정
			toolbar : [
				// [groupName, [list of button]]
				[ 'style', [ 'bold', 'italic', 'underline' ] ],
				[ 'fontsize', [ 'fontname', 'fontsize' ] ],
				[ 'color', [ 'forecolor', 'backcolor' ] ],
				[ 'para', [ 'style', 'ul', 'ol', 'paragraph' ] ],
				[ 'insert', [ 'picture', 'link', 'hr' ] ], 
			],
			//기본높이 설정(단위 : px)
			height : 200,
			minHeight : 200,
			maxHeight : 300,
			//안내문구 설정
			//placeholder: "입력하세요",
			callbacks : {
				onImageUpload : function(files) {
					var editor = this;
					
					var formData = new FormData();
					for (var i = 0; i < files.length; i++) {
						formData.append("attachList", files[i]);
					}

					$.ajax({
						url : "/rest/board_attach/upload",
						method : "post",
						data : formData,
						processData : false,
						contentType : false,
						success : function(response) {
							if (response == null)
								return;

							for (var i = 0; i < response.length; i++) {
								var tag = $("<img>")
									.attr("src", "/download?attachNo=" + response[i])
									.attr("data-key", response[i])
									.addClass("server-img");
								$(editor).summernote("insertNode", tag[0]);
							} 
						}
					});
				}
			}
		};

		$("[name=boardContent]").summernote(options);
	});
</script>

</head>
<body>

<main>
    <div class="header">
        <h1 class="left"><img src="/image/title.png" ></h1>
        <div class="nav">
            <ul class="menu center">
                <li><a href="/">홈</a></li>
                <li><a href="#">수거서비스</a></li>
                
                <li><a href="#">게시판</a>
                <ul>
                <li><a href ="/qna/list">문의게시판</a>
                <li><a href="/">리뷰게시판</a>
                </ul></li>
                
                <li><a href="/point/charge">포인트</a></li>
                <li><a href="/member/login">로그인</a></li>
                <li><a href="/member/signUp">회원가입</a></li>
                
                	<c:if test="${sessionScope.loginLevel == '관리자'}">
					<li><a href="#">관리자메뉴</a>
					<ul>
					<li><a href="/admin/member/search">회원관리</a></li>
					<li><a href="/admin/member/pickerlist">피커승인</a></li>
					</ul></li>
					</c:if>
						
						
            </ul>
        </div>
    </div>
  
    <div class="section">
        <div class="article">
            <!-- Your article content goes hered -->
        </div>
    </div>
  
</main>

</body>
</html>