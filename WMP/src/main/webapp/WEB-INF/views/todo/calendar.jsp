<%@page import="java.util.*,model.*"%>
<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	HashMap<Integer, List<ToDo>> todo = (HashMap<Integer, List<ToDo>>)request.getAttribute("todo");
	HashMap<Integer, List<ToDo>> todoS = (HashMap<Integer, List<ToDo>>)request.getAttribute("todoS");
	Calendar cal = (Calendar)request.getAttribute("cal");
	int w = (int)request.getAttribute("w");
	Calendar day = Calendar.getInstance();
	day.set(cal.get(Calendar.YEAR), cal.get(Calendar.MONTH), cal.get(Calendar.DATE));
%>
<c:set var="ys" value="${y }"></c:set>
<c:set var="ms" value="${m }"></c:set>
<c:set var="ws" value="${w }"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>To-Do List</title>
<script type="text/javascript" src="<c:url value="/resources/js/aa.js"/>"></script>
<link href="<c:url value="/resources/css/aa.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/styleChk.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/popup.css" />" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">

</head>
<body>
	<div id='todoM'>
		<div class='center'>
			<select id="y" onchange="changeDate();">

				<c:forEach begin="${y-5 }" end="${y+5 }" var="i">
					<c:if test="${y==i}">
						<option value="${i}" selected="selected">${i }년</option>
					</c:if>
					<c:if test="${y!=i}">
						<option value="${i}">${i }년</option>
					</c:if>
				</c:forEach>

			</select> <select id="m" onchange="changeDate();">
				<c:forEach var="i" begin='1' end='12'>
					<c:if test="${m+1==i}">
						<option value="${i}" selected="selected">${i }월</option>
					</c:if>
					<c:if test="${m+1!=i}">
						<option value="${i}">${i }월</option>
					</c:if>
				</c:forEach>

			</select>
		</div>
		<table class='center cal'>
			<tr height="25">
				<th><font color="red">일</font></th>
				<th>월</th>
				<th>화</th>
				<th>수</th>
				<th>목</th>
				<th>금</th>
				<th><font color="blue">토</font></th>
			</tr>
			<%
				day.add(Calendar.DATE, +1 - w);
				int dDate, dDayW, dMonth, dDay, dYear;
				String dY;
				cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DATE));
				int cnt = 0;
				int ymd;
				wt: while (true) {
					dYear = day.get(Calendar.YEAR);
					dDate = day.get(Calendar.DATE);
					dDayW = day.get(Calendar.DAY_OF_WEEK);
					dMonth = day.get(Calendar.MONTH) + 1;
					dDay = day.get(Calendar.DAY_OF_MONTH);
					ymd = Integer.parseInt(String.format("%04d", dYear) + String.format("%02d", dMonth)
							+ String.format("%02d", dDate));
					String wc;
					wc = dDayW % 7 == 1 ? "red" : (dDayW % 7 == 0 ? "blue" : "black");
					if (dDayW == 1)
						out.println("<tr>");
					out.print("<td id='" + ymd + "' class='day' bgcolor='#ffffff' style='color:" + wc + ";'>");
					out.print("<div class='day'>");
					out.print(dMonth + "-" + dDay);
					out.println("</div>");
					out.print("<ul class='dayUl' id='" + ymd + "'>");
					if (todoS.containsKey(ymd)) {
						for (int i = 0; i < todoS.get(ymd).size(); i++) {
							out.print("<li class='todoSLi' id='" + todoS.get(ymd).get(i).getNo()
									+ "'><div class='s_" + ymd + "_" + i + " todoS'>");
							out.println(todoS.get(ymd).get(i).getTitle());
							//System.out.print(todoS.get(ymd).get(i).getTitle());
							out.print("</div></li>");
						}
					}
					if (todo.containsKey(ymd)) {
						List<ToDo> list = todo.get(ymd);
						for (int i = 0; i < todo.get(ymd).size(); i++) {
							int no = todo.get(ymd).get(i).getNo();
							if (list.get(i).getFinish().equals("Y")) {
								out.print("<li class='todoLi' id='" + no + "'><div class='d_" + ymd + "_" + i
										+ " todo strike'>");
								out.println("<input type='checkbox' id='chk_" + no
										+ "' name='finish' class='chk css-checkbox' checked='checked'>");
								out.println("<label for='chk_" + no
										+ "' class='css-label lite-cyan-check'></label>");
							} else {
								out.print("<li class='todoLi' id='" + no + "'><div class='d_" + ymd + "_" + i
										+ " todo'>");
								out.println("<input type='checkbox' name='finish' class='chk css-checkbox'>");
								out.println("<label for='chk_" + no
										+ "' class='css-label lite-cyan-check'></label>");
							}
							out.println(todo.get(ymd).get(i).getTitle());
							//System.out.print(todo.get(ymd).get(i).getTitle());
							out.print("</div></li>");
						}
					}
					out.print("</ul>");
					out.println("</td>");
					if (dDayW == 7)
						out.println("</tr>");
					if (day.after(cal) && dDayW == 7)
						break wt;
					day.add(Calendar.DATE, +1);
					cnt++;
				}
				;
			%>
		</table>
	<div id='detail'></div>
	</div>
</body>
</html>