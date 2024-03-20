<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<style>
    .container {
        border-radius: 30px;
        border: 2px solid gainsboro;
        box-shadow: 0px 4px 4px 2px gainsboro;
        padding: 50px;
    }


    .title-icon {
        margin-top: 30px;
        margin-bottom: 30px;
        color: rgb(254, 210, 61);
    }

    .btn {
        color: #2d3436;
        text-decoration: none;
        display: inline-block;
        text-align: center;
        cursor: pointer;
        border: none;
        background-color: rgb(255, 128, 128);
    }
</style>


<form action="add" method="post" autocomplete="off" enctype="multipart/form-data" class="check-form">
    <div class="container w-800">
        <div class="cell center">
            <h1>포인트 등록 <img src="/image/notebook.png" style="width:50px;" class="ps-10"></h1>
        </div>

        <div>
            <label>상품명</label> <input type="text" class="tool w-100" placeholder="상품명" name="pointName">
            <div class="fail-feedback">이름을 작성하세요</div>
        </div>
        <div>
            <label>판매가</label> <input type="text" class="tool w-100" placeholder="판매가격" name="pointSell">
            <div class="fail-feedback">가격을 작성하세요</div>
        </div>
        <div>
            <label>포인트</label> <input type="text" class="tool w-100" placeholder="포인트" name="pointCharge">
            <div class="fail-feedback">포인트를 작성하세요</div>
        </div>
        <div class="cell">
            <label>이미지</label> <input type="file" name="attach" class="tool w-100">
        </div>
        <div class="cell my-30">
            <button type="submit" class="btn w-100">등록</button>
        </div>
    </div>
</form>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
</script>
