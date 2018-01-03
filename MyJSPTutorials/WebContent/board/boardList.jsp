<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=utf-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	// 데이터베이스 
	//Class.forName("com.mysql.cj.jdbc.Driver");

	Connection conn = null;
	PreparedStatement psmt = null;
	ResultSet rs = null;
	
	String url = "jdbc:mysql://localhost:3306/mysqltest?verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
	String user = "root";
	String password = "1q2w3e";
	String query = "";
	query += "SELECT b_no, b_title, b_read_cnt, reg_date \n";
	query += "FROM board \n";
	query += "ORDER BY reg_date desc\n";
	
	System.out.print(query);
	
	try{
		conn = DriverManager.getConnection(url, user, password);
		psmt = conn.prepareStatement(query);
		rs = psmt.executeQuery();
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>board List</title>
	<jsp:include page="/include/top.jsp" />
</head>
<body>
	<div class="box box-info">
		<div class="box-header with-border">
              <h3 class="box-title">글 리스트</h3>
        </div>
        <div class="box-body">
        	<table class="table table-bordered">
        		<tr>
        			<th>번호</th>
        			<th>제목</th>
        			<th>조회수</th>
        			<th>등록일</th>
        		</tr>
        		<%
        			int no = 0;
        			while(rs.next()){
        				no++;
        		%>
        			<tr>
        				<td> <%= no %></td>
        				<td><a href="/board/boardView.jsp?no=<%= rs.getInt("b_no")%>" ><%= rs.getString("b_title") %> </a></td>
        				<td> <%= rs.getInt("b_read_cnt") %></td>
        				<td> <%= rs.getString("reg_date") %></td>
        			</tr>
        		<%
        			}
        		%>
        	</table>
        </div>
	</div>
</body>
</html>
<%		
	}catch(Exception e){
		e.printStackTrace();
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
	}
	
%>