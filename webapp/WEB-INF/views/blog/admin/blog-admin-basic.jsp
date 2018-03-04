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
				
				<form class="form-horizontal" id="logochangeform" action="${pageContext.request.contextPath}/${authUser.id}/admin/logochange" method="post" enctype="multipart/form-data">
	 		      	<div class="form-group">
		      			<label class="col-sm-2 control-label" for="blog-title">블로그 제목</label>
		      			<div class="col-sm-10">
		      				<input type="text" class="form-control" id="blog-title" name="title" value="${bVo.blogTitle }">
		      			</div>
			      	</div>
			      	<div class="form-group">
			      		<label class="col-sm-2 control-label" for="logoimg">로고이미지</label>
			      		<div class="col-sm-10" id="logoimg">

			      		</div>
			      	</div>
 					<div class="form-group">
 						<label class="col-sm-2 control-label">로고 파일 설정</label>
 						<div class="col-sm-10">
			      			<input type="file" id="logofile" name="logo-file"> 						
 						</div>
 					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label" for="infochange">&nbsp;</label>
						<div class="col-sm-10">
							<input id="infochange" type="button" value="기본설정 변경">
						</div>
					</div>
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
			url : "${pageContext.request.contextPath}/${authUser.id}/logoselect",
			type : "post",
			contentType : "application/json",
			data : "${authUser.id}",
			
			dataType : "json",
			success : function(url){ /*성공시 처리해야될 코드 작성*/
				$("#logoimg")[0].innerHTML="<img style='height:300px;' src='${pageContext.request.contextPath}/"+url+"'>";
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
		});
	});
	
	$("#infochange").on("click", function(){
		var formData = new FormData(); //ajax를 통해서 파일을 전송하기 위해서 자바스크립트 내장 객체인 FormData 객체 생성
		
		console.log(document.getElementById("logofile")); //html 태그 형식 객체
		console.log($("#logofile")); //jquery 객체
		console.log($("#logofile")[0]); //html 태그 형식 객체 배열 0번째가 순수 html 객체(돔형) 를 담고있다...
		
		
		//타이틀 수정
		var blogtitle = $("#blog-title").val()
		formData.append("blog-title",blogtitle);

		$.ajax({
			url : "${pageContext.request.contextPath}/${authUser.id}/admin/blogupdate",
			type : "post",
			data : formData,
			contentType:false,
	        processData:false,
	        enctype : "multipart/form-data",
			
			dataType : "json",
			success : function(result){ /*성공시 처리해야될 코드 작성*/
				if(result==1){
					$("#headertitle")[0].innerHTML=blogtitle;
					console.log("블로그 타이틀 수정 성공")
				}else{
					console.log("블로그 타이틀 수정 실패");
				}
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
		});
		
		
		//로고 수정
		//formdata 클래스 객체에 담을때는 jquery 객체가 아닌 html 태그 형식 객체로 담아야 하는 것 같다.
		//formdata 클래스 객체에 append로 파일을 실어 보내지 않으면 계속 400 오류가 발생한다. get 방식 메소드를 쓰고있다는 말도안되는 오류.....
		//페이지 뿐만아니라 정상적으로 넘겨지는 파일이 없어도 발생하는 오류인거같다 삽질 시간낭비....우와웅
		var logofile = $("#logofile")[0].files[0];
		
		if(logofile==null){
			console.log("수정할 로고 파일 없음");
		}else{
			formData.append("logo-file",logofile); //앞에 파라미터 이름
			
			$.ajax({
				url : "${pageContext.request.contextPath}/${authUser.id}/admin/logochange",
				type : "post",
				data : formData,
				contentType:false,
		        processData:false,
		        enctype : "multipart/form-data",
				
				dataType : "json",
				success : function(url){ /*성공시 처리해야될 코드 작성*/
					$("#logoimg")[0].innerHTML="<img style='height:300px;' src='${pageContext.request.contextPath}/"+url+"'>";
				},
				
				error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
					console.error(status + " : " + error);
				}
				
			});
		}
	
	});
	
	
</script>
</html>