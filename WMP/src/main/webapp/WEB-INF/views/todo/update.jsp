<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% String id = request.getParameter("id");
String date = request.getParameter("date");
%>
변경 : <br>
id : <%=id %><br>
date : <%=date %>
</body>
</html>