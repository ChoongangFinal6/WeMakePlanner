<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="calMain.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>지도</title>
<link href="<c:url value="/resources/css/map.css" />" rel="stylesheet">
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=90890f0c035d0a05ca5915f1e0ca7195&libraries=services"></script>
<script type="text/javascript">
	$(function() {
		var locX = $("#locX").val();
		var locY = $("#locY").val();
		//부모창 장소 표시를 위한 변수
		var addr = "";
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

		// 마커를 클릭했을 때 마커 위에 표시할 인포윈도우를 생성합니다
		var iwContent = '<div style="padding:5px;">이곳으로 지정</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성합니다
		var infowindow = new daum.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		var resultDiv = document.getElementById('clickLatlng');

		var geocoder = new daum.maps.services.Geocoder();

		//searchAddrFromCoords(map.getCenter(), displayCenterInfo);

		function searchAddrFromCoords(coords, callback) {
			// 좌표로 주소 정보를 요청합니다
			geocoder.coord2addr(coords, callback);
		}

		// 지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(status, result) {
			if (status === daum.maps.services.Status.OK) {
				var infoDiv = document.getElementById('centerAddr');
				infoDiv.innerHTML = result[0].fullName;
			}
		}

		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = mouseEvent.latLng;
			locX = latlng.getLat();
			locY = latlng.getLng();

			searchAddrFromCoords(mouseEvent.latLng, function(status, result) {
				if (status === daum.maps.services.Status.OK) {
					var content = '<div style="padding:5px;">'
							+ result[0].fullName + '</div>';
					addr = result[0].fullName;
					marker.setPosition(mouseEvent.latLng);
					marker.setMap(map);
					marker.setVisible(true);
					infowindow.setContent(content);
					infowindow.open(map, marker);
				}
			});

		});
		function removeLoc() {
			marker.setVisible(false);
			infowindow.close();
			var latlng = new daum.maps.LatLng(0, 0);
			locX = latlng.getLat();
			locY = latlng.getLng();
		}
		daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
			removeLoc;
		});
		$('#locInput').bind('click', function() {
			window.opener.inputLoc(locX, locY, addr);
			window.close();
		});
		$('#locDelete').bind('click', function() {
			removeLoc;
			window.opener.inputLoc(locX, locY, addr);
			window.close();
		});
	});
</script>
</head>
<body>
	<div id="map" style="width: 800px; height: 600px;" class="bigMap"></div>
	<input type="hidden" value="${locX}" id="locX" />
	<input type="hidden" value="${locY}" id="locY" />
	<input type="button" value="입력" id="locInput" class="text half">
	<input type="button" value="지우기" id="locDelete" class="text half">
	<div id="centerAddr"></div>

</body>
</html>