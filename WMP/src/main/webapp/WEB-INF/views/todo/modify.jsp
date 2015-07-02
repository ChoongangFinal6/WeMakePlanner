<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
$('#searchLoc').bind('click', function() {
	var loc = $('#location').val();
	var locArray = loc.split(",");
	window.open("./map.html?locX="+locArray[0]+"&locY="+locArray[1], "위치찾기", "width=840, height=680,resizable=false");
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
			<tr>
				<th colspan="2" class='paddingLeft'>마감시간</th>
			</tr>
			<tr>
				<td colspan="2" class='center'><input type="datetime-local" class="text" name="endTime" required="required" value="${todo.endTime }"></td>
			</tr>
			<tr>
				<th width="40%" class='paddingLeft'>장소</th><th class='right'><input type="button" class="text" value="찾기" id='searchLoc'></th>
			</tr>
			<tr>
				<td colspan="2" class='center'>
				<span id="loc">${todo.location }</span> 
				<input type="hidden" name="location" class="text" value="," id="location"></td>
			</tr>
			<tr>
				<th class='paddingLeft'>준비기간</th><th class='paddingLeft'>반복</th>
			</tr>
			<tr>
				<td width="50%" class='right'><input type="number" class="text small" name="duration" min="0" max="500" value="${todo.duration }">일</td>
				<td class='right'><input type="number" class="small text" class="text" name="repeat" min="0" max="500" value="${todo.repeat }">일</td>
			</tr>
			<tr>
				<td></td>
				<td><span class='center'><input type="submit" value="수정" class='fRight text'></span></td>
			</tr>
	</table>
	</Form>
</div>
