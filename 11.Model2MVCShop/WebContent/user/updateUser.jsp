<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>회원 정보 수정</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
	body {
		padding-top : 50px;
	}
</style>

<script type="text/javascript">
	function fncUpdateUser() {
		var name=$("input[name='userName']").val();
		
		if(name==null || name.length<1){
			$("input[name='userName']").focus();
			alert("이름은  반드시 입력하셔야 합니다.");
			return;
		}
		
		var value = "";
		if( $("input[name='phone2']").val() != "" && $("input[name='phone3']").val() != "" ) {
			var value = $("option:selected").val() + "-" 
							+ $("input[name='phone2']").val() + "-" 
							+ $("input[name='phone3']").val();
		}
		$("input:hidden[name='phone']").val(value);
		
		if($("#pwdMessage").text()!="비밀번호가 일치하지 않습니다." && $("#emailMessage").text()!="이메일 형식이 아닙니다."){
			$("form").attr("method", "POST").attr("action", "/user/updateUser").submit();
		}else{
			alert("입력한 정보를 다시 확인해주시길 바랍니다.")
		}
	}
	
	$(function(){
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncUpdateUser();	 
		});
		
		$("input[name='email']").on("keyup", function(){
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
		});
		
		$("select[name='phone1']").on("change", function(){
			$("input[name='phone2']").focus();
		});
		
		$( "a[href='#' ]" ).on("click", function(){
			//$("form")[0].reset();
			history.go(-1);
		});
		
		$("input[name='password2']").on("keyup", function(){
			$.ajax({
				success : function(){
					if( $("input[name='password']").val() == $("input[name='password2']").val() ){
						$("#pwdMessage").text("");
					}else{
						$("#pwdMessage").text("비밀번호가 일치하지 않습니다.").css("color","red");
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
	})
	
</script>
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<div class="page-header text-center">
			<h3 class="text-info">회원정보수정</h3>
			<h5 class="text-muted">내 정보를 <strong class="text-danger">최신정보로 관리</strong>해주세요.</h5>
		</div>
	</div>
	
		<form class="form-horizontal">
			
			<div class="form-group">
			    <label for="userId" class="col-sm-offset-1 col-sm-3 control-label">아 이 디</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userId" name="userId" value="${user.userId }"  readonly>
			       <span id="helpBlock" class="help-block">
			      	<strong class="text-danger">아이디는 수정불가</strong>
			      </span>
			    </div>
			</div>
			  
			<div class="form-group">
			    <label for="userName" class="col-sm-offset-1 col-sm-3 control-label">이름</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="userName" name="userName" value="${user.userName}" placeholder="변경회원이름">
			    </div>
			</div>
			
			<div class="form-group">
			    <label for="password" class="col-sm-offset-1 col-sm-3 control-label">비밀번호</label>
			    <div class="col-sm-4">
			      <input type="password" class="form-control" id="password" name="password" placeholder="변경비밀번호">
			    </div>
			</div>
			  
			<div class="form-group">
			    <label for="password2" class="col-sm-offset-1 col-sm-3 control-label">비밀번호 확인</label>
			    <div class="col-sm-4">
			      <input type="password" class="form-control" id="password2" name="password2" placeholder="변경비밀번호 확인">
		      	  <span id="pwdMessage"></span>
			    </div>
			</div>
	
			<div class="form-group">
			    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">주소</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="addr" name="addr"  value="${user.addr}" placeholder="변경주소">
			    </div>
			</div>
	
			<div class="form-group">
			    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">휴대전화번호</label>
			     <div class="col-sm-2">
			      <select class="form-control" name="phone1" id="phone1">
					  	<option value="010" ${ ! empty user.phone1 && user.phone1 == "010" ? "selected" : ""  } >010</option>
						<option value="011" ${ ! empty user.phone1 && user.phone1 == "011" ? "selected" : ""  } >011</option>
						<option value="016" ${ ! empty user.phone1 && user.phone1 == "016" ? "selected" : ""  } >016</option>
						<option value="018" ${ ! empty user.phone1 && user.phone1 == "018" ? "selected" : ""  } >018</option>
						<option value="019" ${ ! empty user.phone1 && user.phone1 == "019" ? "selected" : ""  } >019</option>
					</select>
			    </div>
			    <div class="col-sm-2">
			      <input type="text" class="form-control" id="phone2" name="phone2" value="${ ! empty user.phone2 ? user.phone2 : ''}"  placeholder="변경번호">
			    </div>
			    <div class="col-sm-2">
			      <input type="text" class="form-control" id="phone3" name="phone3" value="${ ! empty user.phone3 ? user.phone3 : ''}"   placeholder="변경번호">
			    </div>
			    <input type="hidden" name="phone"  />
			</div>
	
			<div class="form-group">
			    <label for="ssn" class="col-sm-offset-1 col-sm-3 control-label">이메일</label>
			    <div class="col-sm-4">
			      <input type="text" class="form-control" id="email" name="email" value="${user.email}" placeholder="변경이메일">
			    <span id="emailMessage"></span>
			    </div>
			</div>
	
			<div class="form-group">
			    <div class="col-sm-offset-4  col-sm-4 text-center">
			      <button type="button" class="btn btn-primary"  >수 &nbsp;정</button>
				  <a class="btn btn-primary btn" href="#" role="button">취 &nbsp;소</a>
			    </div>
			</div>
	
		</form>
</body>
</html>
