<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
        .pick-container {
            border-radius: 10px;
            border: 1px solid gainsboro;
            box-shadow: 0px 4px 4px 2px gainsboro;
        }
        .list-box {
            border-bottom: 1px solid #2d3436;
        }
 
        .num {
        	font-size: 20px;
        }
        .explain {
        	font-size: 20px;
        	font-weight: bold;
        }
        .table > thead > tr > th,
		.table > thead > tr > td,
		.table > tbody > tr > th,
		.table > tbody > tr > td,
		.table > tfoot > tr > th,
		.table > tfoot > tr > td
		{
		    padding: 0.75em;
		}
</style>
    
<script type="text/javascript">

</script>


   <div class="cell">
        <h1> ${sessionScope.loginId} 님</h1>
        <h2> 근무지는 <span style="color:blue">영등포구</span> 입니다.</h2>
    </div>
    
    <div class="container pick-container w-700 p-20">

        <div class="cell flex-cell list-box">
            <h2>수거대기</h2>
            <h5 class="right width-fill pt-10"><a href="#" class="link">전체보기+</a></h3>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-exclamation fa-2x"  style="color:darkgreen"></i></th>
                    <td style="width:70%;" class="left explain">수거접수 대기</td>
                    <td class="center"><span class="num">${countApply}</span>건</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-exclamation fa-2x" style="color:red"></i></span></th>
                    <td style="width:70%;" class="left explain">수거신청 6시간 이상 경과</td>
                    <td class="center"><span class="num">${countUrgentApply}</span>건</td>
                </tr>
            </tbody>
        </table>
    </div>
    <br><br>

    <div class="container pick-container w-700 p-20">
        <div class="cell flex-cell list-box">
            <h2>수거진행</h2>
            <h5 class="right width-fill pt-10"><a href="#" class="link">전체보기+</a></h3>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-check fa-2x"  style="color:darkgreen"></i></th>
                    <td style="width:70%;" class="left explain">진행 중</td>
                    <td class="center"><span class="num">${countProceed}</span>건</td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-xmark fa-2x" style="color:red"></i></span></th>
                    <td style="width:70%;" class="left explain">수거 거부</td>
                    <td class="center"><span class="num">${countReject}</span>건</td>
                </tr>
            </tbody>
        </table>
    </div>
    <br><br>

    <div class="container pick-container w-700 p-20">
        <div class="cell flex-cell list-box">
            <h2>수거완료</h2> &nbsp;
            <h5 class=" width-fill pt-10"> (최근 5건) </h5>
            <h5 class="right width-fill pt-10"><a href="#" class="link">전체보기+</a></h5>
        </div>
        
        <table class="table table-horizontal">
            <thead>
            	<tr>
	            	<th>수거번호</th>
	            	<th>신청일시</th>
	            	<th>수거일시</th>
	            	<th>수거비용</th>
            	</tr>
            </thead>
            
            <tbody>
         	<c:forEach var="voList" items="${voList}">
            	<tr>
            		<td>${voList.pickNo}</td>
            		<td><fmt:formatDate value="${voList.applyDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            		<td><fmt:formatDate value="${voList.pickFinishDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
            		<td>${voList.pickPay}</td>
            	</tr>
            </c:forEach>
            </tbody>
        </table>
        
    </div>
    <br><br>
    
<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
    
