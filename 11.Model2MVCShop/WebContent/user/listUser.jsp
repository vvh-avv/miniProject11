<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>회원 목록 조회</title>

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
						+"아이디 : "+JSONData.userId+"<br/>"
						+"이  름 : "+JSONData.userName+"<br/>"
						+"이메일 : "+JSONData.email+"<br/>"
						+"ROLE : "+JSONData.role+"<br/>"
						+"등록일 : "+JSONData.regDate+"<br/>"
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
   			<h3>회원목록조회</h3>
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
						<option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>회원ID</option>
						<option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>회원명</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>이메일</option>
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
	            <th align="left" >회원 ID
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
	            <th align="left">회원명</th>
	            <th align="left">이메일</th>
	            <th align="left">주문내역</th>
	            <th align="left">간략정보</th>
	          </tr>
	        </thead>
	        
	        <tbody>
			  <c:set var="i" value="0" />
			  <c:forEach var="user" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr>
				  <td align="left">${ i }</td>
				  <td align="left"  title="Click : 회원정보 확인"><a href="#">${user.userId}</a></td>
				  <td align="left">${user.userName}</td>
				  <td align="left">${user.email}</td>
				  <td align="left">
				 	<button type="button" class="btn btn-info" id="${user.userId}">주문내역보기</button>
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