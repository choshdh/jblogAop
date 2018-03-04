<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
</head>
<body>
	<div class="center-content">
				
		<!-- 메인해더 -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
 		<!-- /메인해더 -->
		
		<p class="welcome-message">
			<span> 존재하지 않는 블로그 입니다.</span>
			<br><br>
			<a href="${pageContext.request.contextPath}/user/loginform">로그인 하기</a>
		</p>
		
	</div>
</body>
</html>
