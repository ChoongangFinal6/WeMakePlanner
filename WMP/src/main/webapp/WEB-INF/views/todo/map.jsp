<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="aa.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=90890f0c035d0a05ca5915f1e0ca7195"></script>
<script type="text/javascript">
	$(function() {
  		var locStr = $("loc").val();
  		var loc = locStr.split(",");
/* 		var locX = $("#locX").val();
		var locY = $("#locY").val(); */ 
		var locX = loc[0];
		var locY = loc[1];  
alert(locX);
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
		var iwContent = '<div style="padding:5px;">Hello World!</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
		iwRemoveable = true; // removeable 속성을 ture 로 설정하면 인포윈도우를 닫을 수 있는 x버튼이 표시됩니다

		// 인포윈도우를 생성합니다
		var infowindow = new daum.maps.InfoWindow({
			content : iwContent,
			removable : iwRemoveable
		});

		// 지도에 클릭 이벤트를 등록합니다
		// 지도를 클릭하면 마지막 파라미터로 넘어온 함수를 호출합니다
		var resultDiv = document.getElementById('clickLatlng');
		daum.maps.event.addListener(map, 'click', function(mouseEvent) {
			// 클릭한 위도, 경도 정보를 가져옵니다 
			var latlng = mouseEvent.latLng;

			// 마커 위치를 클릭한 위치로 옮깁니다
			marker.setPosition(latlng);
			marker.setVisible(true);
			marker.setMap(map);
			locX = latlng.getLat();
			locY = latlng.getLng();
			var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			message += '경도는 ' + latlng.getLng() + ' 입니다';
			$("#locX").val(latlng.getLat());
			$("#locY").val(latlng.getLng());

			resultDiv.innerHTML = message;

			infowindow.open(map, marker);

		});
		daum.maps.event.addListener(map, 'rightclick', function(mouseEvent) {
			marker.setVisible(false);
			infowindow.close();

			var latlng = new daum.maps.LatLng(0, 0);
			locX = latlng.getLat();
			locY = latlng.getLng();
			var message = '클릭한 위치의 위도는 ' + latlng.getLat() + ' 이고, ';
			message += '경도는 ' + latlng.getLng() + ' 입니다' + latlng.toString();
			var resultDiv = document.getElementById('clickLatlng');
			resultDiv.innerHTML = message;

		});
		$('#locInput').bind('click', function() {
			window.opener.inputLoc(locX,locY);
			window.close();
		});
	});
</script>
</head>
<body>
	<input type="text" value="${loc}" id="loc" />
	<div id="map" style="width: 600px; height: 300px;"></div>
	<input type="text" value="${locX}" id="locX" />
	<input type="text" value="${locY}" id="locY" />
	<div id="clickLatlng"></div>
	<input type="button" value="입력" id="locInput">
	<input type="button" value="지우기" id="locDelete">

</body>
</html>