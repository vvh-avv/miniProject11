<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>��ǰ����</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="shortcut icon" href="/images/common/favicon.ico">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!-- Ķ���� -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- �ּ� -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
	body > div.container{
		margin-top : 50px;
	}
</style>

<script type="text/javascript">
	$(function(){
		$("button.btn.btn-primary:contains('����')").on("click", function(){
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchase?prodNo=${product.prodNo}").submit();
		})
		
		$("button.btn.btn-primary:contains('���')").on("click", function(){
			history.go(-1)
		})
		
        $("#receiverDate").datepicker();
        $("#receiverDate").datepicker("option", "dateFormat", "yymmdd");
        
		$("#receiverAddr").on("mousedown", function(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		        	$("#receiverAddr").val(data.address);
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
		<div class="page-header">
			<h3 class="text-info">��ǰ����</h3>
		</div>
	
		<form class="form-horizontal">
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
		
			<div class="form-group">
					<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodNo}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodName}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
				<div class="col-xs-8 col-md-4">${product.manuDate}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>����</strong></div>
				<div class="col-xs-8 col-md-4">${product.price}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�������</strong></div>
				<div class="col-xs-8 col-md-4">${product.regDate}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�����ھ��̵�</strong></div>
				<div class="col-xs-8 col-md-4">${user.userId}</div>
				<input type="hidden" name="userId" value="${user.userId}"/>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>���Ź��</strong></div>
				<div class="col-xs-8 col-md-4">
					<select name="paymentOption" class="form-control">
						<option value="1" selected="selected">���ݱ���</option>
						<option value="2">�ſ뱸��</option>
					</select>
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�޴� �� ����</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="�������̸�" value="${user.userName}">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�޴� �� ����ó</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="�����ڿ���ó" value="${user.phone}">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��۹��� �ּ�</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="�������ּ�" value="${user.addr}">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>���Ž� ��û����</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="���ſ�û����" >
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>����������</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" readonly="readonly" id="divyDate" name="divyDate">
				</div>
			</div><hr>
			
			<div class="form-group">
			   	<div class="col-sm-offset-4  col-sm-4 text-center">
			   		<button type="button" class="btn btn-primary">����</button>
			 		<button type="button" class="btn btn-primary">���</button>
			   	</div>
			</div>
			
		</form>
	</div>

</body>
</html>