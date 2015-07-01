<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
$('#searchLoc').bind('click', function() {
	var loc = $('#location').val();
	var locArray = loc.split(",");
	window.open("./map.html?locX="+locArray[0]+"&locY="+locArray[1], "위치찾기", "width=650, height=400");
});
function inputLoc(locX,locY) {
	$('#location').val(locX+","+locY);
}
</script>
<div class="popup">
	<form action="modify.html" method="post">
	<h3><input type="text" name="title" required="required" value="${todo.title}" id="inputModifyTitle"/></h3>
	<input type="hidden" name="email" value="kheeuk@gmail.com" />
	<input type="hidden" name="no" value="${todo.no }" />
	<table class='todo_table'>
<%-- 		<tr>
			<th>제목</th>
			<td><input type="text" name="title" required="required" value="${todo.title}"/></td>
		</tr> --%>
		<tr>
			<th>마감시간</th>
			<td><input type="datetime-local" name="endTime"
				required="required" value="${todo.endTime }"><input type="checkbox"></td>
		</tr>
		<tr>
			<th>준비기간</th>
			<td><input type="number" name="duration" value="${todo.duration }">일</td>
		</tr>
		<tr>
			<th>장소</th>
			<td><input type="button" value="찾기" id='searchLoc' ><span id="loc">${todo.location }</span>
				<input type="hidden" name="location" id="location" value="${todo.location}"></td>
		</tr>
		<tr>
			<th>반복</th>
			<td><input type="number" name="repeat" value="${todo.repeat }">일</td>
		</tr>
		<tr>
			<td><input type="submit" value="수정"></td>
			<td><input type="button" value="취소" onclick="cancelModify('${todo.no }')"></td>
		</tr>
	</table>
	</Form>
</div>
