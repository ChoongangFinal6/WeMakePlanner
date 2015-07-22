<%@page import="java.util.*,model.*"%>
<%@ include file="calMain.jsp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>To-Do List</title>
<script type="text/javascript" src="<c:url value="/resources/js/calMain.js"/>"></script>
<link href="<c:url value="/resources/css/calMain.css" />" rel="stylesheet">
<link href="<c:url value="/resources/css/popup.css" />" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<link href="<c:url value="/resources/css/map.css" />" rel="stylesheet">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=90890f0c035d0a05ca5915f1e0ca7195&libraries=services" ></script>
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

			<!-- <span id='thisWeek'><a href="thisWeek.html">금주의 일정</a></span> -->
			<span id='thisWeek' class='thisWeek'>금주 일정</span>
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
			
		<c:set var="weekDay" value="0"/>
		<c:forEach items="${list}" var="ctd">
		<c:set var="wc" value="black"/>
		<c:if test="${weekDay%7 == 0 }">
			<tr>
			<c:set var="wc" value="red"></c:set>
		</c:if>
				<c:if test="${weekDay%7 == 6 }"><c:set var="wc" value="blue"/></c:if>
				<td id="${ctd.yymmdd }" class="day" bgcolor="#ffffff" style="color:${wc}">
					<div class="day">
						<span class='Month'>${fn:substring(ctd.yymmdd, 4, 6)}/</span><span class='Day'>${fn:substring(ctd.yymmdd, 6, 8)}</span>
					</div>
					<ul class='todoUl' id='${ctd.yymmdd }'>
						<c:set value="0" var="cnt"></c:set>
						<c:forEach items="${ctd.todoS}" var="todoS" >
							<li class='todoSLi ${todoS.no}' id='${todoS.no}'>
								<div class='s_${ctd.yymmdd}_${cnt} todoS'>
									<c:if test="${todoS.duration>0 }">
										<span class='dday'>d-${todoS.duration}</span>
									</c:if>
									<span class='block aaaa'>
										${todoS.title}
									</span>
								</div>
							</li>
							<c:set value="${cnt+1 }" var="cnt"/>
						</c:forEach>
						<c:set value="0" var="cnt"></c:set>
						<c:forEach items="${ctd.todo}" var="todo">
							<li class='todoLi ${todo.no}' id='${todo.no}'>
								<div class='d_${ctd.yymmdd}_${cnt} todo'>
									<c:if test="${todo.finish == 'Y' }">
										<span class='block chkBlock' id='chk_${todo.no }'><img class='chkImg chkd'></span>
										<span class='block aaaa strike'>${todo.title}</span>
									</c:if>
									<c:if test="${todo.finish == 'N' }">
										<span class='block chkBlock' id='chk_${todo.no }'><img class='chkImg'></span>
										<span class='block aaaa'>${todo.title}</span>
									</c:if>
								</div>
							</li>
							<c:set value="${cnt+1 }" var="cnt"></c:set>
						</c:forEach>
					</ul>
				</td>
		<c:if test="${weekDay%7 == 6 }">
			</tr>
		</c:if>
		<c:set var="weekDay" value="${weekDay+1}" />
		</c:forEach>
		</table>
		<div id='detail'>
			<div id='detailI'></div>
			<span id="xButton">X</span>
		</div>
	</div>
	<img src='<c:url value="/resources/img/chk2.png" />' id='imgAddr'>
</body>
</html>