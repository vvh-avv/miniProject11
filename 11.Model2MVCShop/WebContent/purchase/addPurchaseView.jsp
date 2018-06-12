<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<title>상품구매</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="shortcut icon" href="/images/common/favicon.ico">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!-- 캘린더 -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<!-- 주소 -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<style>
	body > div.container{
		margin-top : 50px;
	}
</style>

<script type="text/javascript">
	$(function(){
		$("button.btn.btn-primary:contains('구매')").on("click", function(){
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchase?prodNo=${product.prodNo}").submit();
		})
		
		$("button.btn.btn-primary:contains('취소')").on("click", function(){
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
			<h3 class="text-info">상품구매</h3>
		</div>
	
		<form class="form-horizontal">
			<input type="hidden" name="prodNo" value="${product.prodNo}"/>
		
			<div class="form-group">
					<div class="col-xs-4 col-md-2"><strong>상품번호</strong></div>
					<div class="col-xs-8 col-md-4">${product.prodNo}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>상품명</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodName}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-4">${product.prodDetail}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>제조일자</strong></div>
				<div class="col-xs-8 col-md-4">${product.manuDate}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>가격</strong></div>
				<div class="col-xs-8 col-md-4">${product.price}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>등록일자</strong></div>
				<div class="col-xs-8 col-md-4">${product.regDate}</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매자아이디</strong></div>
				<div class="col-xs-8 col-md-4">${user.userId}</div>
				<input type="hidden" name="userId" value="${user.userId}"/>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매방법</strong></div>
				<div class="col-xs-8 col-md-4">
					<select name="paymentOption" class="form-control">
						<option value="1" selected="selected">현금구매</option>
						<option value="2">신용구매</option>
					</select>
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>받는 분 성함</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="receiverName" name="receiverName" placeholder="구매자이름" value="${user.userName}">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>받는 분 연락처</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="receiverPhone" name="receiverPhone" placeholder="구매자연락처" value="${user.phone}">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>배송받을 주소</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="divyAddr" name="divyAddr" placeholder="구매자주소" value="${user.addr}">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>구매시 요청사항</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="divyRequest" name="divyRequest" placeholder="구매요청사항" >
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>배송희망일자</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" readonly="readonly" id="divyDate" name="divyDate">
				</div>
			</div><hr>
			
			<div class="form-group">
			   	<div class="col-sm-offset-4  col-sm-4 text-center">
			   		<button type="button" class="btn btn-primary">구매</button>
			 		<button type="button" class="btn btn-primary">취소</button>
			   	</div>
			</div>
			
		</form>
	</div>

</body>
</html>