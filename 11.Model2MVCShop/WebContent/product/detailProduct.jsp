<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

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
		$("#guest").on("click", function(){
			alert("로그인 후 구매해주시길 바랍니다.");
		})
		
		$("#user").on("click", function(){
			self.location="/purchase/addPurchase?prod_no=${product.prodNo}";
		})
		
		$("#before").on("click", function(){
			history.go(-1);
		})
		
		$("#submit").on("click", function(){
			//alert("클릭!");
			//$("form").attr("method", "POST").attr("action", "/product/listProduct?menu=${param.menu=='manage'?'manage':'search'}").submit();
			self.location="/product/listProduct?menu=${param.menu=='manage'?'manage':'search'}";
		})
	})
	
</script>

<title>상품상세조회</title>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		
		<div class="page-header">
			<h3 class="text-info">상품상세조회</h3>
		</div>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품이미지</strong></div>
			<div class="col-xs-8 col-md-4">
				<!-- 파일명 확인 <c:out value="*${product.fileName}*"/> -->
				<c:choose>
					<c:when test="${!empty product.fileName && product.fileName!=' '}">
						<!-- 복수파일 처리 -->
						<c:if test="${product.fileName.contains(',')}">
							<img src = "/images/uploadFiles/${product.fileName.split(',')[0]}" width="500" height="500"><br>
							<img src = "/images/uploadFiles/${product.fileName.split(',')[1]}" width="500" height="500">
						</c:if>
						<c:if test="${!product.fileName.contains(',')}">
							<img src = "/images/uploadFiles/${product.fileName}" width="500" height="500">
						</c:if>
					</c:when>
					
					<c:otherwise>
						<img src = "/images/empty.GIF">
					</c:otherwise>
				</c:choose>
			</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
		</div><hr>
			
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.manuDate}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div><hr>
		
		<div class="row">
			<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div><hr>
		
	  	<div class="col-md-6 text-right ">
			<!-- 판매중 상품으로 파라미터값이 넘어왔으면 -->
			<c:if test="${!empty param.status}">
				<c:if test="${empty sessionScope.user}">
	  				<button type="button" class="btn btn-primary" id="guest">구매</button>
	  			</c:if>
	  			<c:if test="${!empty sessionScope.user}">
	  				<button type="button" class="btn btn-primary" id="user">구매</button>
	  			</c:if>
	  		</c:if>
	  		
	  		<c:if test="${empty product}">
	 			<button type="button" class="btn btn-primary" id="before">이전</button>
			</c:if>
			<c:if test="${!empty product}">
	 			<button type="button" class="btn btn-primary" id="submit">확인</button>
			</c:if>
	  	</div>
	  	
	</div>
</body>
</html>