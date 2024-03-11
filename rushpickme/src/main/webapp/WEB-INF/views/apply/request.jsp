<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<body>
<div class="container w-500">
<div class="cell center">
            <h1>수거 신청 페이지</h1>
        </div>
        <div class="cell w-500">
            <h2> 신청 지역 선택 
                <i class="fa-solid fa-truck"></i>
            </h2>
            <select name="apply_area" class="tool w-100" oninput="">
                <option value="">선택하세요</option>
                <option value="강남구">강남구</option>
                <option value="강북구">강북구</option>
                <option value="강서구">강서구</option>
                <option value="관악구">관악구</option>
                <option value="광진구">광진구</option>
                <option value="구로구">구로구</option>
                <option value="금천구">금천구</option>

                <option value="노원구">노원구</option>

                <option value="도봉구">도봉구</option>
                <option value="동대문구">동대문구</option>
                <option value="동작구">동작구</option>

                <option value="마포구">마포구</option>

                <option value="서대문구">서대문구</option>
                <option value="서초구">서초구</option>
                <option value="성동구">성동구</option>
                <option value="성북구">성북구</option>
                <option value="송파구">송파구</option>

                <option value="양천구">양천구</option>
                <option value="영등포구">영등포구</option>
                <option value="용산구">용산구</option>
                <option value="은평구">은평구</option>

                <option value="종로구">종로구</option>
                <option value="중구">중구</option>
                <option value="중랑구">중랑구</option>
            </select>
            <div class="fail-feedback">반드시 지역을 선택하세요 </div>
        </div>
<div class="cell w-500">
       <h2>주소
       <i class="fa-regular fa-address-book"></i>
       </h2>
        <div class="cell flex-cell">
            <input type="text" class= "tool w-80" name="applyPost" placeholder="우편번호">
            <button type="button" class="btn-address-search tool w-100">우편번호 찾기</button><br>
        </div>
        <input type="text" name="applyAddress1" class="tool w-100" placeholder="주소"><br>
        <input type="text" name="applyAddress2" class="tool w-100" placeholder="상세 주소">
    </div>
    <div class="cell">
        <h2> 예상 무게 </h2>
        <input value="0 kg"  class="tool w-100" required > <br>
        <label>일반쓰레기 한 봉지(10L) 당 약5kg정도 입니다.</label>
    
    </div>
    <div class="cell">
        <h2> 봉투개수 <i class="fa-solid fa-sack-xmark"></i></h2>
        
        <input type="number" value="3" class="tool w-100" required>
    </div>
    <div class="cell">
        <h2> 보유 포인트 </h2>
        <input type="number" class="tool w-100" name="memberGreenPoint"  value="${memberGreenDto.memberGreenPoint}">
    </div>
    <div class="cell">
        <h2> 수거 희망 날짜 <i class="fa-solid fa-calendar-check"></i></h2>
        <input type="date" name="applyHopeDate" class="tool w-500" oninput="checkApplyHopeDate();">
    </div>
    <div class="cell">
        <h2> 배출 사진 첨부 파일 <i class="fa-regular fa-images"></i></h2>
        <input type="file" name="applyAttach" class="tool w-500" >
        <button class="btn w-100">첨부</button>
    </div>
    <div class="cell">
        <h2>남기실 말 <i class="fa-solid fa-pen"></i></h2>
        <textarea type="text" name="applySay" class="tool w-100"></textarea>
    </div>
    <div class="cell">
        <button class="btn w-100"> 수거 요청하기 </button>
    </div>
    </div>
</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>