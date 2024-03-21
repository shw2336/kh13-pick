<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
table>tbody>.contents-tr {
	cursor: pointer;
	height: 40px;
}

.btn.move.delete:hover {
	background-color: #ff8080;
	color: white;
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
                 url: "http://localhost:8080/rest/pick/order",
                 method: "post",
                 data: { orderBy: orderBy },
                 success: function (response) {
                     // 받아온 리스트를 정렬
                     response.sort(function (a, b) {
                         // 오름차순으로 정렬
                         if (orderBy === "asc") {
                             return a.date - b.date;
                         }
                         // 내림차순으로 정렬
                         else if (orderBy === "desc") {
                             return b.date - a.date;
                         }
                     });
                 }
             });
             // 정렬된 리스트를 화면에 출력
             var tbody = $("tbody");
             tbody.empty(); // 기존의 데이터를 모두 지우고 새로운 데이터로 채움
             response.forEach(function (${finishListOrderBy}) {
                 var row = "<tr class='contents-tr'>";
                 row += "<td><input type='checkbox' name='deletePicks' value='" + ${finishListOrderBy.pickNo} + "'></td>";
                 row += "<td onclick='detail(\"" + ${finishListOrderBy.pickNo} + "\");'>" + ${finishListOrderBy.pickNo} + "</td>";
                 row += "<td onclick='detail(\"" + finishListOrderBy.pickNo + "\");'>" + finishListOrderBy.applyDate + "</td>";
                 row += "<td onclick='detail(\"" + finishListOrderBy.pickNo + "\");'>" + finishListOrderBy.pickFinishDate + "</td>";
                 row += "<td onclick='detail(\"" + finishListOrderBy.pickNo + "\");'>" + finishListOrderBy.pickPay + "원</td>";
                 row += "</tr>";
                 tbody.append(row); // 새로운 행을 테이블에 추가
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
<div class="container w-800">
	<button class="latest" value="desc">최신순</button>
	<button class="long" value="asc">오래된순</button>
</div>

<form action="finishList" method="post">
	<div class="container pick-container w-800 py-30 px-50 my-50">

		<div class="cell flex-cell pb-10">
			<div class="cell">
				<span style="font-size: 25px; font-weight: bold;">수거 완료건</span>
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

				<tbody>
					<c:forEach var="finishListOrderBy" items="${finishListOrderBy}">
						<tr class="contents-tr">
							<td><input type="checkbox" name="deletePicks"
								value="${finishListOrderBy.pickNo}"></td>

							<td onclick="detail('${finishListOrderBy.pickNo}');">${finishListOrderBy.pickNo}</td>
							<td onclick="detail('${finishListOrderBy.pickNo}');"><fmt:formatDate
									value="${finishListOrderBy.applyDate}"
									pattern="MM월 dd일 HH시 mm분" /></td>
							<td onclick="detail('${finishListOrderBy.pickNo}');"><fmt:formatDate
									value="${finishListOrderBy.pickFinishDate}"
									pattern="MM월 dd일 HH시 mm분" /></td>
							<td onclick="detail('${finishListOrderBy.pickNo}');">${finishListOrderBy.pickPay}
								원</td>
						</tr>
					</c:forEach>
				</tbody>

				<!-- 				 <tbody> -->
				<%-- 					<c:forEach var="finishList" items="${finishList}">  --%>
				<!-- 					<tr class="contents-tr"> -->
				<%-- 							<td><input type="checkbox" name="deletePicks" value="${finishList.pickNo}"></td> --%>

				<%-- 							<td onclick="detail('${finishList.pickNo}');">${finishList.pickNo}</td> --%>
				<%-- 							<td onclick="detail('${finishList.pickNo}');"> --%>
				<%-- 								<fmt:formatDate value="${finishList.applyDate}" pattern="MM월 dd일 HH시 mm분" /></td> --%>
				<%-- 							<td onclick="detail('${finishList.pickNo}');"> --%>
				<%-- 								<fmt:formatDate value="${finishList.pickFinishDate}" pattern="MM월 dd일 HH시 mm분" /></td> --%>
				<%-- 							<td onclick="detail('${finishList.pickNo}');">${finishList.pickPay} 원</td> --%>
				<!-- 						</tr> -->
				<%-- 					</c:forEach> --%>
				<!-- 				</tbody>  -->
			</table>
		</div>

		<div class="cell right">
			<button type="submit" class="btn move delete"
				style="border-radius: 10px;">
				<span class="btn-name">삭제하기</span>
			</button>
		</div>

		<jsp:include page="/WEB-INF/views/template/navigator.jsp"></jsp:include>
	</div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>