<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>�α��� ȭ��</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<!-- īī�� �α��� -->
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<!-- ���̹� �α��� -->
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.0.js"></script>
<!-- ���̽��� �α��� -->
<script src="https://connect.facebook.net/en_US/sdk.js"></script>
<!-- ���� �α��� -->
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
			alert('���̵� �Է����� �����̽��ϴ�.');
			$("input:text").focus();
			return;
		}
			
		if(pw==null || pw.length<1){
			alert('�н����带 �Է����� �����̽��ϴ�.');
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
						//[���1]
						//$(window.parent.document.location).attr("href","/index.jsp");
						//[���2]
						//window.parent.document.location.reload();
						//[���3]
						//$(window.parent.frames["topFrame"].document.location).attr("href","/layout/top.jsp");
						//$(window.parent.frames["leftFrame"].document.location).attr("href","/layout/left.jsp");
						//$(window.parent.frames["rightFrame"].document.location).attr("href","/user/getUser?userId="+JSONData.userId);
					}else{
						$("#message").text("��й�ȣ�� �ٽ� Ȯ�����ּ���.").css("color", "red");
						$("#password").val("").focus();
					}
					
				}else{
					$("#userId").val("").focus();
					$("#password").val("");
					$("#message").text("���̵�, �н����带 �ٽ� Ȯ�����ּ���.").css("color", "red");
				}
			}
		}); //e.o.ajax
	}//e.o.fncLogin()
	
	$(function(){
		$("#userId").focus();
		
		//�α��� ����Ű ó��
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

	//īī�� �α���
	$(function(){
		Kakao.init('b3eb26586b770154ea49919a7f59f2d2');
		
		$("#kakao-login-btn").on("click", function(){
			//1. �α��� �õ�
			Kakao.Auth.login({
		        success: function(authObj) {
		          //console.log(JSON.stringify(authObj));
		          //console.log(Kakao.Auth.getAccessToken());
		        
		          //2. �α��� ������, API�� ȣ���մϴ�.
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
		  					  
		  					  if(idChk==true){ //DB�� ���̵� ���� ��� => ȸ������
		  						  console.log("ȸ��������...");
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
		  								 alert("ȸ�������� ���������� �Ǿ����ϴ�.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ //DB�� ���̵� ������ ��� => �α���
		  						  console.log("�α�����...");
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
	
	//���̹� �α���
	$(function(){
   		var naverLogin = new naver.LoginWithNaverId({
			clientId: "NqLY8zfxRnZIl3CjoL1a",
			callbackUrl: "http://192.168.0.69:8080/user/naverCallback.jsp",
			isPopup: true,
			loginButton: {color: "green", type: 3, height: 45}
		});
		naverLogin.init();
	})//e.o.naver
	
	//���̽��� �α���	
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
  			  					  
  			  					  if(idChk==true){ //DB�� ���̵� ���� ��� => ȸ������
  			  						  console.log("ȸ��������...");
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
  			  								 alert("ȸ�������� ���������� �Ǿ����ϴ�.");
  			  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
  			  							  }
  			  						  })
  			  					  }
  			  					  if(idChk==false){ //DB�� ���̵� ������ ��� => �α���
  			  						  console.log("�α�����...");
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
			
		/*�Խù� ����
		FB.ui({
			method		: 'feed',
			name		: 'Facebook Dialogs',
			link		: 'https://developers.facebook.com/docs/dialogs/',
			picture		: 'http://fbrell.com/f8.jpg',
			caption		: 'Reference Documentation',
			description	: 'Dialogs provide a simple, consistent interface for applications to interface with users.'
		}); */
	
	});//e.o.facebook
	
	
	//���� �α���
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
		  					  if(idChk==true){ //DB�� ���̵� ���� ��� => ȸ������
		  						  console.log("ȸ��������...");
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
		  								 alert("ȸ�������� ���������� �Ǿ����ϴ�.");
		  								 $("form").attr("method","POST").attr("action","/user/snsLogin/"+res.id).attr("target","_parent").submit();
		  							  }
		  						  })
		  					  }
		  					  if(idChk==false){ //DB�� ���̵� ������ ��� => �α���
		  						  console.log("�α�����...");
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
					<h1 class="text-center">�� &nbsp;&nbsp;�� &nbsp;&nbsp;��</h1>
					
					<form class="form-horizontal">
						<div class="form-group">
							<label for="userId" class="col-sm-4 control-label">�� �� ��</label>
							<div class="col-sm-6">
								<input type="text" class="form-control" name="userId" id="userId"  placeholder="���̵�" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="userId" class="col-sm-4 control-label">�� �� �� ��</label>
							<div class="col-sm-6">
								<input type="password" class="form-control" name="password" id="password" placeholder="�н�����" >
							</div>
						</div>
							
						<!-- �α��� ���� Ajax ó�� -->
						<div id="message" align="center"></div><br>
					
						<div class="form-group">
					    	<div class="col-sm-offset-4 col-sm-6 text-center">
					    		<button type="button" class="btn btn-primary">�� &nbsp;�� &nbsp;��</button>
					    		<a class="btn btn-primary btn" href="#" role="button">ȸ &nbsp;�� &nbsp;�� &nbsp;��</a>
					  		</div>
					  	</div>
					</form>
					
												
					<!-- īī�� �α��� �߰� -->
					<div id="kakaoLogin" align="center">
						<a id="kakao-login-btn" href="#">
							<img src="//k.kakaocdn.net/14/dn/btqbjxsO6vP/KPiGpdnsubSq3a0PHEGUK1/o.jpg" width="80%"/>
						</a>
						<a href="http://developers.kakao.com/logout"></a>
					</div>
												
					<!-- ���̹� �α��� �߰� -->
  					<div id="naverIdLogin" align="center">
						<a id="naver-login-btn" href="#" role="button">
							<img src="https://static.nid.naver.com/oauth/big_g.PNG" width="80%" height="45"/> 
						</a>
					</div>

					<!-- ���̽��� �α��� �߰� -->
					<div id="facebookLogin" align="center">
 						<a id="facebook-login-btn" href="#">
							<img src="/images/sns/facebook.PNG">
						</a>
					</div>
												
					<!-- ���� �α��� �߰� -->
					<div id="googleLogin" align="center">													
						<div class="g-signin2" data-onsuccess="onSuccess" data-theme="dark"></div>
					</div>
					
				</div>
			</div>
   		</div>
   	</div>

</body>
</html>