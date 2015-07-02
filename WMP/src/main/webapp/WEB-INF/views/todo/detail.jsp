<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript">
	$(function() {
	});
</script>
<div class="popup">
	<input type="hidden" id="locX" value="${locX}"> <input type="hidden" id="locY" value="${locY}">
	<div>
		<table class='todo_table'>
			<tr>
				<td colspan="2"><span class="title">${todo.title}</span> <c:if test="${todo.finish == 'Y' }">
						<span class="fLeft"><input type="checkbox" checked="checked" onchange="tgl('${todo.no}')"></span>
					</c:if> <c:if test="${todo.finish == 'N' }">
						<span class="fLeft"><input type="checkbox" onchange="tgl('${todo.no}')"></span>
					</c:if></td>
			</tr>
			<tr>
				<th colspan="2">마감시간</th>
			</tr>
			<tr>
				<td colspan="2"><span>${todo.endTime}</span></td>
			</tr>
			<c:if test="${todo.location.length() >10}">
				<tr>
					<th colspan="1">장소</th>
					<td><span id="addr"></span></td>
				</tr>
				<tr>
					<td colspan="2">
						<div class="smallMap" id="map" style="width: 100%; height: 180px;"></div>
					</td>
				<tr>
					<td colspan="2"><input type="hidden" id="location" name="location" value="${todo.location}">
					</td>
				</tr>
			</c:if>
			<c:if test="${todo.location.length() <=10}">
				<div class="smallMap" id="map"></div>
				<input type="hidden" id="location" name="location" value="0,0">
			</c:if>
			<tr>
				<th colspan="2">반복</th>
			</tr>
			<tr>
				<td colspan="2"><c:if test="${todo.repeat >0 }">
						<span>${todo.repeat}일 마다</span>
					</c:if> <c:if test="${todo.repeat ==0 }">
						<span>반복 없음</span>
					</c:if></td>
			</tr>
			<tr>
				<td colspan="2"><input type="button" value="수정" onclick="modify('${todo.no}')" class='text half'>
				<input type="button" value="삭제" onclick="del('${todo.no}')" class='text half'></td>
			</tr>
		</table>
	</div>
</div>
