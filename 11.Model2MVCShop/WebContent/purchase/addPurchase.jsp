<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>���ſϷ�ȭ��</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="shortcut icon" href="/images/common/favicon.ico">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<style>
	body {
		margin-top : 50px;
	}
</style>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<div class="page-header">
			<h3 class="text-info">���ſϷ�</h3>
		</div>
		
		<form class="form-horizontal">
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��ǰ��ȣ</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�����ھ��̵�</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
			</div><hr>
			
			<div class="form-group">
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
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�������̸�</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�����ڿ���ó</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>�������ּ�</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>���ſ�û����</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>����������</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
			</div><hr>
		</form>
	</div><!--e.o.container-->
	
</body>
</html>