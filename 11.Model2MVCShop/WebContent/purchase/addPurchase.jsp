<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>구매완료화면</title>

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
			<h3 class="text-info">구매완료</h3>
		</div>
		
		<form class="form-horizontal">
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.purchaseProd.prodNo}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매자아이디</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.buyer.userId}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
				<div class="col-xs-8 col-md-4">
					<c:if test="${purchase.paymentOption=='1'}">
						현금구매
					</c:if>
					<c:if test="${purchase.paymentOption=='2'}">
						신용구매
					</c:if>
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매자이름</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.receiverName}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매자연락처</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.receiverPhone}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매자주소</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyAddr}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매요청사항</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyRequest}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>배송희망일자</strong></div>
				<div class="col-xs-8 col-md-4">${purchase.divyDate}</div>
			</div><hr>
		</form>
	</div><!--e.o.container-->
	
</body>
</html>