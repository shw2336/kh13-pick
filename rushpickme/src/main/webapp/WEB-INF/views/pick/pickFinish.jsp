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
	function urgentList (){
		window.location.href = "list";
	}
	function waitList (){
		window.location.href = "waitList";
	}	

</script>

<div class="container  w-500 mb-30">
	<div class="cell">
		<img src="/image/pickFinish.png" class="image" width="100%">
	</div>
</div>

	<div class="cell center mb-50">
		<button type="button" class="btn move" onclick="list();"><span class="btn-name">전체 목록 보기</span>
		</button>
			<span class="me-10"></span>
		<button type="button" class="btn move" onclick="urgentList();">
			<span class="btn-name"><span style="color:red; font-size:15px;" >긴급</span>
			<span>&nbsp;</span>수거대기건</span>
		</button>
			<span class="me-10"></span>
		<button type="button" class="btn move" onclick="waitList();">
			<span class="btn-name"><span style="color:rgb(66,138,66); font-size:15px;" >일반</span>
			<span>&nbsp;</span>수거대기건</span>
		</button>
		<span class="me-10"></span>
		<button class="btn move" onclick="proceedList();"><span class="btn-name">나의 진행건</span>
		</button>
	</div>


<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
