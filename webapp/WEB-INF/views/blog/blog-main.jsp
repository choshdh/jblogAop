<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JBlog</title>
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/js/jquery/jquery-1.12.4.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/jblog.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css"> <!-- 최신 헤헤 -->
<script type="text/javascript" src="${pageContext.request.contextPath}/assets/bootstrap/js/bootstrap.js"></script>
<script src="${pageContext.request.contextPath }/assets/cookie/jquery.cookie.js"></script>

</head>
<body>

	<div id="container">

		<!-- 블로그 해더 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-header.jsp"></c:import>
		<!-- /블로그 해더 -->
		
		<div id="wrapper">
			<div id="content">
				<div>
					<!-- 메인 포스트 -->
					<div class="blog-content panel panel-danger" style="margin-top:10px; margin-bottom:10px; padding:0;">
						<div class="panel-heading">포스트 제목</div>
	  					<div class="panel-body">포스트 내용</div>
	  					
	  					<!-- 댓글 -->
						<table id="comments" style="width: 100%; padding:5px; height:25px;" class="table table-striped table-hover">
						</table>
						<!-- 댓글 -->
					</div>
					<!-- 메인 포스트 -->
					
					
					
					
					<!-- 댓글 추가 -->
					<div id="commentsendtable" style="display: none">
						<table id="tcomment" style="width: 100%;">
							<tr style="width: 100%">
								<th style="width: 15%; height: 100%; padding: 0 5px 0 5px">작성자</th>
								<th style="width: 70%; height: 100%; padding: 0 5px 0 5px">댓글 내용</th>
								<th style="width: 15%; height: 100%; padding: 0 5px 0 5px"></th>
							</tr>
							<tr style="width: 100%">
								<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">
									<input type="text" id="username" style ="width:100%; height: 100%;" readonly="readonly" value="${authUser.userName }">
								</td>
								<td style="width: 70%; height: 100%; padding: 0 5px 0 5px">
									<input type="text" id="comment" style ="width:100%; height: 100%;">
								</td>
								<td style="width: 15%; height: 100%; padding: 0 5px 0 5px">
									<input type="button" id="commentadd" value="댓글달기" style ="width:100%; height: 100%;">
								</td>
							</tr>
						</table>
					</div>
					<!-- 댓글 추가 -->
					
					
				</div>
				
				<!-- 포스트 리스트 -->
				<ul id="bl" class="blog-list">
				</ul>
				<!-- 포스트 리스트 -->
				
			</div>
		</div>

		<div id="extra">
			<!-- 블로그 로고 -->
			<div id="bloglogo" class="blog-logo" style="margin-top:10px;">
			
			</div>
			<!-- 블로그 로고 -->
		</div>

		<!-- 카테고리 리스트 -->
		<div id="navigation">
			<h2>카테고리</h2>
			<ul id="catelist">
				<li data-no="-1">전체</li>
				
			</ul>
		</div>
		<!-- 카테고리 리스트 -->
		
		
		<!-- hover 용 div -->
		<div style="font-weight:bold; padding:10px; background-color:white; border:1px solid #5D5D5D; border-radius: 5px 5px 5px 5px; width:300px; height:100px; z-index:10; display:none; z-index:10;" id=hdiv></div>
		<!-- popup 차단을 피하기위해서 div로 popup창 대체 -->
		<div style="font-weight:bold; padding:10px; background-color:white; border:1px solid #5D5D5D; border-radius: 5px 5px 5px 5px; display:none; z-index:10;" id=pop>
			Jblog 에 오신 것을 환영합니다.<br>
			팝업차단을 피하기 위해서<br>
			div 를 사용하였습니다.<br>
		 	 블로그의 사진 사용을 위해서 <br>
		 	 spring-servlet.xml 파일과<br>
		 	 LogoService 의<br>
		 	  저장 폴더의 수정이 필요합니다.<br>
		 	 테스트에 사용하실 수지 이미지 4개는 assets/images에 넣어두었습니다.<br>
		 	 저장될 폴더에 붙여넣어 사용하시면됩니다.<br>
			<label for="check">오늘 하루 이창 열지 않음</label>
			<input type="checkbox" id="check"/>
			<input type="button" id=bt value="닫기">
		</div>
			
		<!-- 푸터 -->
		<c:import url="/WEB-INF/views/blog/includes/blog-footer.jsp"></c:import>
		<!-- 푸터 -->
		
	</div>
</body>

<script type="text/javascript">
	var pListSave; //포스트 리스트
	var cListSave; //카테고리 리스트
	var pTotal; //전체 포스트 수
	var cTotal; //전체 카테고리 수
	var selectPostNo = -999; //현재 선택된 포스트 번호 임의값 -999로 초기화
	
	
	
	//페이지 시작시 바로 실행
	$(document).ready(function(){
		$("#check").click(function(){
  			//쿠기값을 "Y"로 하여 하루동안 저장시킴
			$.cookie("nopopup","Y",{expires:1});
			$("#pop").css({"display":"none"});	
		});
  		
  		$("#bt").click(function(){
  			$("#pop").css({"display":"none"});
  		})
		
		if($.cookie("nopopup")!="Y"){
			console.log("쿠키 div 보이기");
			var wsize = 310;
			var hsize = 250;
			var LeftPosition = (screen.width-wsize)/2;
			var TopPosition = (screen.height-hsize)/2-120;
			$("#pop").css({"display":"block","width":wsize,"height":hsize ,"position":"absolute","left":LeftPosition,"top":TopPosition});
		}
		
		//포스트 리스트 그리기
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/admin/postlist",
			type : "post",		
			
			dataType : "json",
			success : function(pList){ /*성공시 처리해야될 코드 작성*/
				pListSave = pList;
				pTotal = pList.length;
				for(var i=0; i<pList.length; i++){
					if(i==0){
						mainpost(pList[0]);
						selectPostNo = pList[0].postNo;
						
						commentload(selectPostNo);
					}
					postrender(pList[i] , i);
				}
			
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
		
		//카테고리 리스트 그리기
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/admin/catelist",
			type : "post",		
			
			dataType : "json",
			success : function(cList){ /*성공시 처리해야될 코드 작성*/
				cListSave = cList;
				cTotal = cList.length;
				for(var i=0; i<cList.length; i++){
					caterender(cList[i] , i);
				}
			
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		});
		
		//로고 그리기
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/logoselect",
			type : "post",
			contentType : "application/json",
			data : "${requestScope.id}",
			
			dataType : "json",
			success : function(url){ /*성공시 처리해야될 코드 작성*/
				$("#bloglogo")[0].innerHTML="<img style='width:180px' src='${pageContext.request.contextPath}/"+url+"'>";
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
		});
		
	});
	
	
	///////////////////////////////////////////////////////
	
	//카테고리 마우스 hover 시
	//동적으로 생성된 li 객체에  hover 이벤트를 사용 할 수 있는 방법을 찾아도 나와있지를 않아서 mouse 이벤트 2개를 동시에 넣고 발생되는 이벤트에 따라서 css 추가함
	$("#catelist").delegate("li","mouseenter mouseleave", function(event) { 
		x = $(this).position().left;
		y = $(this).position().top;
		var index = $(this).data("no");
		if(index==-1){
			$("#hdiv")[0].innerHTML="전체 포스트 수 : "+pTotal;
		}else{
			$("#hdiv")[0].innerHTML="카테고리 : "+cListSave[index].cateName+"<br>카테고리 설명 : "+cListSave[index].description+"<br>카테고리 포스트 수 : "+cListSave[index].postCnt;
		}
	    $("#hdiv").css({"display":"block","position":"absolute","left":x+100,"top":y}).toggle( event.type === 'mouseenter' );  
	});
	
	//카테고리 클릭시 해당 포스트만 보여주기
	$("#catelist").delegate("li","click", function(){
		$(".blog-list").children().remove();
		var index = $(this).data("no");
		
		selectPostNo = -999; //선택한 포스트 번호를 받아오기전에 항상 초기화
		
		if(pListSave==null){ // 포스트가 하나도 없을떄
			$(".blog-content").children()[0].innerHTML="";
			$(".blog-content").children()[1].innerHTML="";
		}else{ //포스트가 하나라도 있을때
			
			if(index==-1){ //전체 카테고리 선택시
				for(var i=0; i<pListSave.length; i++){
					if(i==0){ //blog-content 내용을 해당 카테고리의 첫번째글로 업데이트 해주기 
						mainpost(pListSave[0]);
						selectPostNo = pListSave[0].postNo;
					}
					postrender(pListSave[i] , i);
				}
			}else{ //다른 카테고리 선택시
				var printfirst = 1; //전체 카테고리와 다르게 선택적 카테고리에서 첫번째 포스트만 창에 띄우기 위해서 변수 사용
				for(var i=0; i<pListSave.length; i++){
					if(cListSave[index].cateNo==pListSave[i].cateNo){
						if(printfirst ==1){ //blog-content 내용을 해당 카테고리의 첫번째글로 업데이트 해주기 
							mainpost(pListSave[i]);
							selectPostNo = pListSave[i].postNo;
							printfirst = -99999;
							console.log(selectPostNo);
						}
						postrender(pListSave[i] , i);
					}
				}
			}

		}
		
		commentload(selectPostNo);
	});
	
	
	//클릭한 포스트 내용 보여주기
	$(".blog-list").on("click","li", function(){
		var index = $(this).data("no");
		mainpost(pListSave[index]);
		
		selectPostNo = pListSave[index].postNo;
		
		commentload(selectPostNo);
	});
	
	//댓글 추가 버튼 클릭시
	$("#commentadd").on("click",function(){
		
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/commentadd",
			type : "post",
			data : {
				postNo : selectPostNo,
				cmtContent : $("#comment").val()
			},
			
			dataType : "json",
			success : function(comment){ //추가한 댓글 다른색으로 표시
				console.log(comment);
				var str =
					"<tr style='width: 100%;'>"+
						"<td style='width: 10%; height: 100%; padding: 0 5px 0 5px'>"+"${authUser.userName}"+"</td>"+
						"<td style='width: 70%; height: 100%; padding: 0 5px 0 5px'>"+comment.cmtContent+"</td>"+
						"<td style='width: 15%; height: 100%; padding: 0 5px 0 5px'><span class='label label-warning'>new</span></td>"+
						"<td style='width: 5%; height: 100%; padding: 0 5px 0 5px'><span id='del' data-postno='"+selectPostNo+"' data-cmtno='"+comment.cmtNo+"'class='label label-default' style='cursor:pointer'>Del</span></td>"+
					"</tr>";
				$("#comments").prepend(str);
				
				$("#comment").val("");
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
			
		});
	});
	
	$("#comments").on("click","#del",function(){
		var thisCmt = $(this).parent().parent();
		var postNo = $(this).data("postno");
		var cmtNo = $(this).data("cmtno");
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/commentdel",
			type : "post",
			data : {postNo : postNo, cmtNo : cmtNo},
			
			dataType : "json",
			success : function(result){ /*성공시 처리해야될 코드 작성*/
				console.log("댓글 삭제 요청 결과 : " + result);
				if(result ==1){
					thisCmt.remove();
					console.log("댓글 삭제 성공");
				}else{
					console.log("댓글 삭제 실패");
				}
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		})
	});
	
	//메인 포스트
	function mainpost(p){
		$(".blog-content").children()[0].innerHTML=p.postTitle;
		$(".blog-content").children()[1].innerHTML=p.postContent;
	}
	
	//포스트 그리기 함수
	function postrender(pVo , i){
		str = "<li data-no='"+i+"' data-cateno='"+pVo.postNo+"'>"+pVo.postTitle+"<span>"+pVo.regDate+"</span></li>";
		
		$(".blog-list").append(str);
	}
	
	//카테고리 그리기 함수
	function caterender(cVo , i){
		str = "<li data-no='"+i+"'>"+cVo.cateName+"</li>";
		
		$("#catelist").append(str);
	}
	
	//댓글 로드 함수
	function commentload(postNo){
		$.ajax({
			url : "${pageContext.request.contextPath}/${requestScope.id}/commentlist",
			type : "post",
			data : {postNo : postNo},
			
			dataType : "json",
			success : function(comments){ /*성공시 처리해야될 코드 작성*/
				console.log(comments);
				$("#comments").children().remove(); //기존에 있는 댓글들 지우고 다시 작성해야하기 때문에
				for(var i=0; i<comments.length; i++){
					var str =
						"<tr style='width: 100%;'>"+
							"<td style='width: 10%; height: 100%; padding: 0 5px 0 5px'>"+comments[i].USERNAME+"</td>"+
							"<td style='width: 70%; height: 100%; padding: 0 5px 0 5px'>"+comments[i].CMTCONTENT+"</td>"+
							"<td style='width: 15%; height: 100%; padding: 0 5px 0 5px'>"+comments[i].REGDATE+"</td>"+
							"<td style='width: 5%; height: 100%; padding: 0 5px 0 5px'>";
					if( "${authUser.userNo}" == comments[i].USERNO ){
						str += "<span id='del' data-postno='"+postNo+"' data-cmtno='"+comments[i].CMTNO+"' class='label label-default' style='cursor:pointer'>Del</span>";
					}
						str +="</td></tr>";
					$("#comments").append(str);
				}
				
				if(selectPostNo==-999){
					$(".blog-content").children()[0].innerHTML="포스트가 존재 하지 않습니다.";
					$(".blog-content").children()[1].innerHTML="";
					$("#commentsendtable").hide(); //보여지는 포스트가 없을때 숨기기
				}else{
					if( ${!empty authUser} ){ // 로그인한 유저일때만
						$("#commentsendtable").show(); //보여지는 포스트가 있을때만 댓글작성 보이기
					}
				}
			},
			
			error : function(XHR, status, error) { /*실패시 처리해야될 코드 작성*/
				console.error(status + " : " + error);
			}
		})
	}
	
	

</script>
</html>