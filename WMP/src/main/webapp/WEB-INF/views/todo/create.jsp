<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="<c:url value="/resources/css/popup.css" />" rel="stylesheet">
<script src="http://malsup.github.com/jquery.form.js"></script>
<script type="text/javascript">
$('#searchLoc').bind('click', function() {
	var loc = $('#location').val();
	var locArray = loc.split(",");
	window.open("./map.html?locX="+locArray[0]+"&locY="+locArray[1], "위치찾기", "width=650, height=500");
});
function inputLoc(locX,locY) {
	$('#location').val(locX+","+locY);
}
</script>
<div class="popup">
	<h3>새 일정</h3>
	${cal}
	<form action="create.html" method="POST">
		<input type="hidden" name="email" value="kheeuk@gmail.com" /> 
		<input type="hidden" name="finish" value="N" />
		<table class='todo_table'>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" required="required" /></td>
			</tr>
			<tr>
				<th>마감시간</th>
				<td><input type="datetime-local" name="endTime" required="required" value='${cal }'><input
					type="checkbox"></td>
			</tr>
			<tr>
				<th>준비기간</th>
				<td><input type="number" name="duration" >일</td>
			</tr>
			<tr>
				<th>장소</th>
				<td><input type="button" value="찾기" id='searchLoc'>
				<span id="loc"></span> 
				<input type="hidden" name="location" value="," id="location"></td>
			</tr>
			<tr>
				<th>반복</th>
				<td><input type="number" name="repeat">일</td>
			</tr>
			<tr>
				<td><input type="submit" value="입력"></td>
				<td></td>
			</tr>
		</table>
	</form>
</div>
<!-- 새 일정 눌렀을때 시간문제 -->

<!-- 	private int no;					// 일련번호         
	private String title, email;    // 제목, 이메일         
	private int duration;           // 기간     
	private Timestamp endTime;      // 마감시간        
	private String location;        // 장소      
	private Boolean finish;         //  완료      
	private int repeat;             // 반복
	private Timestamp startTime;	// -->