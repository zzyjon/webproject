<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="java.sql.*" %>
<%
	String content = request.getParameter("content");
	String writer = request.getParameter("writer");
	String bno = request.getParameter("bno");
	
	JSONObject jo = new JSONObject();
	
	// login check
	String id = (String)session.getAttribute("id");
	if(id == null){
		jo.put("result","101");
		jo.put("desc","로그인 해주세요");
		out.print(jo);
		out.flush();
	}else{
		// DB Connection
		//Class.forName("com.mysql.cj.jdbc.Driver");
		
		Connection conn = null;
		PreparedStatement psmt = null;
		
		
		String url = "jdbc:mysql://localhost:3306/mysqltest?verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
		String user = "root";
		String password = "1q2w3e";
		String query = "";
			query += "INSERT INTO reply \n";
			query += "(b_no, r_content, r_writer, reg_date) \n";
			query += "VALUES \n";
			query += "(?, ?, ?, current_timestamp)";
		
		try{
			conn = DriverManager.getConnection(url, user, password);
			psmt = conn.prepareStatement(query);
			psmt.setInt(1,Integer.parseInt(bno));
			psmt.setString(2, content);
			psmt.setString(3, writer);
			psmt.executeUpdate();
			
			jo.put("result","200");
			jo.put("desc","댓글 등록 완료");
		}catch(Exception e){
			jo.put("result","301");
			jo.put("desc","댓글 등록 실패");
			e.printStackTrace();
		}finally{
			if(conn != null){
				conn.close();
			}
			if(psmt != null){
				psmt.close();
			}
			
			out.print(jo);
			out.flush();
		}
		
	}
	
%>
