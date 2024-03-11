<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
        .urgent {
            font-size: 13px;
        }
</style>
    
<script type="text/javascript">

</script>



   <div class="cell">
        <h1> hyedni 피커 님</h1>
        <h2> 근무지는 <span style="color:blue">영등포구</span> 입니다.</h2>
    </div>
    
    <div class="container pick-container w-700 p-20">

        <div class="cell flex-cell list-box">
            <h2>수거대기</h2>
            <h5 class="right width-fill pt-10"><a href="https://www.naver.com" class="link">전체보기+</a></h3>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-exclamation fa-2x"  style="color:darkgreen"></i></th>
                    <td style="width:70%;" class="left"><h3>수거접수 대기 </h3></td>
                    <td class="center"><h3><span>0</span>건</h3></td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-exclamation fa-2x" style="color:red"></i></span></th>
                    <td style="width:70%;" class="left"><h3>수거신청 6시간 이상 경과</h3></td>
                    <td class="center"><h3><span>0</span>건</h3></td>
                </tr>
            </tbody>
        </table>
    </div>
    <br><br>

    <div class="container pick-container w-700 p-20">
        <div class="cell flex-cell list-box">
            <h2>수거진행</h2>
            <h5 class="right width-fill pt-10">전체보기+</h3>
        </div>

        <table class="table">
            <thead>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-check fa-2x"  style="color:darkgreen"></i></th>
                    <td style="width:70%;" class="left"><h3>진행 중 </h3></td>
                    <td class="center"><h3><span>0</span>건</h3></td>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <th style="width:20%;"><i class="fa-solid fa-circle-xmark fa-2x" style="color:red"></i></span></th>
                    <td style="width:70%;" class="left"><h3>수거 거부</h3></td>
                    <td class="center"><h3><span>0</span>건</h3></td>
                </tr>
            </tbody>
        </table>
    </div>
    <br><br>

    <div class="container pick-container w-700 p-20">
        <div class="cell flex-cell list-box">
            <h2>수거완료</h2>
            <h5 class="right width-fill pt-10">전체보기+</h3>
        </div>
        <div class="cell">
            <h3>리스트</h3>
            <h3>리스트</h3>
            <h3>리스트</h3>
        </div>
    </div>
