<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="aa.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>금주의 일정</title>
<link href="<c:url value="/resources/css/thisWeek.css" />" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=90890f0c035d0a05ca5915f1e0ca7195&libraries=services"></script>
<script type="text/javascript" src="<c:url value="/resources/js/tw.js"/>"></script>
</head>
</head>
<body>
	<div id="thisWeek">
		
		<div class='top'>
			<span class='topTitle'>한 주의 일정</span>
			<span class='topDate'>~<fmt:formatDate value='${dateAfter}' pattern="yyyy년 MM월 dd일" />
			</span>
			<br>
			<div id="expand">
				<a id="expandText">펼치기</a>
			</div>
		</div>
		
		<div id="main">
			<c:forEach items="${thisWeek}" var="tw">
				<div class='item'>
					<div class='header'>
						<span class='title'>
							${tw.title}
						</span> 
						<span class='dday'>
							<c:if test="${tw.duration>0}">D-${tw.duration}</c:if>
						</span>
					</div>
					<div class='main'>
						<span id="endTime${tw.no }">
							${tw.endTime} 
						</span>
						<br>
						<c:if test="${todo.location.length() >10}">
							<span id="map${tw.no}" class='map'> </span>
						</c:if>
						<span id="repeat${tw.no}">반복 : ${tw.repeat }일 마다</span>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>