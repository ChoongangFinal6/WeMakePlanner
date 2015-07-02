<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="aa.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<c:url value="/resources/css/map.css" />" rel="stylesheet">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=90890f0c035d0a05ca5915f1e0ca7195&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		var locX = $("#locX").val();
		var locY = $("#locY").val();
		if (locX == "" || locY == "" || locX == 0 || locY == 0) {
			locX = 37.49586416184341;
			locY = 127.02920943791224;
		}

		var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
		mapOption = {
			center : new daum.maps.LatLng(locX, locY), // 지도의 중심좌표
			level : 5
		// 지도의 확대 레벨
		};

		var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new daum.maps.Marker({
			// 지도 중심좌표에 마커를 생성합니다 
			position : map.getCenter()
		});
		// 지도에 마커를 표시합니다
		marker.setMap(map);

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		var resultDiv = document.getElementById('clickLatlng');
		var infowindow = new daum.maps.InfoWindow({zindex:1});
		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new daum.maps.services.Geocoder();
		
		searchAddrFromCoords(map.getCenter(), displayInfo);
		
		function searchAddrFromCoords(coords, callback) {
		    // 좌표로 주소 정보를 요청합니다
		    geocoder.coord2addr(coords, callback);         
		}

		function displayInfo(status, result) {
		    if (status === daum.maps.services.Status.OK) {
		    	$('#addr').append(result[0].fullName);
		    }    
		}
		function panTo() {
			// 이동할 위도 경도 위치를 생성합니다
			var moveLatLon = new daum.maps.LatLng($("#locX").val(), $("#locY")
					.val());

			// 지도 중심을 부드럽게 이동시킵니다
			// 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
			map.panTo(moveLatLon);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(status, result) {
		    if (status === daum.maps.services.Status.OK) {
		        var infoDiv = document.getElementById('centerAddr');
		        infoDiv.innerHTML = result[0].fullName;
		    }    
		}
		
		daum.maps.event.addListener(map, 'idle', function() {
		    searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		});
		
		daum.maps.event.addListener(map, 'dblclick', function(mouseEvent) {
			window.close();
		});
		daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
			panTo();
		});
	});
</script>
</head>
<body>
	<div class="mapDetailMain">
		<div id='addr'>장소 : </div>
		<div id="map" class="bigMap"></div>
		<input type="hidden" value="${locX}" id="locX" /> <input type="hidden" value="${locY}" id="locY" />
		<div class="map_wrap">
    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
    <div id="centerAddr"></div>
</div>
	</div>
</body>
</html>