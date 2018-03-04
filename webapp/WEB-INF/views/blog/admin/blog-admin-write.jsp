<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> <!-- 최신 헤헤 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
</head>
<body>

	<div id="container">
		
		<!-- 블로그 해더 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-header.jsp"></c:import>
		<!-- /블로그 해더 -->
		
		<div id="wrapper">
			<div id="content">
				<ul class="list-group" style="height :25px; margin-top:5px; margin-bottom:5px;">
					<li style="float:left; margin-left:5px;"><a style="padding: 0 5px 0 5px;" class="list-group-item list-group-item-danger" href="${pageContext.request.contextPath}/${authUser.id}">내 블로그</a></li>
					<li style="float:left; margin-left:5px;"><a style="padding: 0 5px 0 5px;" class="list-group-item list-group-item-warning" href="${pageContext.request.contextPath}/${authUser.id}/admin/basic">기본설정</a></li>
					<li style="float:left; margin-left:5px;"><a style="padding: 0 5px 0 5px;" class="list-group-item list-group-item-info" href="${pageContext.request.contextPath}/${authUser.id}/admin/category">카테고리</a></li>
					<li style="float:left; margin-left:5px;"><a style="padding: 0 5px 0 5px;" class="list-group-item list-group-item-success" href="${pageContext.request.contextPath}/${authUser.id}/admin/write">글작성</a></li>
				</ul>
				
				<form action="${pageContext.request.contextPath}/${authUser.id}/admin/postadd" method="post">
			      	<table class="table table-striped table-hover" style="margin:5px">
			      		<tr>
			      			<td class="t">제목</td>
			      			<td>
			      				<input type="text" size="60" name="postTitle">
				      			<select id="category" name="cateNo">
				      			</select>
				      		</td>
			      		</tr>
			      		<tr>
			      			<td class="t" >내용</td>
			      			<td><textarea name="postContent" style="width:100%; height:300px;"></textarea></td>
			      		</tr>
			      		<tr>
			      			<td>&nbsp;</td>
			      			<td class="s"><input type="submit" value="포스트하기"></td>
			      		</tr>
			      	</table>
				</form>
			</div>
		</div>
		
		<!-- 푸터 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-footer.jsp"></c:import>
		<!-- 푸터 -->
		
	</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$.ajax({
			url : "${pageContext.request.contextPath}/${authUser.id}/admin/catelist",
			type : "post",
						
			dataType : "json",
			success : function(cList){ /*성공시 처리해야될 코드 작성*/
				for(var i=0; i<cList.length; i++){
					render(cList[i]);
				}
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
	});
	
	$("#category").on("click",function(){
		/* var cateNo = $(this).find("option:selected").data("cateno"); 1.select 태그의 선택된 옵션 value 값 가져오는 방법 */ 
		var cateNo = $(this).val(); // 2.select 태그의 선택된 옵션 value 값을 가져오는 방법
		console.log(cateNo);
	});
	
	function render(cVo){
		str = "<option id='b' value='"+cVo.cateNo+"'>"+cVo.cateName+"</option>"; // option 태그에 value 속성을 사용 하지 않으면 태그안에 있는 값을 자동으로 사용하도록 설계 되어있는 듯 하다
		
		$("#category").append(str);
	}
</script>
</html>