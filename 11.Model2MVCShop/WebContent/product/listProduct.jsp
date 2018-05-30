<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>상품목록</title>

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
		$("form").attr("method","POST").attr("action","/product/listProduct?menu=${param.menu=='manage'?'manage':'search'}").submit();
	}
	
	$(function(){
		$("button.btn.btn-default").on("click", function(){
			fncGetList(1);
		});
		
		$("button[name='delSubmit']").on("click", function(){
			 stateSubmit();
		})
		
		$("#searchKeyword").on("keypress", function(event){
			if(event.keyCode==13) { fncGetList('1'); }  
		});
		
		$("#prodName_under").on("click", function(){
			self.location = "/product/listProduct?sort=prod_name+desc&menu=${param.menu}";
		})
		
		$("#prodName_high").on("click", function(){
			self.location = "/product/listProduct?sort=prod_name+asc&menu=${param.menu}";
		})
		
		$("#price_under").on("click", function(){
			self.location = "/product/listProduct?sort=price+desc&menu=${param.menu}";
		})
		
		$("#price_high").on("click", function(){
			self.location = "/product/listProduct?sort=price+asc&menu=${param.menu}";
		})
		
		$("#myModal").on("show.bs.modal", function(event){
			var button = $(event.relatedTarget);
			var recipient = button.data('whatever');
			$(this).find('.modal-body img').attr("src","/images/uploadFiles/"+recipient);
		})
		
	})
	
	// 전체체크
	function allChk(obj){ 
		var chkObj = $("input[name='prodList']");
		var rowCnt = chkObj.length-1;
		var check = obj.checked;
		if(check){
			for(var i=0; i<=rowCnt; i++){
				if(chkObj[i].type=="checkbox"){
					chkObj[i].checked=true;
				}
			}
		}else{
			for(var i=0;i<=rowCnt;i++){
				if(chkObj[i].type=="checkbox"){
					chkObj[i].checked=false;
				}
			}
		}
	}
	
	// 배송 일괄처리
	function stateSubmit(){
		//상품목록 체크
		var chkProd = $("input[name='prodList']");
		var prodNoAndTranCode = "";
		for(var i=0;i<chkProd.length;i++){
			if(chkProd[i].checked==true){
				if(prodNoAndTranCode=="") {
					prodNoAndTranCode += chkProd[i].value;
				}else {
					prodNoAndTranCode += ","+chkProd[i].value;
				}
			}
		}
	
	//여러제품 선택했을 때 각 제품의 tranCode값을 tran(String)변수에 담는다
	var prodList = "";
	var prodNo = "";
	var tranCode = "";
	if(prodNoAndTranCode.indexOf(",")!=-1){
		prodList = prodNoAndTranCode.split(",");
		for(var i=0; i<prodList.length; i++){
			tranCode += "#"+prodList[i].split("+")[1];
			if(i==0) { prodNo += prodList[i].split("+")[0]; }
			else { prodNo += ","+prodList[i].split("+")[0]; }
		}
		ListChk = "true";
	}else{ //제품을 하나만 선택했을 때
		prodList = prodNoAndTranCode.split("+")[0];
		prodNo = prodList;
		tranCode = prodNoAndTranCode.split("+")[1];
	}
	
	//배송상태 체크
	var stateIndex = $("select[name='condition']:selected").val();
	var state = $("select[name='condition']").val();
	
	if(prodList==""){
		alert("상품을 선택 후 처리해주세요.");
	}else{
		var conChk = confirm(prodNo+" 상품을 "+state+"처리 하시겠습니까?");
		if(conChk){	
			switch(stateIndex){
				case 0 : //배송중처리
					if(tranCode.indexOf("1")==-1) { alert("배송중 처리가 불가합니다."); break; } //유효성 체크
					$("form").attr("method","POST").attr("action","/purchase/updateTranCodeByProd?prodNo='"+prodNo+"'&tranCode=2'").submit();
					alert("처리되었습니다.");
					break;
				case 1 : //반품
					if(tranCode!=-2) { alert("반품처리가 불가합니다."); break; } //유효성 체크
					$("form").attr("method","POST").attr("action","/purchase/updateTranCodeByProd?prodNo='"+prodNo+"'&tranCode=-3'").submit();
					alert("처리되었습니다.");
					break;
				case 2 : //반품거절
					if(tranCode!=-2) { alert("반품거절처리가 불가합니다."); break; } //유효성 체크
					$("form").attr("method","POST").attr("action","/purchase/updateTranCodeByProd?prodNo='"+prodNo+"'&tranCode=${sessionScope.tranCodeTemp}'").submit();
					sessionScope.removeAttribute("tranCodeTemp");
					alert("처리되었습니다.");
					break;
				}
		}
	}
	
}

</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->

	<div class="container">
		<div class="row"> <!-- 하나의 로우로 만들고 -->
			<div class="col-md-2"> <!-- 여기엔 윙배너 집어넣기 -->
				<jsp:include page="/history.jsp"/>
			</div>
			<div class="col-md-10"> <!-- 여기다 원래 폼 집어넣기 -->
				<div class="page-header text-info">
					<c:if test="${param.menu=='manage'}">
						<h3>상품 관리</h3>
					</c:if>
					<c:if test="${param.menu=='search'}">
						<h3>상품 목록조회</h3>
					</c:if>
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
						    	<!-- 어드민로 접속했을 경우에만 검색조건에 상품번호를 노출시키겠다  -->
								<c:if test="${!empty user && user.role=='admin'}">
									<option value="-1" ${search.searchCondition=='-1'?"selected":""}>주문번호</option>
									<option value="0" ${search.searchCondition=='0'?"selected":""}>상품번호</option>
								</c:if>
								<option value="1" ${search.searchCondition=='1'?"selected":""}>상품명</option>
								<option value="2" ${search.searchCondition=='2'?"selected":""}>상품가격</option>
							</select>
						  </div>
						  
						  <div class="form-group">
						    <label class="sr-only" for="searchKeyword">검색어</label>
						    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
						    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
						  </div>
						  
						  <button type="button" class="btn btn-default">검색</button>
						  
						  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
						  <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
						  
						</form>
			    	</div>
				</div>
				
				<div>&nbsp;</div>
				
				<c:if test="${sessionScope.user.role=='admin'}">
				<form class="form-inline">
				  <div class="form-group">
				    <p class="form-control-static">선택한 상품을</p>
				  </div>
				  <div class="form-group">
				    <select class="form-control" name="condition" >
						<option value="배송중">배송중</option>
						<option value="반품">반품</option>
						<option value="반품거절">반품거절</option>
					</select>
				  </div>
					<button type="button" class="btn btn-success" name="delSubmit" value="처리">처리</button>
				</form>
				</c:if>
				
				<table class="table table-hover table-striped">
					<thead>
						<tr>
							<th align="center">
								<c:if test="${sessionScope.user.role=='admin'}">
								  <label class="checkbox-inline">
									  <input type="checkbox" name="prodListAll" value="prodAll" onclick="allChk(this);"> No
								  </label>
								</c:if>
								
								<c:if test="${sessionScope.user.role!='admin'}">
									No
								</c:if>
							</th>
							<th align="left">상품이미지</th>
							<c:if test="${user.role=='admin'}">
								<th align="left">상품번호</th>
							</c:if>
							<th align="left">상품명
								<c:if test="${requestScope.sort=='prod_no asc' || sort=='prod_name asc' || sort=='price asc' || sort=='price desc'}">
									<a href="#"><span id="prodName_under" class="glyphicon glyphicon-chevron-down"></span></a>
								</c:if>
								<c:if test="${requestScope.sort=='prod_name desc'}">
									<a href="#"><span id="prodName_high" class="glyphicon glyphicon-chevron-up"></span></a>
								</c:if>
							</th>
							<th align="left">가격
								<c:if test="${requestScope.sort=='prod_no asc' || sort=='price asc' || sort=='prod_name asc' || sort=='prod_name desc'}">
									<a href="#"><span id="price_under" class="glyphicon glyphicon-chevron-down"></span></a>
								</c:if>
								<c:if test="${requestScope.sort=='price desc'}">
									<a href="#"><span id="price_high" class="glyphicon glyphicon-chevron-up"></span></a>
								</c:if>
							</th>
							<th align="left">등록일</th>
							<th align="left">현재상태</th>
						</tr>
					</thead>
					
					<tbody>
					  <c:set var="i" value="0" />
					  <c:forEach var="product" items="${list}">
						<c:set var="i" value="${ i+1 }" />
						<tr>
						  <td align="left">
						  	<c:if test="${sessionScope.user.role=='admin'}">
							  <label class="checkbox-inline">
								  <input type="checkbox" name="prodList" value="${product.prodNo}+${product.proTranCode}">
								  <c:if test="${resultPage.currentPage=='1'}"> ${i} </c:if>
								  <c:if test="${resultPage.currentPage!='1'}"> ${(i+resultPage.pageSize*(resultPage.currentPage-1))} </c:if>
							  </label>
							  </c:if>
							  
							  <c:if test="${sessionScope.user.role!='admin'}">
								  <c:if test="${resultPage.currentPage=='1'}"> ${i} </c:if>
								  <c:if test="${resultPage.currentPage!='1'}"> ${(i+resultPage.pageSize*(resultPage.currentPage-1))} </c:if>
							  </c:if>
						  </td>
						  <td align="left">
							<!-- 이미지가 없는 경우 -->
							<input type="hidden" value="{product.fileName}" id="hiddenName">
							<a href="#">
								<c:if test="${empty product.fileName}"><img src="http://placehold.it/50X50"/></c:if>
							</a>
							<!-- 이미지가 있는 경우 -->
							<a role="button" data-toggle="modal" data-target="#myModal" data-whatever="${product.fileName}">
								<c:if test="${!empty product.fileName}"><img src="/images/uploadFiles/${product.fileName}" width="50" height="50"/></c:if>
							</a>
							
							<!-- 이미지 모달창 -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        <h4 class="modal-title" id="myModalLabel">상품이미지 크게보기</h4>
							      </div>
							      <div class="modal-body">
							      	<img width="500" height="500" />
								  </div>				 	      
							    </div>
							  </div>
							</div>	
						  </td>
						  
						  <c:if test="${sessionScope.user.role=='admin'}">
						  	<td align="left">${product.prodNo}</td>
						  </c:if>
						  <td align="left"  title="Click : 상품정보 확인">
						  	<!-- 판매중 상품이라면 -->
							<c:if test="${product.proTranCode=='0' || product.proTranCode=='-1'}">
								<a href="${param.menu=='manage'?'/product/updateProduct':'/product/getProduct'}?prodNo=${product.prodNo}&menu=${param.menu}&status=0">${product.prodName}</a>
							</c:if>
							<!-- 판매중 상품이 아니라면 -->
							<c:if test="${product.proTranCode!='0' && product.proTranCode!='-1'}">
								<a href="${param.menu=='manage'?'/product/updateProduct':'/product/getProduct'}?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a>
							</c:if>
						  </td>
						  <td align="left">${product.price}</td>
						  <td align="left">${product.regDate}</td>
						  <td align="left">
						  	<!-- 어드민으로 접속했을 경우 -->
							<c:if test="${!empty user && user.role=='admin'}">
								<c:choose>
									<c:when test="${product.proTranCode.trim()=='0' || product.proTranCode.trim()=='-1'}">
										판매중
									</c:when>
									<c:when test="${product.proTranCode.trim()=='1'}">
										구매완료
									</c:when>
									<c:when test="${product.proTranCode.trim()=='2'}">
										배송중
									</c:when>
									<c:when test="${product.proTranCode.trim()=='3'}">
										배송완료
									</c:when>
									<c:when test="${product.proTranCode.trim()=='-2'}">
										반품신청					
									</c:when>
									<c:when test="${product.proTranCode.trim()=='-3'}">
										반품완료
									</c:when>
								</c:choose>
							</c:if>
							<!-- 유저로 접속했을 경우 -->
							<c:if test="${empty user || user.role=='user'}">
								<c:choose>
									<c:when test="${product.proTranCode.trim()=='0' || product.proTranCode.trim()=='-1'}">
										판매중
									</c:when>
									<c:when test="${product.proTranCode.trim()!='0'}">
										재고없음
									</c:when>
								</c:choose>
							</c:if>
						  </td>
						</tr>
			          </c:forEach>
			        </tbody>
				</table>
			</div>
			
		</div><!--하나의로우를만들고end-->
		
		<div class="row"><!--푸터로우-->
			<!-- PageNavigation Start... -->
			<jsp:include page="../common/pageNavigator_new.jsp"/>
			<!-- PageNavigation End... -->
		
			<br><br>
			<!-- 인스타그램 -->
			<jsp:include page="../layout/instagram.jsp"/>
		</div><!--푸터로우end-->
		
	</div><!--e.o.container-->
		
</body>
</html>