<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>

<style>
.detail-tool {
	font-size: 20px;
	padding: 0.5em 1em;
	outline: none;
	border-top: none;
	border-left: none;
	border-right: none;
	border-bottom: 1px solid #636e72;
}
.map {
	width: 100%;
	height: 350px;
	border-radius: 10px;
}

</style>

<!-- 카카오지도 API -->
<script type="text/javascript"
src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d667a3facb2ac08f0c7fe4e48bd917e9&libraries=services"></script>

<script type="text/javascript">
	function urgentList () {
		window.location.href = "urgentList";
	}
	function reject (num) {
		window.location.href = "reject?applyNo=" + num;
	}
	function accept (num) {
		window.location.href = "accept?applyNo=" + num;
	}

	$(function () {
		$(".map").hide();
		$(".traffic-info").hide();
		$(".btn-search").click(function () {
			$(".map").toggle();
			$(".traffic-info").toggle();
			var mapContainer = document.querySelector(".map"),
			mapOption = {
				center: new kakao.maps.LatLng(37.5338151, 126.8969784),
				level: 3
			};
			
			map = new kakao.maps.Map(mapContainer, mapOption);
			//전역변수에 할당 (교통정보에서도 map변수 사용하기 위해)
			var keyword = $(".address-input").val();
			if (keyword.trim().length == 0) return;
			
			var geocoder = new kakao.maps.services.Geocoder();

			// 주소로 좌표를 검색합니다
			geocoder.addressSearch(keyword, function (result, status) {

				// 정상적으로 검색이 완료됐으면 
				if (status === kakao.maps.services.Status.OK) {

					var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					// result에서 좌표를 뽑음

					// 결과값으로 받은 위치를 마커로 표시합니다
					var marker = new kakao.maps.Marker({
						map: map,
						position: coords
					});

					// 인포윈도우로 장소에 대한 설명을 표시합니다
					var infowindow = new kakao.maps.InfoWindow({
						content: '<div style="width:150px;text-align:center;padding:6px 0;">수거를 기다려요!</div>'
					});
					infowindow.open(map, marker);

					// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					map.setCenter(coords);					
				}
			});
		});
		
		var isTrafficOn = false;
		$(".traffic-info").click(function(){
			if (!map) return; //map이 생성되지 않았으면 x
			if (!isTrafficOn) {
				// 지도에 교통정보를 표시하도록 지도타입을 추가합니다
				map.addOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);
				isTrafficOn = true;
			}else {
				// 교통정보 지도타입을 제거합니다
				map.removeOverlayMapTypeId(kakao.maps.MapTypeId.TRAFFIC);  
				isTrafficOn = false;
			}		
		});
	});
	
	
</script>

	<div class="cell center" >
		<h1> 
			<span style="color: rgb(66,138,66)">${findApplyDto.memberId}</span> 님의 신청 정보
			<img src="/image/notebook.png" style="width:50px;" class="ps-10">
		</h1>
	</div>

<div class="container pick-container w-600 px-50 pt-10 my-50">

	<div class="cell flex-cell">
			<h2>주소	
				<button class="btn btn-search" style="border-radius:25px">
					<i class="fa solid fa-magnifying-glass"></i>
				</button>
			</h2>	
	<span style="font-size:15px; color:gray; margin-top:30px" class="width-fill right mt-40">돋보기를 누르면 위치를 확인할 수 있어요!</span>
	</div>

	<div class="cell">
		<input class="detail-tool w-100" value="${findApplyDto.applyPost}" readonly> <input
			class="detail-tool w-100 address-input" value="${findApplyDto.applyAddress1}" readonly> <input
			class=" detail-tool w-100" value="${findApplyDto.applyAddress2}" readonly>
	</div>

	<div class="cell map-zone">
		<div class="map"></div>
	</div>
	<div class="cell right">
		<span style="font-size:15px; color:gray; margin-top:30px; cursor:pointer;" class="traffic-info">
			click! 교통정보 함께 보기</span>
	</div>

	<div class="cell mt-40">
		<h2>봉투개수</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyVinyl}" readonly>
	</div>

	<div class="cell mt-40">
		<h2>예상무게</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyWeight}" readonly>
	</div>

	<div class="cell mt-40">
		<h2>수거 희망 날짜</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applyHopeDate}" readonly>
	</div>
	
	<div class="cell mt-40">
		<h2>남기신 말</h2>
		<input class="detail-tool w-100" value="${findApplyDto.applySay}" readonly>
	</div>
	
	<div class="cell mt-40">
		<h2>출입 불가시 이렇게 해 주세요. </h2>
		<input class="detail-tool w-100" style="color: rgb(66,138,66)" value="${findApplyDto.applyWay}" readonly>
		<c:if test="${findApplyDto.applyWay eq '전화하기'}">
			<input class="detail-tool w-100" value="전화번호는 ${memberContact} 입니다." readonly>
		</c:if>
	</div>
	
	<div class="cell mt-40">
		<h2>배출사진</h2>
		<div class="cell">
				<img src="image/apply?applyNo=${findApplyDto.applyNo}" class="image" width="100%">
		</div>
	</div>

	<div class="cell right mb-40">
		<button class="btn move" onclick="urgentList();"><span class="btn-name">돌아가기</span></button>
		<span class="px-10"></span>
		<button class="btn move" onclick="accept('${findApplyDto.applyNo}');"><span class="btn-name">접수하기</span></button>
		<span class="px-10"></span>
		<button class="btn move" onclick="reject('${findApplyDto.applyNo}');"><span class="btn-name">거부하기</span></button>
	</div>

</div>

<jsp:include page="/WEB-INF/views/template/footer.jsp"></jsp:include>
