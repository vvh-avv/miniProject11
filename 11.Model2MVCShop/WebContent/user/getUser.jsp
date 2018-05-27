<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>����������ȸ</title>

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
		$("button:contains('Ȯ��')").on("click", function(){
			//parent.location = "../index.jsp";
			history.go(-1);
		});

		$("button:contains('����')").on("click", function(){
			self.location = "/user/updateUser?userId=${user.userId}"
		});
		
		$("[name=reason][value='��Ÿ']").on("click",function(){
			$("input:text[name=reasonText]").focus();
		});
		
		$("#quitSubmit").on("click", function(){
			var chkValue = $("input:checked").val();
			
			if( chkValue==null || (chkValue=="��Ÿ" && $("input:text[name=reasonText]").val()=="") ){
				alert("������ �ݵ�� �Է����ֽñ� �ٶ��ϴ�.");
			}else{
				if(chkValue=="��Ÿ"){ chkValue = $("input:text[name=reasonText]").val(); }
				
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
			<h3 class=" text-info">����������ȸ</h3>
	    	<h5 class="text-muted">�� ������ <strong class="text-danger">�ֽ������� ����</strong>�� �ּ���.</h5>
		</div>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.userId}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.userName}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${user.addr}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>�޴���ȭ��ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${ !empty user.phone ? user.phone : ''}	</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>�� �� ��</strong></div>
			<div class="col-xs-8 col-md-4">${user.email}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${user.regDate}</div>
		</div><hr>
		
		<div class="row">
	  		<div class="col-md-6 text-left ">
				<!-- ȸ��Ż�� ���â ��ư -->
				<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
				  ȸ��Ż��
				</button>
				
				<!-- ȸ��Ż�� ���â -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
				  <div class="modal-dialog" role="document">
				    <div class="modal-content">
				      <div class="modal-header">
				        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
				        <h4 class="modal-title" id="myModalLabel">���� Ż���Ͻðڽ��ϱ�?</h4>
				      </div>
				      <div class="modal-body">
					   	Ż����� : <br>
					   	<div class="radio">
						   	<label>
							  <input type="radio" name="reason" value="�������� ������"><font size="2">�������� ������</font><br>
							</label>
						</div>
						<div class="radio">
							<label>
							  <input type="radio" name="reason" value="������ ��� ��ǰ�� ���"><font size="2">������ ��� ��ǰ�� ���</font><br>
							</label>
						</div>
						<div class="radio">
							<label>
							  <input type="radio" name="reason" value="��Ÿ"><font size="2">��Ÿ</font>&nbsp;<input type="text" name="reasonText"><br>
							</label>
						</div>
					  </div>
			 	      <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">�ݱ�</button>
				        <button type="button" class="btn btn-primary" id="quitSubmit">Ż��</button>
				      </div>
				    </div>
				  </div>
				</div>
	  		</div>
		
	  		<div class="col-md-6 text-right ">
	  			<button type="button" class="btn btn-primary">����</button>
	  			<button type="button" class="btn btn-primary">Ȯ��</button>
	  		</div>
		
		</div>
	</div>


</body>
</html>