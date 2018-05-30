<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>��ǰ���</title>

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
	
	// ��üüũ
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
	
	// ��� �ϰ�ó��
	function stateSubmit(){
		//��ǰ��� üũ
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
	
	//������ǰ �������� �� �� ��ǰ�� tranCode���� tran(String)������ ��´�
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
	}else{ //��ǰ�� �ϳ��� �������� ��
		prodList = prodNoAndTranCode.split("+")[0];
		prodNo = prodList;
		tranCode = prodNoAndTranCode.split("+")[1];
	}
	
	//��ۻ��� üũ
	var stateIndex = $("select[name='condition']:selected").val();
	var state = $("select[name='condition']").val();
	
	if(prodList==""){
		alert("��ǰ�� ���� �� ó�����ּ���.");
	}else{
		var conChk = confirm(prodNo+" ��ǰ�� "+state+"ó�� �Ͻðڽ��ϱ�?");
		if(conChk){	
			switch(stateIndex){
				case 0 : //�����ó��
					if(tranCode.indexOf("1")==-1) { alert("����� ó���� �Ұ��մϴ�."); break; } //��ȿ�� üũ
					$("form").attr("method","POST").attr("action","/purchase/updateTranCodeByProd?prodNo='"+prodNo+"'&tranCode=2'").submit();
					alert("ó���Ǿ����ϴ�.");
					break;
				case 1 : //��ǰ
					if(tranCode!=-2) { alert("��ǰó���� �Ұ��մϴ�."); break; } //��ȿ�� üũ
					$("form").attr("method","POST").attr("action","/purchase/updateTranCodeByProd?prodNo='"+prodNo+"'&tranCode=-3'").submit();
					alert("ó���Ǿ����ϴ�.");
					break;
				case 2 : //��ǰ����
					if(tranCode!=-2) { alert("��ǰ����ó���� �Ұ��մϴ�."); break; } //��ȿ�� üũ
					$("form").attr("method","POST").attr("action","/purchase/updateTranCodeByProd?prodNo='"+prodNo+"'&tranCode=${sessionScope.tranCodeTemp}'").submit();
					sessionScope.removeAttribute("tranCodeTemp");
					alert("ó���Ǿ����ϴ�.");
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
		<div class="row"> <!-- �ϳ��� �ο�� ����� -->
			<div class="col-md-2"> <!-- ���⿣ ����� ����ֱ� -->
				<jsp:include page="/history.jsp"/>
			</div>
			<div class="col-md-10"> <!-- ����� ���� �� ����ֱ� -->
				<div class="page-header text-info">
					<c:if test="${param.menu=='manage'}">
						<h3>��ǰ ����</h3>
					</c:if>
					<c:if test="${param.menu=='search'}">
						<h3>��ǰ �����ȸ</h3>
					</c:if>
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
						    	<!-- ���η� �������� ��쿡�� �˻����ǿ� ��ǰ��ȣ�� �����Ű�ڴ�  -->
								<c:if test="${!empty user && user.role=='admin'}">
									<option value="-1" ${search.searchCondition=='-1'?"selected":""}>�ֹ���ȣ</option>
									<option value="0" ${search.searchCondition=='0'?"selected":""}>��ǰ��ȣ</option>
								</c:if>
								<option value="1" ${search.searchCondition=='1'?"selected":""}>��ǰ��</option>
								<option value="2" ${search.searchCondition=='2'?"selected":""}>��ǰ����</option>
							</select>
						  </div>
						  
						  <div class="form-group">
						    <label class="sr-only" for="searchKeyword">�˻���</label>
						    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
						    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }" >
						  </div>
						  
						  <button type="button" class="btn btn-default">�˻�</button>
						  
						  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
						  <input type="hidden" id="currentPage" name="currentPage" value="${resultPage.currentPage}"/>
						  
						</form>
			    	</div>
				</div>
				
				<div>&nbsp;</div>
				
				<c:if test="${sessionScope.user.role=='admin'}">
				<form class="form-inline">
				  <div class="form-group">
				    <p class="form-control-static">������ ��ǰ��</p>
				  </div>
				  <div class="form-group">
				    <select class="form-control" name="condition" >
						<option value="�����">�����</option>
						<option value="��ǰ">��ǰ</option>
						<option value="��ǰ����">��ǰ����</option>
					</select>
				  </div>
					<button type="button" class="btn btn-success" name="delSubmit" value="ó��">ó��</button>
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
							<th align="left">��ǰ�̹���</th>
							<c:if test="${user.role=='admin'}">
								<th align="left">��ǰ��ȣ</th>
							</c:if>
							<th align="left">��ǰ��
								<c:if test="${requestScope.sort=='prod_no asc' || sort=='prod_name asc' || sort=='price asc' || sort=='price desc'}">
									<a href="#"><span id="prodName_under" class="glyphicon glyphicon-chevron-down"></span></a>
								</c:if>
								<c:if test="${requestScope.sort=='prod_name desc'}">
									<a href="#"><span id="prodName_high" class="glyphicon glyphicon-chevron-up"></span></a>
								</c:if>
							</th>
							<th align="left">����
								<c:if test="${requestScope.sort=='prod_no asc' || sort=='price asc' || sort=='prod_name asc' || sort=='prod_name desc'}">
									<a href="#"><span id="price_under" class="glyphicon glyphicon-chevron-down"></span></a>
								</c:if>
								<c:if test="${requestScope.sort=='price desc'}">
									<a href="#"><span id="price_high" class="glyphicon glyphicon-chevron-up"></span></a>
								</c:if>
							</th>
							<th align="left">�����</th>
							<th align="left">�������</th>
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
							<!-- �̹����� ���� ��� -->
							<input type="hidden" value="{product.fileName}" id="hiddenName">
							<a href="#">
								<c:if test="${empty product.fileName}"><img src="http://placehold.it/50X50"/></c:if>
							</a>
							<!-- �̹����� �ִ� ��� -->
							<a role="button" data-toggle="modal" data-target="#myModal" data-whatever="${product.fileName}">
								<c:if test="${!empty product.fileName}"><img src="/images/uploadFiles/${product.fileName}" width="50" height="50"/></c:if>
							</a>
							
							<!-- �̹��� ���â -->
							<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        <h4 class="modal-title" id="myModalLabel">��ǰ�̹��� ũ�Ժ���</h4>
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
						  <td align="left"  title="Click : ��ǰ���� Ȯ��">
						  	<!-- �Ǹ��� ��ǰ�̶�� -->
							<c:if test="${product.proTranCode=='0' || product.proTranCode=='-1'}">
								<a href="${param.menu=='manage'?'/product/updateProduct':'/product/getProduct'}?prodNo=${product.prodNo}&menu=${param.menu}&status=0">${product.prodName}</a>
							</c:if>
							<!-- �Ǹ��� ��ǰ�� �ƴ϶�� -->
							<c:if test="${product.proTranCode!='0' && product.proTranCode!='-1'}">
								<a href="${param.menu=='manage'?'/product/updateProduct':'/product/getProduct'}?prodNo=${product.prodNo}&menu=${param.menu}">${product.prodName}</a>
							</c:if>
						  </td>
						  <td align="left">${product.price}</td>
						  <td align="left">${product.regDate}</td>
						  <td align="left">
						  	<!-- �������� �������� ��� -->
							<c:if test="${!empty user && user.role=='admin'}">
								<c:choose>
									<c:when test="${product.proTranCode.trim()=='0' || product.proTranCode.trim()=='-1'}">
										�Ǹ���
									</c:when>
									<c:when test="${product.proTranCode.trim()=='1'}">
										���ſϷ�
									</c:when>
									<c:when test="${product.proTranCode.trim()=='2'}">
										�����
									</c:when>
									<c:when test="${product.proTranCode.trim()=='3'}">
										��ۿϷ�
									</c:when>
									<c:when test="${product.proTranCode.trim()=='-2'}">
										��ǰ��û					
									</c:when>
									<c:when test="${product.proTranCode.trim()=='-3'}">
										��ǰ�Ϸ�
									</c:when>
								</c:choose>
							</c:if>
							<!-- ������ �������� ��� -->
							<c:if test="${empty user || user.role=='user'}">
								<c:choose>
									<c:when test="${product.proTranCode.trim()=='0' || product.proTranCode.trim()=='-1'}">
										�Ǹ���
									</c:when>
									<c:when test="${product.proTranCode.trim()!='0'}">
										������
									</c:when>
								</c:choose>
							</c:if>
						  </td>
						</tr>
			          </c:forEach>
			        </tbody>
				</table>
			</div>
			
		</div><!--�ϳ��Ƿο츦�����end-->
		
		<div class="row"><!--Ǫ�ͷο�-->
			<!-- PageNavigation Start... -->
			<jsp:include page="../common/pageNavigator_new.jsp"/>
			<!-- PageNavigation End... -->
		
			<br><br>
			<!-- �ν�Ÿ�׷� -->
			<jsp:include page="../layout/instagram.jsp"/>
		</div><!--Ǫ�ͷο�end-->
		
	</div><!--e.o.container-->
		
</body>
</html>