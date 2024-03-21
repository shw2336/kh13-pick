<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
	         .pick-container {
         border-radius: 10px;
         border: 1px solid gainsboro;
         box-shadow: 0px 4px 4px 2px gainsboro;
     }
</style>

<script>
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


<div class="container pick-container w-800 py-30 px-50 my-50">
	<div class="cell center">
		<h1>${qnaDto.qnaNo}번 글 보기</h1>
	</div>
	
	<div class="cell">
		<h2>
			${qnaDto.qnaTitle}
			
			<%-- (추가) 수정시각 유무에 따라 수정됨 표시 --%>
			<c:if test="${qnaDto.qnaEdit != null}">
				(수정됨)
			</c:if>
		</h2>
	</div>
	
	<div class="cell">
		<h3>
			<%-- 탈퇴한 사용자일 때와 아닐 때 나오는 정보가 다르게 구현 --%>
			<c:choose>
				<c:when test="${qnaDto.memberId == null}">
					${qnaDto.memberIdStr}
				</c:when>
				<c:otherwise>
					${memberDto.memberNick}
					(${memberDto.memberType})
				</c:otherwise>
			</c:choose>
		</h3>
	</div>
	
<hr style="border: none; height: 3px; background: linear-gradient(to right, #000000, #ffffff);">

	<div class="cell" style="min-height:250px;">
		<%-- 
			HTML은 엔터와 스페이스 등을 무시하기 때문에 textarea와 모양이 달라진다
			- 상용 에디터를 쓰면 알아서 글자를 보정해주기 때문에 문제가 없다
			- 기본 textarea를 쓰면 문제가 발생한다
			- <pre>태그를 사용하면 글자를 있는 그대로 출력한다  
			- Rich Text Editor를 사용하면 문제가 해결된다(ex : summernote)
			<pre>${qnaDto.qnaContent}</pre>
		--%>
		${qnaDto.qnaContent}
	</div>
	
<hr style="border: none; height: 3px; background: linear-gradient(to left, #000000, #ffffff);">

	<div class="cell">
		조회수 ${qnaDto.qnaHits} 
	</div>
	
	<div class="cell">
		<fmt:formatDate value="${qnaDto.qnaWrite}" 
									pattern="yyyy-MM-dd HH:mm:ss"/>
	</div>
	
	<div class="cell">
		${qnaDto.qnaWriteDiff}
	</div>
	
	<div class="cell right">
		<a class="btn" href="write">글쓰기</a>
		<c:if test="${sessionScope.loginLevel == '관리자'}">
				<a class="btn" href="write?qnaTarget=${qnaDto.qnaNo}">답글쓰기</a>
		</c:if>
		<%-- 
			수정과 삭제 링크는 회원이면서 본인글이거나 관리자일 경우만 출력 
			- 본인글이란 로그인한 사용자 아이디와 게시글 작성자가 같은 경우
			- 관리자란 로그인한 사용자 등급이 '관리자'인 경우
		--%>
		<c:if test="${sessionScope.loginId != null && (sessionScope.loginId == qnaDto.memberId || sessionScope.loginLevel == '관리자')}">
		<a class="btn negative" href="edit?qnaNo=${qnaDto.qnaNo}">글수정</a>
		<a class="btn negative link-confirm btn-click" 
				data-message="정말 삭제하시겠습니까?" 
				href="delete?qnaNo=${qnaDto.qnaNo}">글삭제</a>
		</c:if>

		<a class="btn positive" href="list">글목록</a>
	</div>
	
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>



