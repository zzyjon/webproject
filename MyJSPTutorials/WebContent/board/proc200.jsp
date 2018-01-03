<%@ page contentType="text/html; charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page import="org.apache.commons.fileupload.*" %>
<%@ page import="org.apache.commons.fileupload.servlet.*" %>
<%@ page import="org.apache.commons.fileupload.disk.*" %>
<%
	request.setCharacterEncoding("utf-8");
	JSONObject jo = new JSONObject();
	
	//사용자 로그인 체크
	String id = (String)session.getAttribute("id");
	
	if(id == null){
		jo.put("result","101");
		jo.put("desc","login is not");
	}else{
	
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		
		//out.print(isMultipart);
		
		if(isMultipart){
			
			// Create a factory for disk-based file items
			DiskFileItemFactory factory = new DiskFileItemFactory();
	
			// Set factory constraints
			factory.setSizeThreshold(1000000*50);
			String tmpDir = "C:/apache-tomcat-8.5.23/webapps/JSP/uploadtemp";
			
			File fileTmpDir = new File(tmpDir);
			
			if(!fileTmpDir.exists()){   // 파일이 존재하는지 확인 
				fileTmpDir.mkdir();		// 존재하지 않으면 디렉토리 생성
			}
			
			factory.setRepository(fileTmpDir);
	
			// Create a new file upload handler
			ServletFileUpload upload = new ServletFileUpload(factory);
	
			// Set overall request size constraint  (전체 용량)
			upload.setSizeMax(1000000*40);
	
			// Parse the request
			List<FileItem> items = upload.parseRequest(request);
			
			// Process the uploaded items
			Iterator<FileItem> iter = items.iterator();
			
			// DB 처리 
			Class.forName("com.mysql.cj.jdbc.Driver");
			
			Connection conn = null;
			PreparedStatement psmt = null;
			
			String url = "jdbc:mysql://localhost:3306/mysqltest?verifyServerCertificate=false&useSSL=false&serverTimezone=UTC";
			String user = "root";
			String password = "1q2w3e";
			String query = "";
			
			query += "INSERT INTO board ";
			query += "(b_title,b_content,b_image,b_tag,b_open,b_password,b_reply,reg_date,b_read_cnt) ";
			query += "VALUES ";
			query += "(?,?,?,?,?,?,?,?,?)";
			
			conn = DriverManager.getConnection(url, user, password);
			psmt = conn.prepareStatement(query);
			String ext ="";
						
			while (iter.hasNext()) {
				FileItem item = iter.next();
	
				// 일반적인 form의 데이터 ex: title , tag 
				if (item.isFormField()) {
					String name = item.getFieldName();
					String value = item.getString();
					jo.put(name,value);
				} else {
					// file 데이터
					//processUploadedFile(item);
					
					String fieldName = item.getFieldName();
					String fileName = item.getName();
					String contentType = item.getContentType();
					boolean isInMemory = item.isInMemory();
					long sizeInBytes = item.getSize();
					
					if("image/jpeg".equals(contentType) || "image/png".equals(contentType) || "image/gif".equals(contentType)){
						
						String uploadDir = "C:/apache-tomcat-8.5.23/webapps/JSP/upload";
					
						File fileUploadDir = new File(uploadDir);
						
						if(!fileUploadDir.exists()){
							fileUploadDir.mkdir();
							
							jo.put("fileName",fileName);
							jo.put("contentType",contentType);
							jo.put("fileSize",sizeInBytes);	
							
						}else{
							jo.put("result","302");
							jo.put("desc","Over file Size");
							break;
						}
						
						String uploadDir = uploadDir + "/" + fileName;
						
						
						File uploadedFile = new File(uploadDir);
						item.write(uploadedFile);
						
						jo.put("fileName",fileName);
						jo.put("contentType",contentType);
						jo.put("fileSize",sizeInBytes);
						
					}else{
						jo.put("result","301");
						jo.put("desc","Don't allow file type");
						break;
					}
					
					String uploadDir = "C:/apache-tomcat-8.5.23/webapps/JSP/upload";
					
					File fileUploadDir = new File(uploadDir);
					
					if(!fileUploadDir.exists()){
						fileUploadDir.mkdir();
					}
					
					String uploadDir = uploadDir + "/" + fileName;
					
					File uploadedFile = new File(uploadDir);
					item.write(uploadedFile);
					
					jo.put("fileName",fileName);
					jo.put("contentType",contentType);
					jo.put("fileSize",sizeInBytes);
					
				}
			}
			
			if( jo.get("result") = null){
				
				// DB 입력
				psmt.setString(1, (String)jo.get("inputTitle"));
				psmt.setString(2, (String)jo.get("inputContent"));
				psmt.setString(3, "/upload/" + (String)jo.get("convertFileName")+ "." + ext);
				psmt.setString(4, (String)jo.get("inputTag"));
				psmt.setString(5, "Y");
				psmt.setString(6, "");
				psmt.setString(7, (String)jo.get("inputReplyYN"));
				psmt.setInt(8, 0);
				
				psmt.executeUpdate();
				
				jo.put("result","200");
				jo.put("desc","success");
			}
			
		}else{
			
			jo.put("result","300");
			jo.put("desc","multipart is not");
		}
	}
	out.print(jo);
	out.flush();
	
%>