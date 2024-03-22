<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

  <style>
    
    body{
  padding: 0;
  margin: 0;
}
div{
  box-sizing: border-box;
}

/* alert badge */
.circle{
  display: inline-block;
  width: 5px;
  height: 5px;
  border-radius: 2.5px;
  background-color: #ff0000;
  position: absolute;
  top: -5px;
  left: 110%;
}

/* 녹색 텍스트 */
.green{
  color: #24855b;
}

.wrap{
  background-color: #F8F8F8;  
}
/* 녹색배경 */
.greenContainer{  
  height: 132px;
  background-color: #24855b;    
  
  display: flex;
  align-items: flex-end;
  padding: 16px;
}

.greenContainer .name{
   font-size: 20px;
  font-weight: bold;
  color: #ffffff;
} 
.greenContainer .modify{
  margin-left: auto;
}

/* 단골상점 , 상품후기 , 적립금 박스 */
.summaryContainer{
  background-color: white;  
  display: flex;  
  padding: 21px 16px;  
  height: 90px;
  margin-bottom: 10px;
}

.summaryContainer .item{
  flex-grow: 1
}
/* 녹색 숫자 */
.summaryContainer .number{
  font-size: 19px;
  font-weight: bold;
  color: #24855b;
}
/* 텍스트 */
.summaryContainer .item > div:nth-child(2){
  font-size: 13px;
}


.shippingStatusContainer{
  padding: 21px 16px;
  background-color: white;
  margin-bottom: 10px;
}

/* 주문/배송조회 타이틀 */
.shippingStatusContainer .title{
  font-size: 16px;
  font-weight: bold;
  margin-bottom: 15px;
}

/* 장바구니 결제완료 배송중 구매확정 [로우] */
.shippingStatusContainer .status{
  display: flex;
  justify-content: space-between;
  margin-bottom: 21px;
}
/* 장바구니 결제완료 배송중 구매확정 [아이템]  */
.shippingStatusContainer .item{
  display: flex;
}

.shippingStatusContainer .number{
  font-size: 31px;
  font-weight: 500;
  text-align: center;
}
.shippingStatusContainer .text{
  font-size: 17px;
  font-weight: normal;
  color: #c2c2c2;
  text-align: center;
}
.shippingStatusContainer .icon{
  display: flex;
  align-items: center;
  padding: 20px;
  width: 16px;
  height: 16px;
}


/*=================== 주문목록 ~ 찜한상품 리스트 ==================*/
.listContainer{  
  padding: 0;
  background-color: #ffffff;
  margin-bottom: 10px;
}
.listContainer .item{  
  display: flex;
  align-items: center;
  padding: 16px;
  color: black;
  text-decoration: none;  
  height: 56px;
  box-sizing: border-box;
}
.listContainer .icon{  
  margin-right: 14px;
}
.listContainer .text{
  font-size:16px;
  position: relative;
}
.listContainer .right{
  margin-left: auto;
}



.listContainer .smallLight{
  font-size: 14px;
  color: #c2c2c2;  
}
.listContainer .smallLight > span{
  margin-left: 11px;
}

.listContainer .right .blct{
  font-size: 14px;
  font-weight: bold;
  margin-right: 5px;
}



/* 공지사항 이용안내 고객센터 */
.infoContainer{
  background-color: white; 
  display: flex;
  height: 100px;
  margin-bottom: 10px;    
}

.infoContainer .item{
  flex-grow: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  flex-direction: column;
  font-size: 13px;
  text-decoration: none;
  color: black;
}
.infoContainer .item > div:first-child{
  margin-bottom: 2px;
}



/*  */
.listContainer .item:hover{
/*   background-color: #f8f8f8; */
}
.infoContainer .item:hover{
/*   background-color: #f8f8f8; */
}
    
       
    </style>





 <script type="text/javascript">
        
    </script>


<body>
  
  <div class="wrap">
  <div class="greenContainer">
    <div>
      <div class="grade">${memberDto.memberType}</div>
      <div class="name">${memberDto.memberNick}님 환영 합니다!</div>
    </div>    
    <div class="modify"><img src="image" width="100" height="100"></div>    
  </div>
  <div class="summaryContainer">
    <div class="item">
        <div class="number">${memberDto.memberName}</div>
        <div>이름</div>
      </div>
      <div class="item">
        <div class="number">${memberDto.memberContact}</div>
        <div>연락처</div>
      </div>
      <div class="item">
        <div class="number">${memberPickDto.memberPickArea}</div>
        
        <div>근무지</div>
      </div>
  </div>  
  <div class="shippingStatusContainer">
    <div class="title">
      나의 수거현황
    </div>
    <div class="status">
      
      <div class="item">
        <div>
          <div class="green number"></div>
          <div class="text">진행</div>
        </div>
        <div class="icon">${countProcess} > </div>
      </div>     
      <div class="item">
        <div>
          <div class="number"></div>
          <div class="text">거부</div>
        </div>
        <div class="icon">${countReject} > </div>
      </div>     
      <div class="item">
        <div>
          <div class="green number"></div>
          <div class="text">완료</div>
        </div>
        <div class="icon">${countFinish} > </div>
      </div>     
      
      
    </div>
    
  </div>  
  <div class="listContainer">
    
    
    <a href="/pick/waitList" class="item">
        <div class="icon">ii</div>
        <div class="text">대기리스트</div>
        <div class="right"> > </div>
    </a>  
    
    <a href="/pick/proceedList" class="item">
        <div class="icon">ii</div>
        <div class="text">진행리스트</div>
        <div class="right"> > </div>
    </a>  
    
    <a href="/pick/finishList" class="item">
        <div class="icon">ii</div>
        <div class="text">완료리스트</div>
        <div class="right"> > </div>
    </a>
    
    <a href="/pick/list" class="item">
        <div class="icon">ii</div>
        <div class="text">전체현황</div>
        <div class="right"> > </div>
    </a>    
  
  </div>
  <div class="listContainer">
   
    
  
    
    <a href="/member/leave" class="item">
        <div class="icon">ii</div>
        <div class="text">회원탈퇴</div>
        <div class="right"> > </div>
    </a>
    <a href="/member/changeAccountPick" class="item">
        <div class="icon">ii</div>
        <div class="text">개인정보변경</div>
        <div class="right"> > </div>
    </a>      
  </div>
  <div class="infoContainer">
    <a href="#" class="item">
      <div>icon</div>
      <div>공지사항</div>
    </a>    
    <a href="#" class="item">
      <div>icos</div>
      <div>이용안내</div>
    </a>    
    <a href="#" class="item">
      <div>icon</div>
      <div>고객센터</div>
    </a>
  </div>
</div>

</body>



<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>