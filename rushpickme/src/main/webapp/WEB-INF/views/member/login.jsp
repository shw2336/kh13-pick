<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>


<script>   
   $(document).ready(function(){
      // 저장된 쿠키값을 가져와서 ID 칸에 넣어준다. 없으면 공백으로 들어감.
       var key = getCookie("key");
       $("#id").val(key); 
        
       // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
       if($("#id").val() != ""){ 
           $("#checkId").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
       }
        
       $("#checkId").change(function(){ // 체크박스에 변화가 있다면,
           if($("#checkId").is(":checked")){ // ID 저장하기 체크했을 때,
               setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
           }else{ // ID 저장하기 체크 해제 시,
               deleteCookie("key");
           }
       });
        
       // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
       $("#id").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
           if($("#checkId").is(":checked")){ // ID 저장하기를 체크한 상태라면,
               setCookie("key", $("#id").val(), 7); // 7일 동안 쿠키 보관
           }
       });

   // 쿠키 저장하기 
   // setCookie => saveid함수에서 넘겨준 시간이 현재시간과 비교해서 쿠키를 생성하고 지워주는 역할
   function setCookie(cookieName, value, exdays) {
      var exdate = new Date();
      exdate.setDate(exdate.getDate() + exdays);
      var cookieValue = escape(value)
            + ((exdays == null) ? "" : "; expires=" + exdate.toGMTString());
      document.cookie = cookieName + "=" + cookieValue;
   }

   // 쿠키 삭제
   function deleteCookie(cookieName) {
      var expireDate = new Date();
      expireDate.setDate(expireDate.getDate() - 1);
      document.cookie = cookieName + "= " + "; expires="
            + expireDate.toGMTString();
   }
     
   // 쿠키 가져오기
   function getCookie(cookieName) {
      cookieName = cookieName + '=';
      var cookieData = document.cookie;
      var start = cookieData.indexOf(cookieName);
      var cookieValue = '';
      if (start != -1) { // 쿠키가 존재하면
         start += cookieName.length;
         var end = cookieData.indexOf(';', start);
         if (end == -1) // 쿠키 값의 마지막 위치 인덱스 번호 설정 
            end = cookieData.length;
                console.log("end위치  : " + end);
         cookieValue = cookieData.substring(start, end);
      }
      return unescape(cookieValue);
   }
</script>



<style>
* {
   padding: 0;
   margin: 0;
   border: none;
}

body {
   font-size: 14px;
   font-family: 'Roboto', sans-serif;
}

.login-wrapper {
   width: 400px;
   height: 350px;
   padding: 40px;
   box-sizing: border-box;
}

.login-wrapper>h2 {
   font-size: 24px;
   color: rgb(255, 128, 128);
   margin-bottom: 20px;
}

#login-form>input {
   width: 100%;
   height: 48px;
   padding: 0 10px;
   box-sizing: border-box;
   margin-bottom: 16px;
   border-radius: 6px;
   background-color: #F8F8F8;
}

#login-form>input::placeholder {
   color: #D2D2D2;
}

#login-form>input[type="submit"] {
   color: #fff;
   font-size: 16px;
   background-color: rgb(255, 128, 128);
   margin-top: 20px;
}

#login-form>input[type="checkbox"] {
   display: none;
}

#login-form>label {
   color: #999999;
}

#login-form input[type="checkbox"]+label {
   cursor: pointer;
   padding-left: 26px;
   background-image: url("checkbox.png");
   background-repeat: no-repeat;
   background-size: contain;
}

#login-form input[type="checkbox"]:checked+label {
   background-image: url("checkbox-active.png");
   background-repeat: no-repeat;
   background-size: contain;
}
</style>

<script type="text/javascript">

document.addEventListener("DOMContentLoaded", function() {
    var checkIdCheckbox = document.getElementById("checkId");
    var memberIdInput = document.querySelector('input[name="memberId"]');

    // 체크 박스 상태에 따라 아이디 저장 기능 활성화/비활성화
    checkIdCheckbox.addEventListener("change", function() {
        if (this.checked) {
            // 아이디 저장하기 체크되어 있으면 아이디를 로컬 스토리지에 저장
            localStorage.setItem("savedMemberId", memberIdInput.value);
        } else {
            // 아이디 저장하기 체크가 해제되면 로컬 스토리지에서 아이디 제거
            localStorage.removeItem("savedMemberId");
        }
    });

    // 페이지 로드 시 저장된 아이디가 있는지 확인하여 입력란에 채워넣기
    var savedMemberId = localStorage.getItem("savedMemberId");
    if (savedMemberId) {
        memberIdInput.value = savedMemberId;
        checkIdCheckbox.checked = true;
    }
});

</script>




<!-- 카카오 스크립트 -->
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>
Kakao.init('11e00e403ddfc96c6d0d625a91bbb915'); //발급받은 키 중 javascript키를 사용해준다.
console.log(Kakao.isInitialized()); // sdk초기화여부판단
//카카오로그인
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
             console.log(response)
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
//카카오로그아웃  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
           console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }  
</script>




<body>
   <div class="container w-1200 " align="center">
      <div class="login-wrapper ">
         <h2>Rush</h2>
         <form method="post" action="/member/login" id="login-form">
            <input type="text" name="memberId" placeholder="ID" > 
            <input type="password" name="memberPw" placeholder="Password">
            <label for="checkId">
             <input name="checkId" type="checkbox" id="checkId">아이디 저장하기
            </label> <br>
            <br>
            <p class="findId">
               아이디 <a class="link" href="/member/findId">찾기</a>
            </p>
            <br>

            <p class="findPw">
               비밀번호 <a class="link" href="/member/findPw">찾기</a>
            </p>
            <br>


            <p class="signUp">
               아직 계정이 없으신가요? <a class="link" href="/member/signUp">회원가입</a>
            </p>
            <br>
            <input type="submit" value="Login" id="loginbtn">
            
            
    
</div>
            
            
            
            
            
            
<!--                      <ul> -->
<!--                   <li onclick="kakaoLogin();"> -->
<!--                   <a href="javascript:void(0)"> -->
<!--                    <span>카카오 로그인</span> -->
<!--                      </a> -->
<!--                   </li> -->
<!--                <li onclick="kakaoLogout();"> -->
<!--                   <a href="javascript:void(0)"> -->
<!--                       <span>카카오 로그아웃</span> -->
<!--                      </a> -->
<!--                   </li> -->
<!--                </ul> -->
            
         </form>
            <div class="container" style="display: flex; justify-content: center; align-content: center; align-items: center; flex-direction: column; margin: 200px auto; ">
    <h1>카카오 로그인</h1>
    
        <button onclick="location.href='https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=45195e1ea2c23c3134d7c20011096ff7&redirect_uri=http://localhost:8080/auth/kakao/callback'" style="height: 60px; width: 120px; background-color: #FEE500; cursor: pointer;">카카오 로그인</button>
      </div>
</body>
</div>

</div>
</div>
</div>
<c:if test="${param.error != null}">
   <div class="cell center">
   <br>
      <h3 style="color: red">로그인 정보가 일치하지 않습니다</h3>
   </div>
</c:if>
</div>
</body>

