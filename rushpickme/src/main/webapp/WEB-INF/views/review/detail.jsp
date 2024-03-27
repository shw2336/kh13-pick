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

<script type="text/javascript">
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
		<h1>${reviewMemberNickVO.reviewNo}번 글 보기</h1>
	</div>
	
	<div class="cell">
		<h2>
			<div class="score" data-max="5.0" data-rate="${reviewMemberNickVO.reviewStar}">
			</div>
			
			<%-- (추가) 수정시각 유무에 따라 수정됨 표시 --%>
			<c:if test="${reviewMemberNickVO.reviewEdit != null}">
				(수정)
			</c:if>
		</h2>
	</div>
	
	<div class="cell">
		<h3>
			<%-- 탈퇴한 사용자일 때와 아닐 때 나오는 정보가 다르게 구현 --%>
			<c:choose>
				<c:when test="${reviewMemberNickVO.memberId == null}">
					${reviewMemberNickVO.memberIdStr}
				</c:when>
				<c:otherwise>
					${memberDto.memberNick}
					(${memberDto.memberType})
				</c:otherwise>
			</c:choose>
		</h3>
	</div>
	
	<div class="cell right">
		조회수 ${reviewMemberNickVO.reviewHits} 
	</div>
	
<hr style="border: none; height: 3px; background: linear-gradient(to right, #000000, #ffffff);">

	<div class="cell" style="min-height:250px;">
		<%-- 
			HTML은 엔터와 스페이스 등을 무시하기 때문에 textarea와 모양이 달라진다
			- 상용 에디터를 쓰면 알아서 글자를 보정해주기 때문에 문제가 없다
			- 기본 textarea를 쓰면 문제가 발생한다
			- <pre>태그를 사용하면 글자를 있는 그대로 출력한다  
			- Rich Text Editor를 사용하면 문제가 해결된다(ex : summernote)
			<pre>${reviewDto.reviewContent}</pre>
		--%>
		${reviewMemberNickVO.reviewContent}
	</div>
	
<hr style="border: none; height: 3px; background: linear-gradient(to left, #000000, #ffffff);">






	<div>
		좋아요<span class="review-like red">
			<i class="fa-regular fa-heart"></i>
			<span class="count">?</span>
		</span> 
	</div>
	
	<div class="cell right">
		<fmt:formatDate value="${reviewMemberNickVO.reviewWrite}" 
									pattern="yyyy-MM-dd HH:mm:ss"/>
	</div>
	
	<div class="cell right">
		${reviewMemberNickVO.reviewWriteDiff}
	</div>
	
	<div class="cell right">
		<%-- 
			수정과 삭제 링크는 회원이면서 본인글이거나 관리자일 경우만 출력 
			- 본인글이란 로그인한 사용자 아이디와 게시글 작성자가 같은 경우
			- 관리자란 로그인한 사용자 등급이 '관리자'인 경우
		--%>
		<c:if test="${sessionScope.loginId != null && (sessionScope.loginId == reviewMemberNickVO.memberId || sessionScope.loginLevel == '관리자')}">
		<a class="btn negative" href="edit?reviewNo=${reviewMemberNickVO.reviewNo}">글수정</a>
		<a class="btn negative link-confirm btn-click" 
				data-message="정말 삭제하시겠습니까?" 
				href="delete?reviewNo=${reviewMemberNickVO.reviewNo}">글삭제</a>
		</c:if>
		<a class="btn positive" href="list">글목록</a>
	</div>
	
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



