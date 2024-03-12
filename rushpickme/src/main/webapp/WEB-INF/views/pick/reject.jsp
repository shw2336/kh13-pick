<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> --%>
<%-- <%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> --%>
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
    .reject-btn {
        border-radius: 10px !important;
    }

    .sub-text {
        color: gray;
        font-size: 15px;
    }

    .selected-btn {
        background-color: lightblue;
    }

    .btn.success {
        border-color: green !important;
    }

    .btn.fail {
        border-color: red;
    }

    .btn.success~.success-feedback,
    .btn.fail~.fail-feedback {
        display: block;
    }
</style>
    
 <script type="text/javascript">

     $(function () {

         $(document).on("click", ".comment-btn", function () {
             $(this).addClass("selected-btn");
             $(".reject-btn").not(this).removeClass("selected-btn");
             $(this).next("#reject-comment-wrapper").remove();
         });
         var textareaAdded = false;
         $(".etc-btn").click(function () {
             $(this).addClass("selected-btn");
             $(".reject-btn").not(this).removeClass("selected-btn");
             if (!textareaAdded) {
                 var templateText = $("#reject-comment-wrapper").text();
                 var templateHtml = $.parseHTML(templateText);
                 $(this).after(templateHtml);
                 textareaAdded = true; // textarea가 추가되었다고 표시
             }
         });

         $(".check-form").submit(function () {
             var length = $(".selected-btn").length;
             $(".submit-btn").removeClass("success fail").addClass(length > 0 ? "success" : "fail");
             return false; //안넘어가게 해놓은 상태
         });
     });

 </script>

 <script type="text/template" id="reject-comment-wrapper">
        <div class="cell center">
            <textarea  name="pickReject" class="tool w-75 reject-comment" 
                style="font-size: 13px; min-height: 100px; max-height: 100px; text-align: left;" placeholder="수거거부 사유를 입력 해 주세요 (100자 이내)">
            </textarea>
        </div>
</script>

<form action="reject" method="post" autocomplete="off" class="check-form">

        <div class="container w-500" style="padding-top: 80px">

            <div class="cell center">
                <h2>거부 사유를 선택 해 주세요.</h2>
            </div>

            <div class="cell center pb-10">
                <button type="button" class="btn reject-btn comment-btn w-75" name="pickReject">대형폐기물 포함<span
                        class="sub-text">
                        (유모차, 캐리어
                        등)</span></button>
            </div>

            <div class="cell center pb-10">
                <button type="button" class="btn reject-btn comment-btn w-75" name="pickReject">공업용품 포함<span
                        class="sub-text"> (시멘트,
                        페인트
                        등)</span></button>
            </div>

            <div class="cell center pb-10">
                <button type="button" class="btn reject-btn comment-btn w-75" name="pickReject">봉투 미사용</button>
            </div>
            <div class="cell center pb-10">
                <button type="button" class="btn reject-btn etc-btn w-75"
                    name="pickReject">기&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp타</button>
            </div>


            <div class="cell reject-comment-wrapper">
            </div>
            <br>
            
            <div class="cell center">
                <button type="submit" class="btn submit-btn w-75" style="border-radius: 10px;">등록하기</button>
                <div class="fail-feedback">사유를 선택하세요.</div>
            </div>

        </div>
    </form>
    
    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>