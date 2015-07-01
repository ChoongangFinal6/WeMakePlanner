<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
		/* var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var locX = $("#locX").val();
		var locY = $("#locY").val(); 
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new daum.maps.LatLng(locX,locY), //지도의 중심좌표.
			level: 2 //지도의 레벨(확대, 축소 정도)
		};
		var markerPosition  = new daum.maps.LatLng(locX,locY); 
		// 지도를 클릭한 위치에 표출할 마커입니다
		var marker = new daum.maps.Marker({
			// 지도 중심좌표에 마커를 생성합니다 
			position: markerPosition
		});
		// 지도에 마커를 표시합니다
		marker.setMap(map);
		var map = new daum.maps.Map(container, options);
		map.setDraggable(false); */
	});
</script>
<div class="popup">
	<input type="hidden" id="locX" value="${locX}"> <input type="hidden" id="locY" value="${locY}">
	<div>
		<h3>${todo.title}</h3>
		<table class='todo_table'>
			<%-- 			<tr>
				<th>제목</th>
				<td><span class="text">${todo.title}</span></td>
			</tr> --%>
			<tr>
				<th>완료</th>
				<td><c:if test="${todo.finish == 'Y' }">
						<span class="text"><input type="checkbox" checked="checked" onchange="tgl('${todo.no}')"></span>
					</c:if> <c:if test="${todo.finish == 'N' }">
						<span class="text"><input type="checkbox" onchange="tgl('${todo.no}')"></span>
					</c:if></td>
			</tr>
			<tr>
				<th>마감시간</th>
				<td><span class="text">${todo.endTime}</span></td>
			</tr>
			<c:if test="${todo.location.length() >10}">
				<tr>
					<th>장소</th>
					<td>
						<div id="map" style="width: 300px; height: 150px;"></div> <input type="hidden" id="location"
						name="location" value="${todo.location}">
					</td>
				</tr>
			</c:if>
			<c:if test="${todo.location.length() <=10}">
				<div id="map"></div>
				<input type="hidden" id="location" name="location" value="0,0">
			</c:if>
			<tr>
				<th>반복</th>
				<td>
				<c:if test="${todo.repeat >0 }">
				<span class="text">${todo.repeat}일 마다</span>
				</c:if>
				<c:if test="${todo.repeat ==0 }">
				<span class="text">반복 없음</span>
				</c:if>
				</td>
			</tr>
			<tr>
				<td><input type="button" value="수정" onclick="modify('${todo.no}')"></td>
				<td><input type="button" value="삭제" onclick="del('${todo.no}')"></td>
			</tr>
		</table>
	</div>
</div>
