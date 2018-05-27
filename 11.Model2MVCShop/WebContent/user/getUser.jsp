<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>개인정보조회</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<style>
	body {
		padding-top : 50px;
	}
</style>

<script type="text/javascript">
	$(function(){
		$("button:contains('확인')").on("click", function(){
			//parent.location = "../index.jsp";
			history.go(-1);
		});

		$("button:contains('수정')").on("click", function(){
			self.location = "/user/updateUser?userId=${user.userId}"
		});
		
		$("[name=reason][value='기타']").on("click",function(){
			$("input:text[name=reasonText]").focus();
		});
		
		$("#quitSubmit").on("click", function(){
			var chkValue = $("input:checked").val();
			
			if( chkValue==null || (chkValue=="기타" && $("input:text[name=reasonText]").val()=="") ){
				alert("사유는 반드시 입력해주시길 바랍니다.");
			}else{
				if(chkValue=="기타"){ chkValue = $("input:text[name=reasonText]").val(); }
				
				$.ajax({
					url : "/user/quitUser?userId=${user.userId}&reason="+chkValue,
					method : "POST"
				});
				self.location="/user/logout";
				
			}
		});
	});

</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<div class="page-header">
			<h3 class=" text-info">개인정보조회</h3>
	    	<h5 class="text-muted">내 정보를 <strong class="text-danger">최신정보로 관리</strong>해 주세요.</h5>
		</div>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>아 이 디</strong></div>
			<div class="col-xs-8 col-md-4">${user.userId}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>이 름</strong></div>
			<div class="col-xs-8 col-md-4">${user.userName}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>주소</strong></div>
			<div class="col-xs-8 col-md-4">${user.addr}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>휴대전화번호</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}	</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>이 메 일</strong></div>
			<div class="col-xs-8 col-md-4">${user.email}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가입일자</strong></div>
			<div class="col-xs-8 col-md-4">${user.regDate}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-md-6 text-left ">
				<!-- 회원탈퇴 모달창 버튼 -->
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
				  회원탈퇴
				</button>
				
				<!-- 회원탈퇴 모달창 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">정말 탈퇴하시겠습니까?</h4>
				      </div>
				      <div class="modal-body">
					   	탈퇴사유 : <br>
					   	<div class="radio">
						   	<label>
							  <input type="radio" name="reason" value="개인정보 때문에"><font size="2">개인정보 때문에</font><br>
							</label>
						</div>
						<div class="radio">
							<label>
							  <input type="radio" name="reason" value="마음에 드는 상품이 없어서"><font size="2">마음에 드는 상품이 없어서</font><br>
							</label>
						</div>
						<div class="radio">
							<label>
							  <input type="radio" name="reason" value="기타"><font size="2">기타</font>&nbsp;<input type="text" name="reasonText"><br>
							</label>
						</div>
					  </div>
			 	      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
				        <button type="button" class="btn btn-primary" id="quitSubmit">탈퇴</button>
				      </div>
				    </div>
				  </div>
				</div>
	  		</div>
		
	  		<div class="col-md-6 text-right ">
	  			<button type="button" class="btn btn-primary">수정</button>
	  			<button type="button" class="btn btn-primary">확인</button>
	  		</div>
		
		</div>
	</div>


</body>
</html>