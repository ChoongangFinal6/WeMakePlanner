<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link href="<c:url value="/resources/css/popup.css" />" rel="stylesheet">
</head>
<body class="popup">
	${todo.title}
	<Form action="modify.html" method="post">
	<input type="hidden" name="email" value="kheeuk@gmail.com" />
	<input type="hidden" name="no" value="${todo.no }" />
	<table class='todo_table'>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" required="required" value="${todo.title}"/></td>
		</tr>
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
			<td><input type="button" value="찾기"><span id="loc">${todo.location }</span>
				<input type="hidden" name="location" value="${todo.location}"></td>
		</tr>
		<tr>
			<th>반복</th>
			<td><input type="number" name="repeat" value="${todo.repeat }">일</td>
		</tr>
		<tr>
			<td><input type="submit" value="수정"></td>
			<td><input type="button" value="취소" onclick='cancle()'></td>
		</tr>
	</table>
	</Form>
</body>
</html>