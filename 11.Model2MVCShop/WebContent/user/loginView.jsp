<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>로그인 화면</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- 카카오 로그인 -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- 네이버 로그인 -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<!-- 페이스북 로그인 -->
<script src="https://connect.facebook.net/en_US/sdk.js"></script>
<!-- 구글 로그인 -->
<script src="https://apis.google.com/js/client:platform.js?onload=renderButton" async defer></script>
<meta name="google-signin-client_id" content="1089144671013-46avnp2olvffg3g00lbdlpu3j7arps1q.apps.googleusercontent.com"></meta>

<style>
	body > div.comtainer{
		border : 3px solid #D6CDB7;
		margin-top : 10px;
	}
</style>

<script type="text/javascript">
	function fncLogin(){
		var id = $("input:text").val();
		var pw = $("input:password").val();
			
		if(id==null || id.length<1){
			alert('아이디를 입력하지 않으셨습니다.');
			$("input:text").focus();
			return;
		}
			
		if(pw==null || pw.length<1){
			alert('패스워드를 입력하지 않으셨습니다.');
			$("input:password").focus();
			return;
		}
		
		$.ajax({
			url : "/user/json/login",
			method : "POST",
			dataType : "json",
			headers : {
				"Accept" : "application/json",
				"Content-Type" : "application/json"
			},
			data : JSON.stringify({
				userId : id,
				password : pw
			}),
			success : function(JSONData, status){
				
				if(JSONData.userId != "none"){
					
					if( JSONData.password == $("#password").val() ){
						$("form").attr("method","POST").attr("action","/user/login").attr("target","_parent").submit();
						//[방법1]
						//$(window.parent.document.location).attr("href","/index.jsp");
						//[방법2]
						//window.parent.document.location.reload();
						//[방법3]
						//$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
						//$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
						//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
					}else{
						$("#message").text("비밀번호를 다시 확인해주세요.").css("color", "red");
						$("#password").val("").focus();
					}
					
				}else{
					$("#userId").val("").focus();
					$("#password").val("");
					$("#message").text("아이디, 패스워드를 다시 확인해주세요.").css("color", "red");
				}
			}
		}); //e.o.ajax
	}//e.o.fncLogin()
	
	$(function(){
		$("#userId").focus();
		
		//로그인 엔터키 처리
		$("#userId, #password").keypress(function(event){
			if(event.which==13){
				fncLogin();
			}
		});

		$("button").on("click", function(){
			fncLogin();
		});

		$("a.btn.btn-primary.btn").on("click", function(){
			self.location="/user/addUser";
		});
		
	});

	//카카오 로그인
	$(function(){
		Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
		
		$("#kakao-login-btn").on("click", function(){
			//1. 로그인 시도
			Kakao.Auth.login({
		        success: function(authObj) {
		          //console.log(JSON.stringify(authObj));
		          //console.log(Kakao.Auth.getAccessToken());
		        
		          //2. 로그인 성공시, API를 호출합니다.
		          Kakao.API.request({
		            url: '/v1/user/me',
		            success: function(res) {
		              //console.log(JSON.stringify(res));
		              res.id += "@k";
		              
		              $.ajax({
		            	  url : "/user/json/checkDuplication/"+res.id,
		            	  headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				  },
		  				  success : function(idChk){
		  					  
		  					  if(idChk==true){ //DB에 아이디가 없을 경우 => 회원가입
		  						  console.log("회원가입중...");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
  		  								userId : res.id,
		  								userName : res.properties.nickname,
  		  								password : "kakao",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("회원가입이 정상적으로 되었습니다.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ //DB에 아이디가 존재할 경우 => 로그인
		  						  console.log("로그인중...");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		            },
		            fail: function(error) {
		              alert(JSON.stringify(error));
		            }
		          });
		          
		        },
		        fail: function(err) {
		          alert(JSON.stringify(err));
		        }
		      });
		})
	})//e.o.kakao
	
	//네이버 로그인
	$(function(){
   		var naverLogin = new naver.LoginWithNaverId({
			clientId: "NqLY8zfxRnZIl3CjoL1a",
			callbackUrl: "http://192.168.0.69:8080/user/naverCallback.jsp",
			isPopup: true,
			loginButton: {color: "green", type: 3, height: 45}
		});
		naverLogin.init();
	})//e.o.naver
	
	//페이스북 로그인	
	$(function(){
	    FB.init({
	        appId            : '141283403397328',
	        autoLogAppEvents : true,
	        xfbml            : true,
	        version          : 'v3.0'
	    });
			    
 		$("#facebook-login-btn").on("click", function(){
  			FB.login(function(res){
  				if(res.status=="connected"){
  					 FB.api('/me?fields=name,picture', function(res) {
  					    res.id += "@f";
  					    
  				    	$.ajax({
  			            	  url : "/user/json/checkDuplication/"+res.id,
  			            	  headers : {
  			  					"Accept" : "application/json",
  			  					"Content-Type" : "application/json"
  			  				  },
  			  				  success : function(idChk){
  			  					  
  			  					  if(idChk==true){ //DB에 아이디가 없을 경우 => 회원가입
  			  						  console.log("회원가입중...");
  			  						  $.ajax({
  			  							  url : "/user/json/addUser",
  			  							  method : "POST",
  			  							  headers : {
  			  								"Accept" : "application/json",
  			  								"Content-Type" : "application/json"
  			  							  },
  			  							  data : JSON.stringify({
  			  								userId : res.id,
  			  								userName : res.name,
  			  								password : "facebook",
  			  							  }),
  			  							  success : function(JSONData){
  			  								 alert("회원가입이 정상적으로 되었습니다.");
  			  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
  			  							  }
  			  						  })
  			  					  }
  			  					  if(idChk==false){ //DB에 아이디가 존재할 경우 => 로그인
  			  						  console.log("로그인중...");
  			  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
  			  					  }
  			  				  }
  			              })
  				    }); //e.o.FB.api
  				} //e.o.FB.login
 			})
 			
/* 			FB.getLoginStatus(function(res) {
			    console.log(JSON.stringify(res));
			}); //e.o.FB.getLoginStatus */
			
		})//e.o.onclick
			
		/*게시물 쓰기
		FB.ui({
			method		: 'feed',
			name		: 'Facebook Dialogs',
			link		: 'https://developers.facebook.com/docs/dialogs/',
			picture		: 'http://fbrell.com/f8.jpg',
			caption		: 'Reference Documentation',
			description	: 'Dialogs provide a simple, consistent interface for applications to interface with users.'
		}); */
	
	});//e.o.facebook
	
	
	//구글 로그인
	$(function(){
 		function onSuccess(googleUser) {
		    var profile = googleUser.getBasicProfile();
		    console.log(profile);
			    //Eea : "115795601565666831944"
				//Paa : "https://lh5.googleusercontent.com/-sqhau76RDZY/AAAAAAAAAAI/AAAAAAAAAAA/AIcfdXBZz_7LYdiS_80Xsx3dz8B9di7T6Q/s96-c/photo.jpg"
				//U3 : "wowjisoowow@gmail.com"
				//ig : "Js Ha"
				//ofa : "Js"
				//wea : "Ha"
		    //console.log(googleUser.getAuthResponse().id_token);
		}
		
		$(".g-signin2").on("click", function(){
		    gapi.client.load('plus', 'v1', function () {
		        gapi.client.plus.people.get({
		            'userId': 'me'
		        }).execute(function (res) {
		        	console.log(JSON.stringify(res));
		        	
		        	res.id += "@g";
			        
		            $.ajax({
		            	url : "/user/json/checkDuplication/"+res.id,
		            	headers : {
		  					"Accept" : "application/json",
		  					"Content-Type" : "application/json"
		  				},
		  				success : function(idChk){
		  					  if(idChk==true){ //DB에 아이디가 없을 경우 => 회원가입
		  						  console.log("회원가입중...");
		  						  $.ajax({
		  							  url : "/user/json/addUser",
		  							  method : "POST",
		  							  headers : {
		  								"Accept" : "application/json",
		  								"Content-Type" : "application/json"
		  							  },
		  							  data : JSON.stringify({
		  								userId : res.id,
		  								userName : res.displayName,
		  								password : "google",
		  							  }),
		  							  success : function(JSONData){
		  								 alert("회원가입이 정상적으로 되었습니다.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ //DB에 아이디가 존재할 경우 => 로그인
		  						  console.log("로그인중...");
		  						  $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  					  }
		  				  }
		              })
		        	})
	        })
		})//e.o.google.loginLogic
		
		function onFailure(error) {
		    console("error : "+error);
		}
		
		function signOut() {
		    var auth2 = gapi.auth2.getAuthInstance();
		    auth2.signOut().then(function () {
		    	self.location="/user/logout";
		    });
		}
		
	})//e.o.google
	
	
</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<div class="navbar  navbar-default">
        <div class="container">
        	<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
   		</div>
   	</div>
   	<!-- ToolBar End /////////////////////////////////////-->	
   	
   	<div class="container">
   		<div class="row">
   			<div class="col-md-6">
				<img src="/images/logo-spring.png" class="img-rounded" width="100%" />
			</div>
			<div class="col-md-6">
				<br><br>
				<div class="jumbotron">
					<h1 class="text-center">로 &nbsp;&nbsp;그 &nbsp;&nbsp;인</h1>
					
					<form class="form-horizontal">
						<div class="form-group">
							<label for="userId" class="col-sm-4 control-label">아 이 디</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" name="userId" id="userId"  placeholder="아이디" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="userId" class="col-sm-4 control-label">패 스 워 드</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" name="password" id="password" placeholder="패스워드" >
							</div>
						</div>
							
						<!-- 로그인 실패 Ajax 처리 -->
						<div id="message" align="center"></div><br>
					
						<div class="form-group">
					    	<div class="col-sm-offset-4 col-sm-6 text-center">
					    		<button type="button" class="btn btn-primary">로 &nbsp;그 &nbsp;인</button>
					    		<a class="btn btn-primary btn" href="#" role="button">회 &nbsp;원 &nbsp;가 &nbsp;입</a>
					  		</div>
					  	</div>
					</form>
					
												
					<!-- 카카오 로그인 추가 -->
					<div id="kakaoLogin" align="center">
						<a id="kakao-login-btn" href="#">
							<img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="80%"/>
						</a>
						<a href="http://developers.kakao.com/logout"></a>
					</div>
												
					<!-- 네이버 로그인 추가 -->
  					<div id="naverIdLogin" align="center">
						<a id="naver-login-btn" href="#" role="button">
							<img src="https://static.nid.naver.com/oauth/big_g.PNG" width="80%" height="45"/> 
						</a>
					</div>

					<!-- 페이스북 로그인 추가 -->
					<div id="facebookLogin" align="center">
 						<a id="facebook-login-btn" href="#">
							<img src="/images/sns/facebook.PNG">
						</a>
					</div>
												
					<!-- 구글 로그인 추가 -->
					<div id="googleLogin" align="center">													
						<div class="g-signin2" data-onsuccess="onSuccess" data-theme="dark"></div>
					</div>
					
				</div>
			</div>
   		</div>
   	</div>

</body>
</html>