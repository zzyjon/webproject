<%@ page contentType="text/html; charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.json.simple.*" %>
<%
	String inputTitle = (String)request.getParameter("inputTitle");
	String inputContent = (String)request.getParameter("inputContent");
	String inputTag = (String)request.getParameter("inputTag");
	String openN = (String)request.getParameter("openN");
	String openY = (String)request.getParameter("openY");
	String inputPw = (String)request.getParameter("inputPw");
	String inputReplyYN = (String)request.getParameter("inputReplyYN");
	JSONObject jo = new JSONObject();
	
	
	if(inputTitle != null){
		out.print("inputTitle =" + inputTitle);
		out.print("inputContent =" + inputContent);
		out.print("inputTag =" + inputTag);
		out.print("openN =" + openN);
		out.print("openY =" + openY);
		out.print("inputPw =" + inputPw);
		out.print("inputReplyYN =" + inputReplyYN);
	
	}else{
		jo.put("result","300");
		jo.put("desc","param is null");
	}
	
	out.print(jo);
	out.flush();
%>