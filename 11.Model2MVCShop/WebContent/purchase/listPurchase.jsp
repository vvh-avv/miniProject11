<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>구매목록조회</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="shortcut icon" href="/images/common/favicon.ico">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<link href="/css/animate.min.css" rel="stylesheet">
<link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
	body{
		padding-top : 50px;
	}
</style>

<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage);
		$("form").attr("method","POST").attr("action","/purchase/listPurchase").submit();
	}
	
	$(function(){
		$("#under").on("click", function(){
			self.location = "/purchase/listPurchase?sort=desc";
		})
		
		$("#high").on("click", function(){
			self.location = "/purchase/listPurchase?sort=asc";
		})
		
		$("td:nth-child(2)").on("click", function(){
			self.location = "/purchase/getPurchase?tranNo="+$(this).text().trim();
		})
		
		$("td:nth-child(4)").on("click", function(){
			self.location = "/product/updateProduct?prodNo="+$(this).text().trim()+"&menu=search";
		})
		
		$("#searchKeyword").on("keypress", function(event){
			if(event.keyCode==13) { fncGetList('1'); }  
		});
		
		$("#tc_cancle").on("click", function(){ //주문취소
			$("form").attr("method", "POST").attr("action", "/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-1").submit();
		})
		
		$("#tc_arrive").on("click", function(){ //물건도착
			$("form").attr("method", "POST").attr("action", "/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3").submit();
		})
		
		$("#tc_return").on("click", function(){ //상품반품
			$("form").attr("method", "POST").attr("action", "/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-2").submit();
		})
		
		$("#tc_return>").css("color", "red");
		$("#tc_cancle>").css("color", "red");
		$("#tc_arrive>").css("color", "blue");
		
	})
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
	   	<div class="page-header text-info">
   			<h3>구매목록조회</h3>
   		</div>
   		
   		<div class="row">
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
   				</p>
   			</div>
   		
   			<div class="col-md-6 text-right">
   				<form class="form-inline" name="detailForm">
				    <div class="form-group">
					    <select class="form-control" name="searchCondition" >
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>상품명</option>
						</select>
					  </div>
					  
					  <div class="form-group">
				    	<label class="sr-only" for="searchKeyword">검색어</label>
				    	<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    				 value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					  </div>
				  
					  <button type="button" class="btn btn-default">검색</button>
				  
					  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
					  <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
				  
				</form>
   			</div>
   		</div>
   		
   		<br>
   		
   		<table class="table table-hover table-striped">
   			<thead>
   				<tr>
   					<th align="left">No</th>
   					<th align="left">주문번호</th>
   					<th align="left">주문일자
   						<a href="#">
	   						<c:choose>
								<c:when test="${requestScope.sort=='asc'}">
									<span id="under" class="glyphicon glyphicon-chevron-down"></span>
								</c:when>
								<c:otherwise>
									<span id="high" class="glyphicon glyphicon-chevron-up"></span>
								</c:otherwise>
							</c:choose>
						</a>
   					</th>
   					<th align="left">구매상품</th>
   					<th align="left">받는 분</th>
   					<th align="left">배송지 주소</th>
   					<th align="left">전화번호</th>
   					<th align="left">배송현황</th>
   				</tr>
   			</thead>
   			
   			<tbody>
   			 <c:set var="i" value="0" />
			  <c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="left">${ i }</td>
				  <td align="left" title="Click : 주문정보 확인"><a href="#">${purchase.tranNo}</a></td>
				  <td align="left">${purchase.orderDate}</td>
				  <td align="left">${purchase.purchaseProd.prodName}</td>
				  <td align="left">${purchase.receiverName}</td>
				  <td align="left">${purchase.divyAddr}</td>
				  <td align="left">${purchase.receiverPhone}</td>
				  <td align="left">
				  		<!-- 주문취소, 반품상태를 복구할 수 있기 때문에 처리 전 현재 tranCode값을 session에 저장함 -->
						<!-- tranCodeTemp 값이 0보다 작은 경우를 추가 한 이유는..세션에 잘못된 값이 들어갔을 때를 대비한 것 -->
						<c:if test="${sessionScope.tranCodeTemp<0 || empty sessionScope.tranCodeTemp}">
							<c:set var="tranCodeTemp" value="${purchase.tranCode}" scope="session" />
						</c:if>
							
						<c:choose>
							<c:when test="${purchase.tranCode=='1'}">
								현재 구매완료 상태입니다.
								<!-- 0418 취소 기능 추가 -->
								<span id="tc_cancle">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-1">주문취소</a>
								</span>
							</c:when>
							<c:when test="${purchase.tranCode=='2'}">
								현재 배송중 상태입니다.
								<span id="tc_arrive">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">배송중</a>
								</span>
								<span id="tc_return">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-2">상품반품</a>
								</span>
							</c:when>
							<c:when test="${purchase.tranCode=='3'}">
								현재 배송완료 상태입니다.
								<span id="tc_return">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-2">상품반품</a>
								</span>
							</c:when>
							<c:when test="${purchase.tranCode=='-1'}">
								현재 주문취소 상태입니다.
							</c:when>
							<c:when test="${purchase.tranCode=='-2'}">
							현재 반품신청 상태입니다.
							</c:when>
							<c:when test="${purchase.tranCode=='-3'}">
								현재 반품완료 상태입니다.
							</c:when>
							</c:choose>
				  </td>
	          </c:forEach>
   			</tbody>
   		</table>
	</div><!--e.o.container-->
	
	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->
	
</body>
</html>