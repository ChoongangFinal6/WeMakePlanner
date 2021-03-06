<%@ include file="calMain.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link href="<c:url value="/resources/css/popup.css" />" rel="stylesheet">
<script src="http://malsup.github.com/jquery.form.js"></script>
<script type="text/javascript">
$('#searchLoc').bind('click', function() {
	var loc = $('#location').val();
	var locArray = loc.split(",");
	var win = window.open("./map.html?locX="+locArray[0]+"&locY="+locArray[1], "위치찾기", "width=840, height=680,resizable=false");
	setTimeout(function() {
		win.document.title = "위치 찾기";
	},1000);
});
function inputLoc(locX,locY,str) {
	$('#location').val(locX+","+locY);
	$('#loc').text(str);
}
</script>
<div class="popup">
	<h3>새 일정</h3>
	<form action="create.html" method="POST">
		<input type="hidden" name="finish" value="N" />
		<table class='todo_table'>
			<tr>
				<th colspan="2" class='paddingLeft'>제목</th>
			</tr>
			<tr>
				<td colspan="2" class='center'>
					<input type="text" class="text" name="title" maxlength="20" required="required" />
				</td>
			</tr>
			<tr>
				<th colspan="2" class='paddingLeft'>마감시간</th>
			</tr>
			<tr>
				<td colspan="2" class='center'>
					<input type="datetime-local" class="text" name="endTime" required="required" value='${cal }'>
				</td>
			</tr>
			<tr>
				<th width="40%" class='paddingLeft'>장소</th>
				<th class='right'>
					<input type="button" class="text" value="찾기" id='searchLoc'>
				</th>
			</tr>
			<tr>
				<td colspan="2" class='center'>
				<span id="loc"></span> 
				<input type="hidden" name="location" class="text" value="," id="location"></td>
			</tr>
			<tr>
				<th class='paddingLeft'>준비기간</th>
				<th class='paddingLeft'>반복</th>
			</tr>
			<tr>
				<td width="50%" class='right'>
					<input type="number" class="text small" name="duration" min="0" max="500">일
				</td>
				<td class='right'>
					<input type="number" class="small text" class="text" name="repeat" min="0" max="500">일
				</td>
			</tr>
			<tr>
				<td></td>
				<td>
					<span class='center'>
						<input type="submit" value="입력" class='fRight text'>
					</span>
				</td>
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