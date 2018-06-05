<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>���Ż���ȸ</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="shortcut icon" href="/images/common/favicon.ico">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<style>
	body{
		padding-top : 50px;
	}
</style>

<script type="text/javascript">

	$(function(){
		$("button:contains('Ȯ��')").on("click", function(){
			history.go(-1);
		})
		
		$("button:contains('����')").on("click", function(){
			self.location = "/purchase/updatePurchase?tranNo=${purchase.tranNo}";
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
			<h3 class=" text-info">���Ż���ȸ</h3>
	    </div>
	    
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>���Ź�ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.tranNo}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>���Ź�ȣ</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.tranNo}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�����ھ��̵�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>���Ź��</strong></div>
			<div class="col-xs-8 col-md-4">
				<c:if test="${purchase.paymentOption=='1'}">
					���ݱ���
				</c:if>
				<c:if test="${purchase.paymentOption=='2'}">
					�ſ뱸��
				</c:if>
			</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�������̸�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�����ڿ���ó</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�������ּ�</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>���ſ�û����</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>�ֹ���</strong></div>
			<div class="col-xs-8 col-md-4">${purchase.orderDate}</div>
		</div><hr>
		
		<div class="col-md-6 text-right ">
			<c:if test="${purchase.tranCode=='1'}">
	 			<button type="button" class="btn btn-primary">����</button>
	 		</c:if>
	 		<button type="button" class="btn btn-primary">Ȯ��</button>
	  	</div>
	</div><!-- e.o.container -->
	
</body>
</html>