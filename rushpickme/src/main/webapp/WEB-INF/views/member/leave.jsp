<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>



<style>
.button---container!important {
	display: flex;
	justify-content: space-between;
	margin-top: 100px;
}

.button---container::before, .button---container::after {
	content: "";
	flex-grow: 1;
}

.button---container button {
	width: calc(17% - 5px);
}

* !important {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

div !important {
  position: relative;
  width: 300px;
  margin-left: 50px;
  margin-top: 100px;
}

input {
  font-size: 15px;
  color: #222222;
  width: 300px;
  border: none;
  border-bottom: solid #aaaaaa 1px;
  padding-bottom: 10px;
  text-align: center;
  position: relative;
  background: none;
  z-index: 5;
}

input::placeholder { color: #aaaaaa; }
input:focus { outline: none; }

span  {
  display: block;
  position: absolute;
  bottom: 0;
  left: 50%;  /* right로만 바꿔주면 오 - 왼 */
  background-color: #666;
  width: 0;
  height: 2px;
  border-radius: 2px;
  transform: translateX(-50%);
  transition: 0.5s;
}

label  {
position: absolute;
color: #aaa;
left: 50%;
transform: translateX(-50%);
font-size: 20px;
bottom: 8px;
transition: all .2s;
}

input:focus ~ label, input:valid ~ label {
font-size: 16px;
bottom: 40px;
color: #666;
font-weight: bold;
}

input:focus ~ span, input:valid ~ span {
width: 100%;
}




</style>


<div class="container w-1200">
	<div class="cell center">
		<h1>회원탈퇴</h1>
	</div>

	

	<div><form action="leave" method="post" autocomplete="off"></div>
		<div class="cell center">
		           ${memberDto.memberName}님의
			       ${memberDto.memberId} 계정을 삭제 합니다
			       </div>
			       <div class="cell center">
			       <h5>	탈퇴를 위해 비밀번호를 한번 더 입력 해주세요</h5>
			       <br>
			       <br>
			        </div>
					<div class="cell center">
    				<input name="memberPw" type="password" required>
    						<label>비밀번호</label>
    						<span></span>
					</div>



          <div class="button---container center">
	    <button class="btn negative" type="submit">확인</button>
        </form>
	  
      </div>
      
      <c:if test="${param.error != null}">
	<div class="cell center">
		<h3 style="color:red">비밀번호가 일치하지 않습니다</h3>
	</div>
	</c:if>
   
</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>