<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<link href="<c:url value="/resources/css/popup.css" />" rel="stylesheet">
<script type="text/javascript">
	
</script>
</head>
<body class="popup">
	<div>
		<h3>${todo.title}</h3>
		<table class='todo_table'>
			<tr>
				<th>제목</th>
				<td><span class="text">${todo.title}</span></td>
			</tr>
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
			<tr>
				<th>장소</th>
				<td><span class="text">${todo.location}</span></td>
			</tr>
			<tr>
				<th>반복</th>
				<td><span class="text">${todo.repeat}</span>일</td>
			</tr>
			<tr>
				<td><input type="button" value="수정" onclick="modify('${todo.no}')"></td>
				<td><input type="button" value="삭제" onclick="del('${todo.no}')"></td>
			</tr>
		</table>
		
	</div>
</body>
</html>