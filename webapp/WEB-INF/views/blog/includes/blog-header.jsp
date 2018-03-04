<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="header" class="progress-bar progress-bar-danger progress-bar-striped active" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
	<h1 id="headertitle">${bVo.blogTitle }</h1>
	<ul>
		<c:choose>
			<c:when test="${ empty sessionScope.authUser }">
				<!-- 로그인 전 메뉴 -->
				<li><a href="${pageContext.request.contextPath}/user/loginform">로그인</a></li>
			</c:when>
			
			<c:otherwise>
				<!-- 로그인 후 메뉴 -->
				<li><a href="${pageContext.request.contextPath}/user/logout">로그아웃</a></li>
				<c:if test="${authUser.id == requestScope.id }">
					<li><a href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">내블로그 관리</a></li>
				</c:if>
			</c:otherwise>
		</c:choose>
	</ul>
</div>