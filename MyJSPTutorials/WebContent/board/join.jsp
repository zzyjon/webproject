<%@ page contentType="text/html; charset=utf-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.Calendar" %>
<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<title>나의 홈페이지</title>
		<!-- Tell the browser to be responsive to screen width -->
		<jsp:include page="/include/top.jsp" />
		<script>
		(function(d, s, id) {
			  var js, fjs = d.getElementsByTagName(s)[0];
			  if (d.getElementById(id)) return;
			  js = d.createElement(s); js.id = id;
			  js.src = 'https://connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.11&appId=1476839772369959';
			  fjs.parentNode.insertBefore(js, fjs);
			}(document, 'script', 'facebook-jssdk'));
		</script>
		<script>

			function statusChangeCallback(response){
				console.log(response);
				
				if(response.status == "connected"){
					FB.api("/me", function(data){
						console.log(data);
						
						$.ajax({
							url : "procLogin.jsp",
							type : "post",
							dataType : "json",
							data : {"inputID" : data.name, "inputPW" : "" },
							success : function(data){
								console.log(data);
								if(data.result == "200"){
									location.href="MyMain.jsp";
								}
							},
							
							error : function(data){
								alert("error!");
							}
						});
					}); 
				}else{
					alert("앱에 로그인해주세요 \n관리자에게 문의 바랍니다.");
				}
			}
			
			function checkLoginState(){	
				FB.getLoginStatus(function(response){
					statusChangeCallback(response);
				
				});
			
			}
			

		  window.fbAsyncInit = function() {
			FB.init({
			  appId      : '1476839772369959',
			  cookie     : true,
			  xfbml      : true,
			  version    : 'v2.11'
			});
			  
			FB.AppEvents.logPageView();   
			  
		  };

		  //페이스북 버튼 한글버전
		  /*(function(d, s, id){
			 var js, fjs = d.getElementsByTagName(s)[0];
			 if (d.getElementById(id)) {return;}
			 js = d.createElement(s); js.id = id;
			 js.src = "https://connect.facebook.net/en_US/sdk.js";
			 fjs.parentNode.insertBefore(js, fjs);
		   }(document, 'script', 'facebook-jssdk'));
		   */
	   
		</script>
		<script type="text/javascript" >
		
			/*var current_effect = 'bounce';  // page loading type
		
			function run_waitMe(effect){

					$("#frmLogin").waitMe({

						effect : 'bounce',
						text : "잠시만 기다려주세요",
						bg : rgba(255,255,255,0.7),
						color : #000,
						maxSize : "",
						waitTime : -1,
						source : "",
						textPos : "vertical",
						fontSize : "",

					});
				
			}*/
			
			
			
		
			function doLogin(){
				$("#btnLogin").click(function(){
					
					$("#frmLogin").validate({
						rules:{
							inputId: {
								required : true,
								minlength : 5
							},
							
							inputPw: {
								required : true,
								minlength : 8
							}
							
						},
						messages:{
							inputId: {
								required : "아이디를 입력해주세요",
								minlength : "아이디는 5글자 이상 입력해주세요"
							},
							inputPw : {
								required : "비밀번호를 입력해주세요",
								minlength : "비밀번호는 8글자 이상 입력해주세요"
							}
						},
						
						submitHandler : function(form){
						
							var inputID = $("#inputID").val();
							var inputPW = $("#inputPW").val();
							
							//run_waitMe(current_effect); // spinner 로딩 시작
						
							$.ajax({
								url : "procLogin.jsp",
								type : "post",
								dataType: "json",
								data : {
									"inputID" : inputID,
									"inputPW" : inputPW},
								success : function(data){
									
									//$("#frmLogin").waitMe("hide");
									console.log(data);
									if(data.result == "200"){
										alert("로그인 됐습니다.");
										location.href="MyMain.jsp";
									}else{
										alert(data.desc);
									}
									
									var isCheck = $("#saveId").prop("checked");   // .prop("checked");체크박스에 체크가 됐는지 확인, true값을 반환함
									
									if(isCheck){
										$.cookie("inputID" , inputID);
									}else{
										$.removeCookie("inputID"); 	// 쿠키를 삭제 함
									}
								},
								
								error : function(data){
									alert("잠시후 다시 시도해주세요.");
								}
								
							});
						}
						
					});
				});
			}
			
			function idCheck() {
			 $("#btnLogin").click(function(){
				$( "#frmLogin" ).rules( "add", {
				  required: true,
				  minlength: 2,
				  messages: {
					required: "Required input",
					minlength: jQuery.validator.format("Please, at least {0} characters are necessary")
				  }
				});
			 });	
			}
		
			$(document).ready(function(){
				var inputID = $.cookie("inputID");
				
				if(inputID != undefined){
					$("#saveId").prop("checked","checked");
					$("#inputID").val(inputID);
					
				}
			
				doLogin();
			});
		</script>
		
		<style>
			#frmLogin label.error {color : red}
		</style>
		
	</head>
	<body>
		<!-- Horizontal Form -->
          <div class="box box-info">
            <div class="box-header with-border">
              <h3 class="box-title">로그인</h3>
            </div>
            <!-- /.box-header -->
            <!-- form start -->
            <form class="form-horizontal" id="frmLogin">
              <div class="box-body">
				<!-- select -->
				<div class="form-group">
                  <label for="inputID" class="col-sm-4 control-label">아이디</label>
                  <div class="col-sm-4">
                    <input type="text" class="form-control" id="inputID" placeholder="아이디를 입력해주세요" name="inputId" required >
                  </div>
                </div>
                <div class="form-group">
				  <label for="inputID" class="col-sm-4 control-label">비밀번호</label>
                  <div class="col-sm-4">
                    <input type="password" class="form-control" id="inputPW" name="inputPw" placeholder="비밀번호를 입력해주세요">
                  </div>
                </div>
				<div class="form-group">
					<label class="col-sm-4 control-label"></label>
					<div class="checkbox col-sm-1">
						<input type="checkbox" id="saveId" value="save" >아이디 저장</input>
					</div>
				</div>
              </div>
              <!-- /.box-body -->
              <div class="form-group">
				<div class="col-sm-offset-4 col-sm-4">
                <button type="submit" class="btn btn-block btn-success btn-lg" id="btnLogin" >로그인</button>
				</div>
              </div>
              <!-- /.box-footer -->
			  
			  <!-- 페이스북 버튼 시작 -->
			  <div class="form-group" >
				<div class="col-sm-offset-4 col-sm-5">
					<div class="fb-login-button" data-max-rows="1" data-size="large" data-button-type="continue_with" data-show-faces="false" data-auto-logout-link="false" data-use-continue-as="false" onlogin="checkLoginState();"></div>
				</div>
			  </div>
			  <!-- 페이스북 버튼 종료 -->
			  
            </form>
          </div>		
	</body>
</html>