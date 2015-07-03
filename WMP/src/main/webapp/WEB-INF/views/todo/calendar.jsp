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
<link href="<c:url value="/resources/css/map.css" />" rel="stylesheet">
<script type="text/javascript"
	src="//apis.daum.net/maps/maps3.js?apikey=90890f0c035d0a05ca5915f1e0ca7195&libraries=services"></script>
</head>
<body>
	<div id='todoM'>
		<div class='center top' id="topYear">
			<span id="yearMonth">
				<img src="<c:url value="/resources/img/bArrow.png" />" id="before" onclick="changeMonth(-1)">
				<input type="text" id="year" name="y" class="bigDate" value="${y}">
				<span class="bigDate">-</span>
				<input type="text" id="month" name="m" value="${m+1 }" class="bigDate">
				<img src="<c:url value="/resources/img/aArrow.png" />" id="after" onclick="changeMonth(+1)">
			</span>
		</div>

			<div id='thisWeek'><a href="thisWeek.html">금주의 일정</a></div>
		<table class='center cal'>
			<tr height="25">
				<th><font color="red">SUN</font></th>
				<th>MON</th>
				<th>TUE</th>
				<th>WED</th>
				<th>THU</th>
				<th>FRI</th>
				<th><font color="blue">SAT</font></th>
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
					out.print("<div class='day'><span class='Month'>");
					out.print(dMonth + "/</span><span class='Day'>" + dDay + "</span>");
					out.println("</div>");
					out.print("<ul class='todoUl' id='" + ymd + "'>");
					if (todoS.containsKey(ymd)) {
						for (int i = 0; i < todoS.get(ymd).size(); i++) {
							out.print("<li class='todoSLi' id='" + todoS.get(ymd).get(i).getNo()
									+ "'><div class='s_" + ymd + "_" + i + " todoS'>");
							out.println("<span class='dday'>d-" + todoS.get(ymd).get(i).getDuration() + "</span>");
							out.println("<span class='block aaaa'>");
							out.println(todoS.get(ymd).get(i).getTitle());
							out.println("</span class='block aaaa'>");
							out.print("</div></li>");
						}
					}
					if (todo.containsKey(ymd)) {
						List<ToDo> list = todo.get(ymd);
						for (int i = 0; i < todo.get(ymd).size(); i++) {
							int no = todo.get(ymd).get(i).getNo();
							if (list.get(i).getFinish().equals("Y")) {
								out.print("<li class='todoLi' id='" + no + "'><div class='d_" + ymd + "_" + i
										+ " todo'>");
								out.println("<span class='block'><input type='checkbox' id='chk_" + no
										+ "' name='finish' class='chk css-checkbox' checked='checked'>");
								out.println("<label for='chk_" + no
										+ "' class='css-label lite-cyan-check'></label></span>");
								out.print("<span class='block aaaa strike'>");
							} else {
								out.print("<li class='todoLi' id='" + no + "'><div class='d_" + ymd + "_" + i
										+ " todo'>");
								out.println("<span class='block'><input type='checkbox' id='chk_" + no
										+ "' name='finish' class='chk css-checkbox'>");
								out.println("<label for='chk_" + no
										+ "' class='css-label lite-cyan-check'></label></span>");
								out.print("<span class='block aaaa'>");
							}
							String str1 = todo.get(ymd).get(i).getTitle();
							out.print(str1);
							out.print("</span>");
							out.print("</div></li>");
						}
					}
					out.print("</ul>");
					out.println("</td>");
					if (dDayW == 7)
						out.println("</tr>");
					if (day.after(cal) && dDayW == 7) {
						break wt;
					}
					day.add(Calendar.DATE, +1);
					cnt++;
				}
				;
			%>
		</table>
		<div id='detail'>
			<div id='detailI'></div>
			<span id="xButton">X</span>
		</div>
	</div>
</body>
</html>