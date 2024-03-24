<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<!-- Moment.js 스크립트를 포함 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>

<style>
table>tbody>.contents-tr {
	cursor: pointer;
	height: 40px;
}

.btn.move.delete:hover {
	background-color: #ff8080;
	color: white;
}

.array-btn {
	background-color: white;
	border-style: none;
	border-radius: 10px;
	cursor:pointer;
}
.array-btn:hover {
	font-weight:bold;
	color:rgb(66, 138, 66);
}
</style>

<script type="text/javascript">
	function detail (num){
		window.location.href = "finishDetail?pickNo=" + num;
	}
	function moveList (){
		window.location.href = "list";
	}
	function urgentList (){
		window.location.href = "urgentList";
	}
	function waitList () {
		window.location.href = "waitList";
	}
	function proceedList (){
		window.location.href = "proceedList";
	}	
	function rejectList (){
		window.location.href = "rejectList";
	}
	
	 $(function () {
		 $(".delete").click(function (){
			 if(confirm("정말 삭제하시겠습니까?")){
				 $(this).submit();
			 }else {
				 return false;
			 }
		 });
         $(".long").click(function () {
             var orderBy = "asc"; // 오름차순을 나타내는 값
             sendRequest(orderBy);
         });

         $(".latest").click(function () {
             var orderBy = "desc"; // 내림차순을 나타내는 값
             sendRequest(orderBy);
         });
         function sendRequest(orderBy) {
             $.ajax({
                 url: "/rest/pick/order",
                 method: "post",
                 data: { orderBy: orderBy },
                 success: function (response) {
                	 moment.locale('ko');
                     $("#finish-list-wrapper").empty();
                     var list = "";
                     for(var i = 0; i < response.length; i++){
                    	 var result = response[i];
                    	 var applyDate = moment(result.applyDate).format("MM월DD일 HH:mm"); // moment.js로 날짜 형식 변환
                         var finishDate = moment(result.pickFinishDate).format("MM월DD일 HH:mm"); // moment.js로 날짜 형식 변환
                         
                    	 list += "<tr class='contents-tr'>" +
										"<td><input type='checkbox' name='deletePicks' value='" + result.pickNo + "'></td>" +
										"<td onclick=\"detail('" +result.pickNo + "');\">"+ result.pickNo+"</td>" +
										"<td onclick=\"detail('"+result.pickNo+"');\">" + applyDate + "</td>" + 
										"<td onclick=\"detail('"+result.pickNo+"');\">" + finishDate + "</td>" +
										"<td onclick=\"detail('"+result.pickNo+"');\">"+ result.pickPay.toLocaleString() +" 원</td> " +
									"</tr>";
                     }
                     $("#finish-list-wrapper").html(list);
                 }
             });
         }
     });

</script>

<!-- 이동버튼 구역 -->
<div class="container w-800">
	<button type="button" class="btn move" onclick="moveList();">
		<span class="btn-name">전체 목록 보기</span>
	</button>
	<span>&nbsp;&nbsp;</span>
	<button type="button" class="btn move" onclick="urgentList();">
		<span class="btn-name"><span
			style="color: red; font-size: 15px;">긴급</span> <span>&nbsp;</span>수거대기건</span>
	</button>
	<span>&nbsp;&nbsp;</span>
	<button type="button" class="btn move" onclick="waitList();">
		<span class="btn-name"><span
			style="color: rgb(66, 138, 66); font-size: 15px;">일반</span> <span>&nbsp;</span>수거대기건</span>
	</button>
	<span>&nbsp;&nbsp;</span>
	<button type="button" class="btn move" onclick="proceedList();">
		<span class="btn-name">나의 진행건</span>
	</button>
	<span>&nbsp;&nbsp;</span>
	<button type="button" class="btn move" onclick="rejectList();">
		<span class="btn-name">나의 거부건</span>
	</button>
</div>
<!-- ------------- -->

<form action="finishList" method="post">
	<div class="container pick-container w-800 py-30 px-50 my-50">

		<div class="cell flex-cell pb-10">
			<div class="cell">
				<span style="font-size: 25px; font-weight: bold;">수거 완료건</span>
				<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
				<span style="color: rgb(66,138,66); font-weight:bold;">수거일시</span> 기준으로 정렬됩니다. 
			</div>
			<div class="cell width-fill right pt-10">
				<button type="button" class="latest array-btn" value="desc">최신순</button>
				<button type="button" class="long array-btn" value="asc">오래된순</button>
			</div>
		</div>

		<div class="cell mb-20">
			<table class="table table-horizontal table-hover">
				<thead>
					<tr>
						<th>선택</th>
						<th>수거번호</th>
						<th>신청일시</th>
						<th>수거일시</th>
						<th>수거비용</th>
					</tr>
				</thead>

				 <tbody id="finish-list-wrapper">
					<c:forEach var="finishList" items="${finishList}"> 
						<tr class="contents-tr">
							<td><input type="checkbox" name="deletePicks" value="${finishList.pickNo}"></td>

							<td onclick="detail('${finishList.pickNo}');">${finishList.pickNo}</td>
							<td onclick="detail('${finishList.pickNo}');">
								<fmt:formatDate value="${finishList.applyDate}" pattern="MM월 dd일 HH:mm" />
							</td>
							<td onclick="detail('${finishList.pickNo}');">
								<fmt:formatDate value="${finishList.pickFinishDate}" pattern="MM월 dd일 HH:mm" />
							</td>
							<td onclick="detail('${finishList.pickNo}');"><fmt:formatNumber value="${finishList.pickPay}" pattern="#,##0"/> 원</td>
						</tr>
					</c:forEach>
				</tbody> 
			</table>
		</div>

		<div class="cell right">
			<button type="submit" class="btn move delete"
				style="border-radius: 10px;">
				<span class="btn-name">삭제하기</span>
			</button>
		</div>

		<jsp:include page="/WEB-INF/views/template/pickNavigator.jsp"></jsp:include>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>