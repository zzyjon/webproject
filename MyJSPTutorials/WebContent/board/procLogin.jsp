<%@ page contentType="text/html; charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.json.simple.*" %>
<%
    String inputID = request.getParameter("inputID");
	String inputPW = request.getParameter("inputPW");
	JSONObject jo = new JSONObject();
	
	if(inputID != null && inputPW != null){
		session.setAttribute("id",inputID);
		jo.put("result" , "200");
		jo.put("desc" , "login success");
		out.print(jo);
		out.flush();
	}else{
		jo.put("result" , "100");
		jo.put("desc" , "param is null");
		out.print(jo);
		out.flush();
	}
	
%>

