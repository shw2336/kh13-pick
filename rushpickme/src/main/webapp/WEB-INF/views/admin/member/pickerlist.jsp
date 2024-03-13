<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <jsp:include page ="/WEB-INF/views/template/header.jsp"></jsp:include>
    
<script type="text/javascript">
        $(function(){
            var state = {
                pickerNameValid: false,
                ok: function() {
                    return this.pickerNameValid;
                }
            };

            $(".check-form").submit(function(){
                $(this).find("[name]").blur();
                console.table(state);
                return state.ok();
            });

            $("[name=pickerName]").blur(function(){
                var regex = /^[가-힣]+$/;
                var inputValue = $(this).val();
                state.pickerNameValid = inputValue.includes("피커") && regex.test(inputValue);
                $(this).removeClass("success fail")
                        .addClass(state.pickerNameValid ? "success" : "fail");
            });

            $(".check-form").submit(function(){
                if(state.ok()) {
                    alert("등록이 완료되었습니다!");
                } else {
                    alert("피커로 시작하는 이름을 입력하세요.");
                }
                return state.ok();
            });
        });
    </script>
</head>
<body>
    <form action="?" method="post" autocomplete="off" class="check-form" style="margin-top: 20;">
        <div class="container w-500">
            <div class="cell center mt-20">
                <img src="image/picker.png">
            </div>
            <div class="cell center mt-20">
                <label>
                </label>
                <div class="cell">
                    피커의 성함을 넣어주세요!
                </div>
                <input type="text" name="pickerName" placeholder="(ex)피커지혜" class="tool w-50" style="border-radius: 8px;">
                <div class="fail-feedback mt-20">피커로 시작하는 이름을 입력하세요.</div>
            </div>  
            <div class="cell center">
                <button class="btn positive w-25 mt-20" style="background-color: rgb(255, 128, 128); border-radius: 8px; ">
                    <i class="fa-solid fa=fa-floppy-disk"></i>
                    등록
                </button>
            </div>
        </div>
    </form>
</body>
</html>

    
    <jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>