<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
</head>
<body>
	<div class="center-content">
		
		<!-- 메인해더 -->
		<c:import url="/WEB-INF/views/includes/header.jsp"></c:import>
 		<!-- /메인해더 -->
 		
 		
 		<!-- param -->
		<!-- name : userName,id,password,agreeProv -->
		<!-- id : id,btn-checkid,agree-prov -->
		<form class="join-form" id="join-form" name="joinform" method="post" action="${pageContext.request.contextPath}/user/join">
			<label class="block-label" for="name">이름</label>
			<input type="text" id="userName" name="userName"  value="" />
			
			<label class="block-label" for="id">아이디</label>
			<input id="id" type="text" name="id"  value="" />
			<input id="btn-checkid" type="button" value="id 중복체크">
			<input id="idcheckresult" type="text" style="border-width : 0px ; font-weight:bold;" readonly="readonly" value="중복 체크가 필요합니다.">
			<img id="img-checkid" style="visibility: hidden;" src="${pageContext.request.contextPath}/assets/images/check.png">
			<p class="form-error">
			</p>

			<label class="block-label" for="password">패스워드</label>
			<input type="password" id="password" name="password"  value="" />

			<fieldset>
				<legend>약관동의</legend>
				<input id="agree-prov" type="checkbox" name="agreeProv" value="y">
				<label class="l-float">서비스 약관에 동의합니다.</label>
			</fieldset>

			<input id="send" type="button" value="가입하기"> <!-- submit() 함수를 사용하기 위해서는 절대 id 값을 submit 이라고 선언 해서는 안된다 ************ -->

		</form>
	</div>

</body>

	<script type="text/javascript">
		var idcheckresult = 0;
		$("#btn-checkid").on("click",function(){
			var id = $("#id").val();
			console.log("id 중복 체크 버튼");
			
			//ajax 를 사용 하기위해서 필요한 포맷
			$.ajax({

				url : "${pageContext.request.contextPath }/user/api/idcheck",
				type : "post",
				contentType : "application/json", //json 형태로 바디에 담에 보내겠다고 타입 지정
				data : JSON.stringify(id), //단일 String 으로 requestbody 를 통해 받으려면 직접 넣어야함 {id : id}객체화 시키는순간 새로운 클래스를 만든것과 같기 때문에
										   //map을 쓰거나 getter setter 가 있는 클래스를 정의해놓지 않는이상 받을 수 없다.
				
				dataType : "json",
				success : function(result){ /*성공시 처리해야될 코드 작성*/
					if(result == true){
						$("#idcheckresult").css("color","blue");
						$("#idcheckresult").val("사용가능한 이메일입니다.");
						$("#img-checkid").css("visibility","visible");
						idcheckresult = 1;
					}else{
						$("#idcheckresult").css("color","red");
						$("#idcheckresult").val("사용중인 이메일입니다.");
						$("#img-checkid").css("visibility","hidden");
					}
				},
				
				
				error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
					/* console.error(status + " : " + error); */
				}
			});
			
		});
		
		$("#id").keydown(function(){
			$("#idcheckresult").css("color","black");
			$("#idcheckresult").val("중복 체크가 필요합니다.");
			$("#img-checkid").css("visibility","hidden");
			idcheckresult = 0;
		});
		
		$("#send").on("click",function(){
			var id = $("#id").val();
			var userName = $("#userName").val();
			var password = $("#password").val();
			var agreeProv = $("#agree-prov").is(":checked");
			if(!id || !userName || !password || !agreeProv){
				console.log(id);
				console.log(userName);
				console.log(password);
				console.log(agreeProv);
				alert("빠짐없이 모두 기입 해주십시오");
			}else{
				if(idcheckresult==0){
					alert("아이디 중복 체크가 필요합니다.");
				}else{					
					joinform.submit();  //submit() 함수를 사용하기위해서는 절대 id값과 중복되는 name속성 값이 존재 해서는안된다
				}
			}
		});
		
		
	</script>
</html>