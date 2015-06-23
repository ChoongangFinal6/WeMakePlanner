<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<table class='todo_table'>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title" required="required" /></td>
		</tr>
		<tr>
			<th>마감시간</th>
			<td><input type="datetime-local" name="endTime"
				required="required"><input type="checkbox"></td>
		</tr>
		<tr>
			<th>장소</th>
			<td><input type="button" value="찾기"><span id="loc"></span>
				<input type="hidden" name="location" value="1"></td>
		</tr>
		<tr>
			<th>반복</th>
			<td><input type="number" name="repeat">일</td>
		</tr>
		<tr>
			<td><input type="submit" value="수정"></td>
			<td><input type="submit" value="취소"></td>
		</tr>
	</table>
</body>
</html>