<%@ page contentType="text/html; charset=euc-kr"%>

<!DOCTYPE html>
<html>
<head>
<title>회원가입</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
	body > div.container{
		border : 3px solid #D6CDB7;
		margin-top : 10px;
	}
</style>

<script type="text/javascript">
	function fncAddUser(){
		var id=$("input[name='userId']").val();
		var pw=$("input[name='password']").val();
		var pw_confirm=$("input[name='password2']").val();
		var name=$("input[name='userName']").val();

		if (id == null || id.length < 1) {
			alert("아이디는 반드시 입력하셔야 합니다.");
			$("input[name='userId']").focus();
			return;
		}
		if (pw == null || pw.length < 1) {
			alert("패스워드는 반드시 입력하셔야 합니다.");
			$("input[name='password']").focus();
			return;
		}
		if (pw_confirm == null || pw_confirm.length < 1) {
			alert("패스워드 확인은 반드시 입력하셔야 합니다.");
			$("input[name='password2']").focus();
			return;
		}
		if (name == null || name.length < 1) {
			alert("이름은 반드시 입력하셔야 합니다.");
			$("input[name='userName']").focus();
			return;
		}

		var value = "";	
		if ($("input:text[name='phone2']").val() != ""  &&  $("input:text[name='phone3']").val() != "") {
			var value = $("option:selected").val() + "-" 
							+ $("input[name='phone2']").val() + "-" + $("input[name='phone3']").val();
		}
		$("input:hidden[name='phone']").val( value );

		if( $("#idMessage").text()=="사용가능한 아이디입니다." && $("#pwdMessage").text()=="비밀번호가 일치합니다." && $("#emailMessage".text()!="이메일 형식이 아닙니다.")){
			$("form").attr("method" , "POST").attr("action" , "/user/addUser").submit();
		}else{
			alert("입력한 정보를 다시 확인해주시길 바랍니다.")
		}	
	}
	
	$(function(){
		$("button.btn.btn-primary").on("click" , function() {
			fncAddUser();
		})
		
		$("input[name='userName']").keypress(function(event) {
			if(event.which==13){
				fncAddUser();
			}
		})
		
		$("input[name='phone1']").on("change", function(){
			$("input[name='phone2']").focus();	
		})
		
		$("input[name='email']").on("keyup" , function() {
			var email = $("input[name='email']").val();
			
			$.ajax({
				success : function(){
					if(email != "" && (email.indexOf('@') < 1 || email.indexOf('.') == -1) ){
						$("#emailMessage").text("이메일 형식이 아닙니다.").css("color","red");
					}else{
						$("#emailMessage").text("");
					}
				}
			})
		})
		
		$("a[href='#']").on("click" , function() {
			$("form")[0].reset();
			$("#idMessage").text("");
			$("#pwdMessage").text("");
		})
		
		$("input[name='password2']").on("keyup", function(){
			$.ajax({
				success : function(){
					if( $("input[name='password']").val() == $("input[name='password2']").val() ){
						$("#pwdMessage").text("비밀번호가 일치합니다.").css("color","blue");
					}else{
						$("#pwdMessage").text("비밀번호가 일치하지 않습니다.").css("color","red");
					}
				}
			})
		})
		
		$("input[name='userId']").on("keyup", function(){
			$.ajax({
				url : "/user/json/checkDuplication/"+$(this).val().trim(),
				method : "GET",
				dataType : "json",
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status){
					if(JSONData==true){
						$("#idMessage").text("사용가능한 아이디입니다.").css("color","blue");
					}else{
						$("#idMessage").text("이미 존재하는 아이디입니다.").css("color","red");
					}
				}
			})
		})
		
		$("#addr").on("mousedown", function(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	$("#addr").val(data.address);
		        }
		    }).open();
		})
		
	});
	
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
   	
   	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<h1 class="bg-primary text-center">회 원 가 입</h1>
		
		<form class="form-horizontal">
		
		<div class="form-group">
		    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디">
		       <span id="idMessage"></span>
		    </div>
		</div>
		  
		  <div class="form-group">
		    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password" name="password" placeholder="비밀번호">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
		    <div class="col-sm-4">
		      <input type="password" class="form-control" id="password2" name="password2" placeholder="비밀번호 확인">
		      <span id="pwdMessage"></span>
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="userName" name="userName" placeholder="회원이름">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="addr" name="addr" placeholder="주소">
		    </div>
		  </div>
		  
		  <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
		     <div class="col-sm-2">
		      <select class="form-control" name="phone1" id="phone1">
				  	<option value="010" >010</option>
					<option value="011" >011</option>
					<option value="016" >016</option>
					<option value="018" >018</option>
					<option value="019" >019</option>
				</select>
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone2" name="phone2" placeholder="번호">
		    </div>
		    <div class="col-sm-2">
		      <input type="text" class="form-control" id="phone3" name="phone3" placeholder="번호">
		    </div>
		    <input type="hidden" name="phone"  />
		  </div>
		  
		   <div class="form-group">
		    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="email" name="email" placeholder="이메일">
		    </div>
		    <span id="emailMessage"></span>
		  </div>
		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary">가&nbsp;입</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
	</div>

</body>
</html>