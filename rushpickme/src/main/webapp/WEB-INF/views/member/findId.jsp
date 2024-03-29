<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
    	
    	
    	
    	<style>
    	
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}

div!important {
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

span {
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

label {
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

.button-container {
	display: flex;
	justify-content: space-between;
	margin-top: 100px;  
}

.button-container::before, .button-container::after {
	content: "";
	flex-grow: 1;
}

.button-container button {
	width: calc(100% - 5px); 
}


.detail-tool {
    font-size: 20px;
    padding: 0.5em 1em;
    outline: none;
    border-top: none;
    border-left: none;
    border-right: none;
    border-bottom: 1px solid #636e72;
}


</style>





<body>
	<div class="container pick-container w-700 p-20 mb-50">
		<div class="cell center">
			<h2 >아이디 찾기</h2>
			<br><br><br><br>
			<form action="findId" method="post">
				<input class="detail-tool" type="text" name="memberNick" placeholder="닉네임을 입력 해주세요"
					required>
				<div>
					<br><br>
					<button class="btn submit" type="submit">찾기</button>
			</form>
		</div>
	</div>
	</div>
</body>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>