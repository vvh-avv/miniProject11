<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>���Ÿ����ȸ</title>

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
		
		$("#tc_cancle").on("click", function(){ //�ֹ����
			$("form").attr("method", "POST").attr("action", "/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-1").submit();
		})
		
		$("#tc_arrive").on("click", function(){ //���ǵ���
			$("form").attr("method", "POST").attr("action", "/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3").submit();
		})
		
		$("#tc_return").on("click", function(){ //��ǰ��ǰ
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
   			<h3>���Ÿ����ȸ</h3>
   		</div>
   		
   		<div class="row">
   			<div class="col-md-6 text-left">
   				<p class="text-primary">
   					��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
   				</p>
   			</div>
   		
   			<div class="col-md-6 text-right">
   				<form class="form-inline" name="detailForm">
				    <div class="form-group">
					    <select class="form-control" name="searchCondition" >
							<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��</option>
						</select>
					  </div>
					  
					  <div class="form-group">
				    	<label class="sr-only" for="searchKeyword">�˻���</label>
				    	<input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    				 value="${! empty search.searchKeyword ? search.searchKeyword : '' }">
					  </div>
				  
					  <button type="button" class="btn btn-default">�˻�</button>
				  
					  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
					  <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
				  
				</form>
   			</div>
   		</div>
   		
   		<br>
   		
   		<table class="table table-hover table-striped">
   			<thead>
   				<tr>
   					<th align="left">No</th>
   					<th align="left">�ֹ���ȣ</th>
   					<th align="left">�ֹ�����
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
   					<th align="left">���Ż�ǰ</th>
   					<th align="left">�޴� ��</th>
   					<th align="left">����� �ּ�</th>
   					<th align="left">��ȭ��ȣ</th>
   					<th align="left">�����Ȳ</th>
   				</tr>
   			</thead>
   			
   			<tbody>
   			 <c:set var="i" value="0" />
			  <c:forEach var="purchase" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="left">${ i }</td>
				  <td align="left" title="Click : �ֹ����� Ȯ��"><a href="#">${purchase.tranNo}</a></td>
				  <td align="left">${purchase.orderDate}</td>
				  <td align="left">${purchase.purchaseProd.prodName}</td>
				  <td align="left">${purchase.receiverName}</td>
				  <td align="left">${purchase.divyAddr}</td>
				  <td align="left">${purchase.receiverPhone}</td>
				  <td align="left">
				  		<!-- �ֹ����, ��ǰ���¸� ������ �� �ֱ� ������ ó�� �� ���� tranCode���� session�� ������ -->
						<!-- tranCodeTemp ���� 0���� ���� ��츦 �߰� �� ������..���ǿ� �߸��� ���� ���� ���� ����� �� -->
						<c:if test="${sessionScope.tranCodeTemp<0 || empty sessionScope.tranCodeTemp}">
							<c:set var="tranCodeTemp" value="${purchase.tranCode}" scope="session" />
						</c:if>
							
						<c:choose>
							<c:when test="${purchase.tranCode=='1'}">
								���� ���ſϷ� �����Դϴ�.
								<!-- 0418 ��� ��� �߰� -->
								<span id="tc_cancle">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-1">�ֹ����</a>
								</span>
							</c:when>
							<c:when test="${purchase.tranCode=='2'}">
								���� ����� �����Դϴ�.
								<span id="tc_arrive">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=3">�����</a>
								</span>
								<span id="tc_return">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-2">��ǰ��ǰ</a>
								</span>
							</c:when>
							<c:when test="${purchase.tranCode=='3'}">
								���� ��ۿϷ� �����Դϴ�.
								<span id="tc_return">
									<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo}&tranCode=-2">��ǰ��ǰ</a>
								</span>
							</c:when>
							<c:when test="${purchase.tranCode=='-1'}">
								���� �ֹ���� �����Դϴ�.
							</c:when>
							<c:when test="${purchase.tranCode=='-2'}">
							���� ��ǰ��û �����Դϴ�.
							</c:when>
							<c:when test="${purchase.tranCode=='-3'}">
								���� ��ǰ�Ϸ� �����Դϴ�.
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