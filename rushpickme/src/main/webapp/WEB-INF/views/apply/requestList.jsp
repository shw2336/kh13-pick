<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<div class="container pick-container w-800 py-30 px-50 my-50">
		
		
		
<style>
     .pick-container {
         border-radius: 10px;
         border: 1px solid gainsboro;
         box-shadow: 0px 4px 4px 2px gainsboro;
     }
     
     table > tbody > .contents-tr {
     	cursor: pointer;
     	height: 40px;
     }
</style>		
<script type="text/javascript">
function detail (no){
		window.location.href = "waitDetail?applyNo=" + no;
	}
	
</script>

    <div class="cell flex-cell pb-10">
        <div class="cell">
            <span style="font-size:25px; font-weight:bold;">신청내역 목록 리스트</span>
        </div>
    </div>
    
    <div class="cell">
    <table class="table table-horizontal table-hover">
        <thead>
            <tr>
                <th>신청번호</th>
                <th>주소</th>
                <th>배출봉투</th>
                <th>신청일시</th>
                <th>수거희망일</th>
            </tr>
        </thead>
    
        <tbody>
            <c:forEach var="applyDto" items="${requestList}">
                <tr onclick="detail('${requsetDetail.applyNo}');" class="contents-tr">
                    <td>${applyDto.applyNo}</td>
                    <td>${applyDto.applyAddress1}</td>
                    <td>${applyDto.applyVinyl}</td>
                    <td><fmt:formatDate value="${applyDto.applyDate}"
                    pattern="MM월 dd일" /></td>
                    <td>${applyDto.applyHopeDate}</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    </div>
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>