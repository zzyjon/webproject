<%@ page contentType="text/html; charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	session.invalidate();  // 세션 삭제 
	response.sendRedirect("MyMain.jsp");
	
%>