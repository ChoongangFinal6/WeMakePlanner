<%@page import="java.util.*"%>
<%@ include file="aa.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%!//일정 입력을 위한카운트
	class ToDo {
		String title;
		Boolean finish;
		int pKey;
		Date endTime;
		Date startTime;
		int duration; //일단위

	}%>
<%
	request.setCharacterEncoding("utf-8");

	Calendar cal = Calendar.getInstance(); //현재 시스템이 가지고 있는 날짜 데이터 가지고 오기

	int y = cal.get(Calendar.YEAR);
	int m = cal.get(Calendar.MONTH) + 1;
	int d = cal.get(Calendar.DATE);
	

	if (request.getParameter("y") != null)
		y = Integer.parseInt(request.getParameter("y"));
	if (request.getParameter("m") != null)
		m = Integer.parseInt(request.getParameter("m"));

	//y년 m월 1일의 요일
	cal.set(y, m - 1, 1);
	Calendar day = Calendar.getInstance();
	day.set(y,m-1,1);
	
	// y=cal.get(Calendar.YEAR);
	// m=cal.get(Calendar.MONTH)+1;
	int w = cal.get(Calendar.DAY_OF_WEEK); //1(일)~7(토) => 일요일일때 w에 1. 메소드를 외우면 된다.
	
	HashMap<Integer, ArrayList<ToDo>> todo = new HashMap<Integer, ArrayList<ToDo>>();
	HashMap<Integer, ArrayList<ToDo>> todoS = new HashMap<Integer, ArrayList<ToDo>>();
	
	ArrayList<ToDo> d20150611 = new ArrayList<ToDo>();
	ToDo t1 = new ToDo();
	t1.duration = 0;
	t1.endTime = new Date(2015,6,11,13,10,0);
	Calendar ca1 = Calendar.getInstance();
	ca1.setTime(t1.endTime);
	ca1.add(Calendar.DATE, t1.duration*(-1));
	t1.startTime = new Date(ca1.getTimeInMillis());
	t1.pKey = 1;
	t1.finish = true;
	t1.title = "150611";
	d20150611.add(t1);

	ToDo t2 = new ToDo();
	t2.duration = 1;
	t2.endTime = new Date(2015,6,12,13,10,0);
	
	Calendar ca2 = Calendar.getInstance();
	ca2.setTime(t2.endTime);
	ca2.add(Calendar.DATE, t2.duration*(-1));
	t2.startTime = new Date(ca2.getTimeInMillis());

	t2.pKey = 2;
	t2.finish = false;
	t2.title = "150611-2";
	d20150611.add(t2);
	
	ArrayList<ToDo> d20150613 = new ArrayList<ToDo>();
	ArrayList<ToDo> s20150610 = new ArrayList<ToDo>();
	ToDo t3 = new ToDo();
	t3.title = "150613";
	t3.pKey = 3;
	t3.finish = true;
	t3.duration = 0;
	t3.endTime = new Date(2015,6,13,16,10,0);
	
	s20150610.add(t3);
	s20150610.add(t1);
	Calendar ca3 = Calendar.getInstance();
	ca3.setTime(t3.endTime);
	ca3.add(Calendar.DATE, t3.duration*(-1));
	t3.startTime = new Date(ca3.getTimeInMillis());
	
	d20150613.add(t3);
	todo.put(20150611, d20150611);
	todo.put(20150613, d20150613);
	todoS.put(20150610, s20150610);
%>
<c:set var="ys" value="<%=y%>"></c:set>
<c:set var="ms" value="<%=m%>"></c:set>
<c:set var="ws" value="<%=w%>"></c:set>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	$(function() {
		var id = "";
		var date = "";
		$('#draggable').draggable();
		$('.todo,.todoS').draggable({
			cursor : "move",
			snap : "td",
			start : function() {
				//var id= $(this).attr('id');
			},
			drag : function() {
			},
			stop : function(event, ui) {
			}
			
		});
		$(".day").droppable({
		    drop: function (ev, ui) {
		        //to get the id
		        //ui.draggable.attr('id') or ui.draggable.get(0).id or ui.draggable[0].id
		        var id = ui.draggable.attr("id");
		        var date = $(this).attr("id");
		        // Alert draggable elment id and dropable element Id
		        //alert("draggable Element Id" + draggableId + " dropableId  " + droppableId);
				$.post({
					url : './update.jsp',
					dataType : "html",
					data : {"id":id,"date":date},
					success : function(data) {
						$('#detail').html(data);
					}
				});
		    }
		});

		$('td').bind('click', function() {
			var date = $(this).attr('id');
			$.ajax({
				url : './new.jsp',
				dataType : "html",
				data : "date=" + date,
				success : function(data) {
					$('#detail').html(data);
				}
			});
			return false;
		});
		$('.todo').bind('click', function() {
			var id = $(this).attr('id');
			$.ajax({
				url : './detail.jsp',
				dataType : "html",
				data : "id=" + id,
				success : function(data) {
					$('#detail').html(data);
				}
			});
			return false;
		});

	});
</script>
<script type="text/javascript">
	function changeDate() {
		var y = document.getElementById("y").value;
		var m = document.getElementById("m").value;
		var url = "calendar.html?y=" + y + "&m=" + m;
		location.href = url; //url이 가지고 있는 값으로 이동
	}
</script>
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<style type="text/css">
body {
	
}

table {
	text-align: left;
	width: 700px;
	background-color: #ff22cc;
}

td.day {
	height: 100px;
	vertical-align: top;
	padding: 0px;
	margin: 0px;
}

div.day {
	position: relative;
	left: 0px;
	top: 0px;
	margin: 0px;
	padding: 2px;
	width: 50px;
}

div.todo, div.todoS {
	margin: 0px;
	padding: 0px;
	width: 95px;
	border-radius: 2px;
	border: 1px solid black;
	width: 95px;
}

div.todo {
	background-color: #ee0000;
}

div.todoS {
	background-color: #00ee00;
}

#draggable {
	border: 1px red solid;
	width: 100px;
	height: 100px;
}
</style>
</head>
<body>
${root} 
	<table>
		<caption style="height: 20px;">

			<select id="y" onchange="changeDate();">

				<c:forEach var="i" begin='${ys-5}' end='${ys+5 }'>
					<c:if test="${ys==i}">
						<option value="${i}" selected="selected">${i }년</option>
					</c:if>
					<c:if test="${ys!=i}">
						<option value="${i}">${i }년</option>
					</c:if>
				</c:forEach>

			</select> <select id="m" onchange="changeDate();">
				<c:forEach var="i" begin='1' end='12'>
					<c:if test="${ms==i}">
						<option value="${i}" selected="selected">${i }월</option>
					</c:if>
					<c:if test="${ms!=i}">
						<option value="${i}">${i }월</option>
					</c:if>
				</c:forEach>

			</select>

		</caption>

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
				ymd = Integer.parseInt(String.format("%04d", dYear)
						+ String.format("%02d", dMonth)
						+ String.format("%02d", dDate));
				System.out.println(ymd);
				String wc;
				wc = dDayW % 7 == 1 ? "red" : (dDayW % 7 == 0 ? "blue"
						: "black");
				if (dDayW == 1)
					out.println("<tr>");
				out.print("<td id='" + ymd
						+ "' class='day' bgcolor='#ffffff' style='color:" + wc
						+ ";'>");
				out.print("<div class='day'>");
				out.print(dMonth + "-" + dDay);
				out.print("</div>");
				if (todo.containsKey(ymd)) {
					for (int i = 0; i < todo.get(ymd).size(); i++) {
						out.print("<div class='d_" + ymd + "_" + i
								+ ", todo', id='" + todo.get(ymd).get(i).pKey
								+ "'>");
						out.println(todo.get(ymd).get(i).title);
						System.out.print(todo.get(ymd).get(i).title);
						out.print("</div>");
					}
				}
				if (todoS.containsKey(ymd)) {
					for (int i = 0; i < todoS.get(ymd).size(); i++) {
						out.print("<div class='s_" + ymd + "_" + i
								+ ", todoS', id='" + todoS.get(ymd).get(i).pKey
								+ "'>");
						out.println(todoS.get(ymd).get(i).title);
						System.out.print(todoS.get(ymd).get(i).title);
						out.print("</div>");
					}
				}
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
	${aa}<br>${bb}
</body>
</html>