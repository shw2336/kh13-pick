<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>

</style>

<div class="container  w-600 px-50 pt-10 my-50">
	<div class="cell">
		<img src="/image/pickFinish.png" class="image" width="100%">
	</div>
</div>

<div class="container w-600 mb-50">
	<div class="cell flex-cell">
		<a href="list" class="btn">전체 목록으로 돌아가기</a>
		<a href="proceedList" class="btn">수거진행 목록으로 돌아가기</a>
	</div>
</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
