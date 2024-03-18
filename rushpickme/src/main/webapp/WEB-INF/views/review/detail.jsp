<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<script
	src="https://cdn.jsdelivr.net/gh/hiphop5782/score@latest/score.js"></script>

<style>
	.reply-list-wrapper > .reply-item,
	.reply-list-wrapper > .reply-item-edit 
	{
		padding-bottom:10px;
		margin-bottom: 10px;
		border-bottom: 1px solid #b2bec3;
	}
	
		         .pick-container {
         border-radius: 10px;
         border: 1px solid gainsboro;
         box-shadow: 0px 4px 4px 2px gainsboro;
     }
     
     .fixed-height-td {
    height: 60px; /* 고정하려는 높이 설정 */
    width: 60px;
}

.fixed-height-td img {
    max-width: 60px; /* 이미지의 최대 너비를 100%로 설정하여 부모 요소에 맞춥니다. */
    max-height: 60px; /* 이미지의 높이를 자동으로 조절하여 비율을 유지합니다. */
}
	
</style>
<script type="text/template" id="reply-item-wrapper">
	<div class="reply-item">
		<h3>
			<span class="reply-writer">작성자</span>
			<i class="fa-solid fa-edit blue ms-20 btn-reply-edit"></i>
			<i class="fa-solid fa-trash red btn-reply-delete"></i>
		</h3>
		<pre class="reply-content" style="min-height:150px; font-size:20px;">댓글 내용</pre>
		<div class="reply-time">yyyy-MM-dd HH:mm:ss</div>
	</div>
</script>
<script type="text/template" id="reply-item-edit-wrapper">
	<div class="reply-item-edit">
		<h3 class="reply-writer">작성자</h3>
		<textarea class="tool w-100 reply-editor2" style="min-height:150px"></textarea>
		<div class="right">
			<button class="btn positive btn-reply-save">
				<i class="fa-solid fa-check"></i>
				변경
			</button>
			<button class="btn negative btn-reply-cancel">
				<i class="fa-solid fa-xmark"></i>
				취소
			</button>
		</div>
	</div>
</script>
<script type="text/javascript">
	function loadList() {
		//파라미터에서 게시글 번호를 읽는다
		var params = new URLSearchParams(location.search);
		var reviewNo = params.get("reviewNo");
		
		//현재 사용자의 정보를 저장한다
		var loginId = "${sessionScope.loginId}";
		var isLogin = loginId.length > 0;
		
		//페이지 로딩 완료 시 댓글 목록을 불러와서 출력
		$.ajax({
			url:"/rest/reply/list",
			method:"post",
			data: { replyOrigin : reviewNo },
			success: function(response) {
				//댓글 개수를 표시
				$(".reply-count").text(response.length);
				
				//기존에 있는 내용을 지우도록 지시
				$(".reply-list-wrapper").empty();//비워라!
				
				//내용을 목록에 출력
				//response는 List<ReplyDto> 형태
				for(var i=0; i < response.length; i++) {
					//template 불러오고
					var templateText = $("#reply-item-wrapper").text();
					var templateHtml = $.parseHTML(templateText);
						
					//정보 출력
					$(templateHtml).find(".reply-writer").text(response[i].replyWriter);
					$(templateHtml).find(".reply-content").text(response[i].replyContent);
					$(templateHtml).find(".reply-time").text(response[i].replyTime);
					
					//화면에 필요한 정보를 추가(ex : 삭제버튼에 번호 설정)
					//- data라는 명령으로는 읽기만 가능
					//- 태그에 글자를 추가하고 싶다면 .attr() 명령 사용
					//- 현재 로그인한 사용자의 댓글에만 버튼을 표시(나머진 삭제)
					//if(내가 작성한 댓글인 경우) {
					//if(현재사용자ID == 댓글의작성자) {
					if(isLogin && loginId == response[i].replyWriter) {
						$(templateHtml).find(".btn-reply-edit")
												.attr("data-reply-no", response[i].replyNo);
						$(templateHtml).find(".btn-reply-delete")
												.attr("data-reply-no", response[i].replyNo);
					}
					else {
						$(templateHtml).find(".btn-reply-edit").remove();
						$(templateHtml).find(".btn-reply-delete").remove();
					}
					
					//화면에 추가
					$(".reply-list-wrapper").append(templateHtml);
				}								
			}
		});
	}

	$(function(){
		//최초 목록 불러오기
		loadList();
		
		//문서에 댓글 삭제 이벤트 등록
		//- 화면을 지우는 것이 아니라 서버에 지워달라고 요청을 해야 한다
		//- 삭제가 완료되면 화면을 직접 지우지 말고 목록을 다시 불러온다
		$(document).on("click", ".btn-reply-delete", function(){
			var choice = window.confirm("댓글을 삭제하시겠습니까?");
			if(choice == false) return;
			
			//태그에 심어져 있는 번호 정보를 읽어와서 삭제하도록 요청
			var replyNo = $(this).data("reply-no");
			
			$.ajax({
				url: "/rest/reply/delete",
				method: "post",
				data: { replyNo : replyNo },
				success: function(response) {
					loadList();//삭제가 완료되면 목록 불러오기
				}
			});
		});
		
		//댓글 등록 이벤트
		$(".btn-reply-insert").click(function(){
			//등록에 필요한 정보(내용,소속글번호)를 구해온다
			var replyContent = $(".reply-editor").val();
			if(replyContent.length == 0) return;//비어있는 경우만 차단
			//if(replyContent.trim().length == 0) return;//공백만 있는경우도 차단
			
			var params = new URLSearchParams(location.search);
			var reviewNo = params.get("reviewNo");
			
			$.ajax({
				url: "/rest/reply/insert",
				method: "post",
				data: {
					replyContent : replyContent, 
					replyOrigin : reviewNo
				},
				success: function(response){
					$(".reply-editor").val("");//에디터 내용 삭제
					loadList();//등록 완료 시 목록 갱신
				}
			});
			
		});
		
		//문서에 댓글 수정 이벤트 등록
		//- 수정용 템플릿을 불러와서 출력용 템플릿의 내용을 복사한 뒤 추가
		//- (네이버) 하나의 글만 수정이 가능하던데......
		$(document).on("click", ".btn-reply-edit", function(){
			//(네이버) 열려있는 모든 수정화면을 되돌린다
			$(".reply-item-edit").prev(".reply-item").show();
			$(".reply-item-edit").remove();
			
			//템플릿 불러와서 해석
			var templateText = $("#reply-item-edit-wrapper").text();
			var templateHtml = $.parseHTML(templateText);
			
			//댓글내용을 템플릿의 textarea에 설정
			var replyWriter = $(this).parents(".reply-item").find(".reply-writer").text();
			$(templateHtml).find(".reply-writer").text(replyWriter);
			
			var replyContent = $(this).parents(".reply-item").find(".reply-content").text();
			$(templateHtml).find(".reply-editor2").val(replyContent);
			
			//(추가) 변경버튼을 눌렀을 때 글번호를 알 수 있도록 설정
			var replyNo = $(this).data("reply-no");
			$(templateHtml).find(".btn-reply-save")
									.attr("data-reply-no", replyNo);
			
			//화면에 추가
			$(this).parents(".reply-item").hide().after(templateHtml);
		});
		$(document).on("click", ".btn-reply-save", function(){
			//서버에 변경요청을 비동기로 보내고 나서 목록을 갱신
			//전송에 필요한 정보 - 글번호, 글내용
			
			var replyNo = $(this).data("reply-no");
			var replyContent = $(this).parents(".reply-item-edit")
													.find(".reply-editor2").val();
			if(replyContent.length == 0) return;
			
			$.ajax({
				url: "/rest/reply/edit",
				method: "post",
				data: {
					replyNo : replyNo,
					replyContent : replyContent
				},
				success: function(response) {
					loadList();//수정 완료 시 목록 갱신
				}
			});
			
		});
		$(document).on("click", ".btn-reply-cancel", function(){
			//수정용 화면을 제거하고 출력용 화면을 출력
			$(this).parents(".reply-item-edit").prev(".reply-item").show();
			$(this).parents(".reply-item-edit").remove();
		});
	});
	

    $(function(){
        $(".btn-click").click(function(){
            var result = confirm("정말 삭제하시겠어요?");
            if (result) {
                // "확인" 버튼을 클릭한 경우
                alert("삭제되었습니다.");
                // 삭제 동작을 수행하는 코드를 여기에 추가할 수 있습니다.
            } else {
                // "취소" 버튼을 클릭한 경우
                alert("삭제가 취소되었습니다.");
                return false; // 이벤트 기본 동작을 중단합니다.
            }
        });
    });

	
</script>

<c:if test="${sessionScope.loginId != null}">
<script type="text/javascript">
	//좋아요 하트 클릭 이벤트
	$(function(){
		//(주의) 아무리 같은 페이지라도 서로 다른언어를 혼용하지 말것
		//- 자바스크립트에서 파라미터를 읽어 번호를 추출
		var params = new URLSearchParams(location.search);
		var reviewNo = params.get("reviewNo");
		
		//목표 : 하트를 클릭하면 좋아요 갱신처리
		$(".review-like").find(".fa-heart").click(function(){
			$.ajax({
				url : "/rest/review_like/toggle",//같은 서버이므로 앞 경로 생략
				method : "post",
				data : { reviewNo : reviewNo },
				success : function(response){
					//console.log(response);
					
					//response.state에 따라서 하트의 형태를 설정
					$(".review-like").find(".fa-heart")
						.removeClass("fa-solid fa-regular")
						.addClass(response.state ? "fa-solid" : "fa-regular");
					
					//response.count에 따라서 좋아요 개수를 표시
					$(".review-like").find(".count").text(response.count);
				}
			});
		});
	});
</script>
</c:if>
<script type="text/javascript">
	//좋아요 최초 불러오기
	$(function(){
		//(주의) 아무리 같은 페이지라도 서로 다른언어를 혼용하지 말것
		//- 자바스크립트에서 파라미터를 읽어 번호를 추출
		var params = new URLSearchParams(location.search);
		var reviewNo = params.get("reviewNo");
		
		//최초에 표시될 화면을 위해 화면이 로딩되자마자 서버로 비동기통신 시도
		$.ajax({
			url : "/rest/review_like/check",
			method : "post",
			data : { reviewNo : reviewNo },
			success: function(response) {
				//response.state에 따라서 하트의 형태를 설정
				$(".review-like").find(".fa-heart")
					.removeClass("fa-solid fa-regular")
					.addClass(response.state ? "fa-solid" : "fa-regular");
				
				//response.count에 따라서 좋아요 개수를 표시
				$(".review-like").find(".count").text(response.count);
			}
		});
	});
</script>

<script>
	$(function() {
		//출력용
		$(".score").score({
			starColor : "#ff8080", //별 색상
			display : {//표시 옵션
				showNumber : false,//숫자 표시 여부
				textColor : "#ff8080", //글자 색상
				placeLimit : 0,//표시할 소수점 자리수
			},
		});
	});
</script>

	
<div class="container pick-container w-800 py-30 px-50 my-50">
	<div class="cell center">
		<h1>${reviewDto.reviewNo}번 글 보기</h1>
	</div>
	
	<div class="cell">
		<h2>
			<div class="score" data-max="5.0" data-rate="${reviewDto.reviewStar}">
			</div>
			
			<%-- (추가) 수정시각 유무에 따라 수정됨 표시 --%>
			<c:if test="${reviewDto.reviewEdit != null}">
				(수정)
			</c:if>
		</h2>
	</div>
	
	<div class="cell">
		<h3>
			<%-- 탈퇴한 사용자일 때와 아닐 때 나오는 정보가 다르게 구현 --%>
			<c:choose>
				<c:when test="${reviewDto.memberId == null}">
					${reviewDto.memberIdStr}
				</c:when>
				<c:otherwise>
					${memberDto.memberNick}
					(${memberDto.memberType})
				</c:otherwise>
			</c:choose>
		</h3>
	</div>
	
	<hr>
	<div class="cell" style="min-height:250px;">
		<%-- 
			HTML은 엔터와 스페이스 등을 무시하기 때문에 textarea와 모양이 달라진다
			- 상용 에디터를 쓰면 알아서 글자를 보정해주기 때문에 문제가 없다
			- 기본 textarea를 쓰면 문제가 발생한다
			- <pre>태그를 사용하면 글자를 있는 그대로 출력한다  
			- Rich Text Editor를 사용하면 문제가 해결된다(ex : summernote)
			<pre>${reviewDto.reviewContent}</pre>
		--%>
		${reviewDto.reviewContent}
	</div>
	
	<hr>
	<div class="cell">
		조회수 ${reviewDto.reviewHits} 

		<span class="review-like red">
			<i class="fa-regular fa-heart"></i>
			<span class="count">?</span>
		</span> 
	</div>
	
	<div class="cell">
		<fmt:formatDate value="${reviewDto.reviewWrite}" 
									pattern="yyyy-MM-dd HH:mm:ss"/>
	</div>
	
	<div class="cell">
		${reviewDto.reviewWriteDiff}
	</div>
	
	<div class="cell right">
		<a class="btn" href="write">글쓰기</a>
		
		<%-- 
			수정과 삭제 링크는 회원이면서 본인글이거나 관리자일 경우만 출력 
			- 본인글이란 로그인한 사용자 아이디와 게시글 작성자가 같은 경우
			- 관리자란 로그인한 사용자 등급이 '관리자'인 경우
		--%>
		<c:if test="${sessionScope.loginId != null && (sessionScope.loginId == reviewDto.memberId || sessionScope.loginLevel == '관리자')}">
		<a class="btn negative" href="edit?reviewNo=${reviewDto.reviewNo}">글수정</a>
		<a class="btn negative link-confirm btn-click" 
				data-message="정말 삭제하시겠습니까?" 
				href="delete?reviewNo=${reviewDto.reviewNo}">글삭제</a>
		</c:if>
		<a class="btn positive" href="list">글목록</a>
	</div>
	
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



