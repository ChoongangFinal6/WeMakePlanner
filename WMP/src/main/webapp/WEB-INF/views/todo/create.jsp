<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	새 일정
	<%
	String date = request.getParameter("date");
%>
	<%=date%>

	<form>
		<table class='tocr_table'>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" required="required"></td>
				</tr>
				<tr>
				<th>마감시간</th>
				<td><input type="datetime" name="endTime" required="required"><input type="checkbox"> </td>
				</tr>
				<tr>
				<th>반복</th>
				<td><input type="number" name="repeat">일</td>
				</tr>
			<tr><td>
		<input type="submit" value="입력"></td><td></td>
			</tr>
		</table>
	</form>
</body>
</html>
<!-- 새 일정 눌렀을때 시간문제 --> 

<!-- 	private int no;					// 일련번호         
	private String title, email;    // 제목, 이메일         
	private int duration;           // 기간     
	private Timestamp endTime;      // 마감시간        
	private String location;        // 장소      
	private Boolean finish;         //  완료      
	private int repeat;             // 반복
	private Timestamp startTime;	// -->