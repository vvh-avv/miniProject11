<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>ȸ�� ��� ��ȸ</title>

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
		$("form").attr("method","POST").attr("action","/user/listUser").submit();
	}
	
	$(function(){
		$("button.btn.btn-default").on("click", function(){
			fncGetList(1);
		});
		
		$( "td:nth-child(2)" ).on("click" , function() {
			 self.location ="/user/getUser?userId="+$(this).text().trim();
		});
		
		
		$("#searchKeyword").on("keypress", function(event){
			if(event.keyCode==13) { fncGetList('1'); }  
		});
		
		$("button").on("click", function(){
			self.location="/purchase/listPurchase?userId="+$(this).next().val();
		})
		
		$("td:nth-child(6) > i").on("click", function(){
			var userId = $(this).next().val();
			$.ajax({
				url : "/user/json/getUser/"+userId,
				method : "GET",
				dataType : "json" ,
				headers : {
					"Accept" : "application/json",
					"Content-Type" : "application/json"
				},
				success : function(JSONData, status){
					var displayValue = "<h6>"
						+"���̵� : "+JSONData.userId+"<br/>"
						+"��  �� : "+JSONData.userName+"<br/>"
						+"�̸��� : "+JSONData.email+"<br/>"
						+"ROLE : "+JSONData.role+"<br/>"
						+"����� : "+JSONData.regDate+"<br/>"
						+"</h6>";
						
						$("h6").remove();
						$("#info").html(displayValue);
				}
			})//e.o.ajax
		});

		$("#under").on("click", function(){
			self.location = "/user/listUser?sort=desc";
		})
		
		$("#high").on("click", function(){
			self.location = "/user/listUser?sort=asc";
		})
		
	});

</script>

</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
   	
   	<div class="container">
   		<div class="page-header text-info">
   			<h3>ȸ�������ȸ</h3>
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
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ȸ��ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>ȸ����</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>�̸���</option>
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
	            <th align="left" >ȸ�� ID
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
	            <th align="left">ȸ����</th>
	            <th align="left">�̸���</th>
	            <th align="left">�ֹ�����</th>
	            <th align="left">��������</th>
	          </tr>
	        </thead>
	        
	        <tbody>
			  <c:set var="i" value="0" />
			  <c:forEach var="user" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="left">${ i }</td>
				  <td align="left"  title="Click : ȸ������ Ȯ��"><a href="#">${user.userId}</a></td>
				  <td align="left">${user.userName}</td>
				  <td align="left">${user.email}</td>
				  <td align="left">
				 	<button type="button" class="btn btn-info" id="${user.userId}">�ֹ���������</button>
				  	<input type="hidden" value="${user.userId}">
				  </td>
				  <td align="left">
				  	<i class="glyphicon glyphicon-ok" id="info"></i>
				  	<input type="hidden" value="${user.userId}">
				  </td>
				</tr>
	          </c:forEach>
	        </tbody>
   		</table>
   	</div>
   	
 	<!-- PageNavigation Start... -->
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</body>
</html>