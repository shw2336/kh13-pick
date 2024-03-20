<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<style>

</style>

<script type="text/javascript">
	function list () {
		window.location.href = "list";
	}
	function proceedList () {
		window.location.href = "proceedList";
	}
</script>

<div class="container w-500 mb-30">
	<div class="cell">
		<img src="/image/pickFinish.png" class="image" width="100%">
	</div>
</div>

	<div class="cell center mb-50">
		<button class="btn move" onclick="list();"><span class="btn-name">전체 목록 보기</span></button>
		<span class="me-10"></span>
		<button class="btn move" onclick="proceedList();"><span class="btn-name">나의 진행건</span></button>
		<span class="me-10"></span>
		<button class="btn move" onclick="list();'"><span class="btn-name">나의 거부건</span></button>
		<span class="me-10"></span>
		<button class="btn move" onclick="list();'"><span class="btn-name">전체 목록 보기</span></button>
		<span class="me-10"></span>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
