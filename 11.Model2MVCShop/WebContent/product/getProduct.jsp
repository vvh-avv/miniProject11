<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>상품조회</title>

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
		$("button:contains('확인')").on("click", function(){
			self.location = "/product/listProduct?menu=manage";
		})
		
		$("button:contains('추가등록')").on("click", function(){
			self.location = "../product/addProductView.jsp";
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
			<h3 class=" text-info">상품조회</h3>
	    </div>
	    
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
		
	  	<div class="col-md-6 text-right ">
	 		<button type="button" class="btn btn-primary" id="before">확인</button>
	 		<button type="button" class="btn btn-primary" id="submit">추가등록</button>
	  	</div>
	    
	</div><!--e.o.container-->

</body>
</html>