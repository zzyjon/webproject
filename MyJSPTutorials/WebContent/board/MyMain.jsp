<%@ page contentType="text/html; charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>My Main page</title>
		<!-- Tell the browser to be responsive to screen width -->
		<%@ include file="/include/top.jsp" %>
	</head>
	<body class="hold-transition skin-red layout-top-nav">
	<div class="wrapper">

		<!-- Main Header -->
		<header class="main-header">


			<!-- Header Navbar -->
			<nav class="navbar navbar-static-top" role="navigation">

				<!-- Logo -->
				<a href="MyMain.jsp" class="logo"> <!-- mini logo for sidebar mini 50x50 pixels -->
					<span class="logo-mini"><b>A</b>LT</span> <!-- logo for regular state and mobile devices -->
					<span class="logo-lg"><b>LSM</b>HOME</span>
				</a>

				<!-- Navbar Right Menu -->
				<div class="navbar-custom-menu">
					<!-- 방법 jstl -->
					<c:choose>
						<c:when test="${empty sessionScope.id}">
							<a href="join.jsp">[로그인]</a>
						</c:when>
						<c:otherwise>
								${sessionScope.id} 로그인 했습니다. <a class="btn btn-flat"
								href="procLogOut.jsp"> [로그아웃] </a>
						</c:otherwise>
					</c:choose>
					<!-- 방법 -->
<%
					/*
					String id = (String)session.getAttribute("id");
					
					if(id != null){
						out.print(id+"님 로그인 했습니다");
						out.print("<a href='procLogOut.jsp'> ");
						out.print("[로그아웃]");
						out.print("</a>");
					}else{
						out.print("<a href='join.jsp'>");
						out.print("[로그인]");
						out.print("</a>");
					}
					*/
%>
				</div>
			</nav>
		</header>
		<!-- Left side column. contains the logo and sidebar -->

		<!-- Content Wrapper. Contains page content -->
		<div class="content-wrapper">
			<!-- Content Header (Page header) -->
			<section class="content-header">
				<h1>
					Page Header <small>Optional description</small>
				</h1>
				<ol class="breadcrumb">
					<li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
					<li class="active">Here</li>
				</ol>
			</section>

			<!-- Main content -->
			<section class="content container-fluid">
			    <!--------------------------
		         | Your Page Content Here |
			     -------------------------->
				메인
			</section>
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->

		<!-- Main Footer -->
		<%@ include file="/include/footter.jsp"%>
	</div>	
</body>
</html>