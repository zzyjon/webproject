<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	String bno = request.getParameter("bno");
	
	/* 
		댓글은 JSONArray에 담아서 출력 
	*/
	JSONObject jo = new JSONObject(); // 큰 범위 json {"result":"200", "desc":"", "list":""}
	JSONObject sjo = null;	//덧글 개별 json {"rno":xxx , "r_content":xxx , "writer"}
	JSONArray ja = new JSONArray(); // 덧글 개별  json 담을 배열 
	
	
	if(bno == null){
		jo.put("result","303");
		jo.put("desc","param is null");
		
		out.print(jo);
		out.flush();
		
	}else{
		
		// DB 연결
		//Class.forName("com.mysql.cj.jdbc.Driver");		
		
		Connection conn = null;
		PreparedStatement psmt = null;
		ResultSet rs = null;
		
		try{
			
			String url = "jdbc:mysql://localhost:3306/mysqltest?verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
			String user= "root";
			String password = "1q2w3e";
			
			conn = DriverManager.getConnection(url, user, password);
			
			String query = "";
				query += "SELECT r_no, r_content, r_writer, reg_date \n";
				query += "FROM reply \n";
				query += "WHERE b_no = ? \n";
				query += "ORDER BY reg_date desc \n";
			
			psmt = conn.prepareStatement(query);
			psmt.setInt(1, Integer.parseInt(bno));
			
			rs = psmt.executeQuery();
			
			System.out.println(query);	
			
			while(rs.next()){
				sjo = new JSONObject();
				sjo.put("rno", rs.getInt("r_no"));
				sjo.put("content", rs.getString("r_content"));
				sjo.put("writer", rs.getString("r_writer"));
				sjo.put("reg_date", rs.getString("reg_date"));
				
				ja.add(sjo);
			}
			
			jo.put("result","200");
			jo.put("desc","select success");
			jo.put("list",ja);
			
		}catch(Exception e){
			jo.put("result", "300");
			jo.put("desc","select fail");
			e.printStackTrace();  // tomcat log에서 확인 
		}finally{
			if(conn != null){
				conn.close();
			}
			if(psmt != null){
				psmt.close();
			}
			if(rs != null){
				rs.close();
			}
			
			out.print(jo);
			out.flush();
		}
		
	}
%>