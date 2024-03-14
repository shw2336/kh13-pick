<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
         .apply-container {
            border-radius: 30px;
            border: 2px solid gainsboro;
            box-shadow: 0px 4px 4px 2px gainsboro;
            padding: 50px;

        }
</style>

   <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
        //우편 번호 선택 
        $(function () {
            $(".btn-address-search").click(function () {
                new daum.Postcode({
                    oncomplete: function (data) {
                        // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                        var addr = ''; // 주소 변수
                        var extraAddr = ''; // 참고항목 변수

                        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                            addr = data.roadAddress;
                        } else { // 사용자가 지번 주소를 선택했을 경우(J)
                            addr = data.jibunAddress;
                        }

                        // 우편번호와 주소 정보를 해당 필드에 넣는다.
                        $("[name=applyPost]").val(data.zonecode);
                        $("[name=applyAddress1]").val(addr);

                        // 커서를 상세주소 필드로 이동한다.
                        $("[name=applyAddress2]").focus();

                    }
                }).open();
            });
            $(".btn-address-clear").click(function () {
                $("[name=applyPost]").val("");
                $("[name=applyAddress1]").val("");
                $("[name=applyAddress2]").val("");
            });
        });

      //  function checkApplyHopeDate() {
            //select는 option이 있지만 select 자체로 제어하도록 권장
        //    var inputTarget = document.querySelector("[name=applyHopeDate]");


            //날짜 검사
       //     var regex = /^(19[0-9]{2}|20[0-9]{2})-(02-(0[1-9]|1[0-9]|2[0-8])|(0[469]|11)-(0[1-9]|1[0-9]|2[0-9]|30)|(0[13578]|1[02])-(0[1-9]|1[0-9]|2[0-9]|3[01]))$/;
        //    var isValid = regex.test(inputTarget.value);

     //      inputTarget.classList.remove("success", "fail");
       //     inputTarget.classList.add(isValid ? "success" : "fail");
        //    return isValid;
     //   }
        //보유포인트 가져오기 


        //배출사진 



        //남길 말 넘기기 
        
        
     //수거 신청 버튼 후 메인페이지(러쉬픽미) 로 넘어가기 
        function mainPage(){
        	var choice = confirm("정말 신청하시겠습니까?");
        	if(choice){
        		window.open("http://localhost:8080/","RushPickMe","width500,height=500");
        	}
        }
        
        
        
         

</script>
<body>
 	<div class="container apply-container w-650 mt-50 mb-50">
 	<input type="hidden" value="신청완료" type="text" name="applyState" class="tool w-100">
        <div class="container w-500">
            <div class="cell center">
            
                <h1>수거 신청 페이지</h1>
                
                
            </div>
            <div class="cell w-500 ">
                <h2> 신청 지역 선택
                    <i class="fa-solid fa-truck"></i>
                </h2>
				<form action="request" method="post" autocomplete="off" enctype="multipart/form-data">
                <select name="applyArea" class="tool w-100"  oninput="areaData()">
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
              <div class="fail-feedback">반드시 지역을 선택해야합니다 </div>
          <!--<input value="" type="text" name="applyArea" placeholder="반드시 지역을 선택하세요" id="applyAreaData"
                    class="tool w-100 fail-feedback" readonly>  -->
            </div> 



            <div class="cell w-500">
                <h2>주소
                    <i class="fa-regular fa-address-book"></i>
                </h2>
                <div class="cell flex-cell">
                    <input type="text" class="tool " name="applyPost" placeholder="우편번호" readonly>
                    <button type="button" class="btn btn-address-search tool w-70"><i
                            class="fa-solid fa-magnifying-glass"></i></button><br>
                    <button type="button" class="btn negative btn-address-clear tool w-70"><i
                            class="fa-solid fa-xmark"></i></button>
                </div>
                <input type="text" name="applyAddress1" class="tool w-100" placeholder="주소" readonly><br>
                <input type="text" name="applyAddress2" class="tool w-100" placeholder="상세 주소">
                <div class="fail-feedback">주소를 모두 작성하세요 </div>
            </div>
            
            
            <div class="cell w-500">
                <h2> 예상 무게 </h2>
                <input value="" placeholder="ex) 5" name="applyWeight" class="tool w-100" required> <br>
                <label>일반쓰레기 한 봉지(10L) 당 약5kg정도 입니다.</label>
            </div>
            
            
            <div class="cell w-500">
                <h2> 봉투개수 <i class="fa-solid fa-sack-xmark"></i></h2>
                <input type="number"  name="applyVinyl" value="1" class="tool w-100" required>
            </div>
            <%-- <div class="cell">
                <h2> 보유 포인트 </h2>
                <input type="number" class="tool w-100" name="" value="${membergreenDto.memberGreenPoint}">
            </div> --%>
            
            
            <div class="cell w-500">
                <h2> 수거 희망 날짜 <i class="fa-solid fa-calendar-check"></i></h2>
                <input type="date" name="applyHopeDate" class="tool w-500" oninput="" required>
                <div class="fail-feedback">잘못된 날짜 형식입니다</div>
            </div>
            
            
            <div class="cell w-500">
                <h2> 배출 사진 첨부 파일 <i class="fa-regular fa-images"></i></h2>
                <input name="applyAttach" type="file" class="tool w-500" required>
                <button type="button" class="btn w-100">첨부</button>
            </div>
            
            
            <div class="cell w-500">
                <h2>남기실 말 <i class="fa-solid fa-pen"></i></h2>
                <input type="text" name="applySay" class="tool w-100" required>
            </div>
            
            <div class="cell w-500">
                <h2>출입 방법  <i class="fa-solid fa-pen"></i></h2>
                <input type="text" name="applyWay" class="tool w-100" placeholder="전화하기 또는 세대호출 입력" required>
                <br><br>
                <button type="submit" class="btn negative w-100" > 수거신청 취소하기 </button>
            </div>
            </div>
            
        	</div>
        </div>
    </form>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>