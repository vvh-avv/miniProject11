<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script type="text/javascript">
	$(function() {
		$("a:contains('�α׾ƿ�')").on("click" , function() {
			$(self.location).attr("href","/user/logout");
			//self.location = "/user/logout"
		}); 
		
		$("a:contains('�α���')").on("click", function(){
			self.location = "/user/login";
		})
		
	 	$("a:contains('ȸ�������ȸ')").on("click" , function() {
			self.location = "/user/listUser";
		});
	 	
	 	$("a:contains('����������ȸ')").on("click" , function() {
			$(self.location).attr("href","/user/getUser?userId=${sessionScope.user.userId}");
		});
	 	
	 	$("a:contains('��ǰ���')").on("click", function(){
	 		self.location="/product/addProductView.jsp";
	 	});
	 	
	 	$("a:contains('��ǰ����')").on("click", function(){
	 		self.location="/product/listProduct?menu=manage";
	 	});
	 	
	 	$("a:contains('��ǰ�˻�')").on("click", function(){
	 		self.location="/product/listProduct?menu=search";
	 	});
	 	
	 	$("a:contains('�����̷���ȸ')").on("click", function(){
	 		self.location="/purchase/listPurchase";
	 	});
	 	
	 	$("a:contains('ȸ�����')").on("click", function(){
	 		self.location="/user/statsUser";
	 	});
	});
</script>
	
<div class="navbar  navbar-inverse navbar-fixed-top">
	
	<div class="container">
	       
		<a class="navbar-brand" href="/index.jsp">Model2 MVC Shop</a>
		
		<!-- toolBar Button Start //////////////////////// -->
		<div class="navbar-header">
		    <button class="navbar-toggle collapsed" data-toggle="collapse" data-target="#target">
		        <span class="sr-only">Toggle navigation</span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		        <span class="icon-bar"></span>
		    </button>
		</div>
		<!-- toolBar Button End //////////////////////// -->
		
	    <!--  dropdown hover Start -->
		<div class="collapse navbar-collapse" id="target" data-hover="dropdown" data-animations="fadeInDownNew fadeInRightNew fadeInUpNew fadeInLeftNew">
	         
	    	<!-- Tool Bar �� �پ��ϰ� ����ϸ�.... -->
	        <ul class="nav navbar-nav">
	             
		        <!--  ȸ������ DrowDown -->
		        <c:if test="${!empty sessionScope.user}">
			        <li class="dropdown">
			        	<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			        	<span >ȸ������</span>
			            <span class="caret"></span>
			            </a>
			            
			            <ul class="dropdown-menu">
			            	<li><a href="#">����������ȸ</a></li>
			                         
			                <c:if test="${sessionScope.user.role == 'admin'}">
			                	<li><a href="#">ȸ�������ȸ</a></li>
			                </c:if>
			                         
			                <li class="divider"></li>
			                <li><a href="#">etc...</a></li>
			            </ul>
			        </li>
		        </c:if>
		                 
		        <!-- �ǸŻ�ǰ���� DrowDown  -->
		        <c:if test="${sessionScope.user.role == 'admin'}">
			    	<li class="dropdown">
			        	<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			        		<span>��ǰ����</span>
			        		<span class="caret"></span>
			       		</a>
			        	<ul class="dropdown-menu">
			        		<li><a href="#">��ǰ���</a></li>
			        		<li><a href="#">��ǰ����</a></li>
			        		<li class="divider"></li>
			        		<li><a href="#">etc..</a></li>
			      	  </ul>
			        </li>
		        </c:if>
		                 
		        <!-- ���Ű��� DrowDown -->
		        <li class="dropdown">
		        	<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
		        		<span >��ǰ����</span>
		        		<span class="caret"></span>
		        	</a>
		        	<ul class="dropdown-menu">
		            	<li><a href="#">��ǰ�˻�</a></li>
			        	<c:if test="${sessionScope.user.role == 'user'}">
		            		<li><a href="#">�����̷���ȸ</a></li>
		            	</c:if>
		             </ul>
		        </li>
		        
		        <!-- ��� DrowDown  -->
		        <c:if test="${sessionScope.user.role == 'admin'}">
			    	<li class="dropdown">
			        	<a  href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false">
			        		<span>���</span>
			        		<span class="caret"></span>
			       		</a>
			        	<ul class="dropdown-menu">
			        		<li><a href="#">ȸ�����</a></li>
			      	  </ul>
			        </li>
		        </c:if>
		        
		        <li><a href="#">etc...</a></li>
	             
	       </ul>
	       
	       <ul class="nav navbar-nav navbar-right">
	       	 <c:if test="${!empty sessionScope.user}">
	       		<li><a>${sessionScope.user.userName}�� �ȳ��ϼ���!</a></li>
	       		<li><a href="#">�α׾ƿ�</a></li>
	       	 </c:if>
	       	 
	       	 <c:if test="${empty sessionScope.user}">
	       		<li><a href="#">�α���</a></li>
	       	 </c:if>
	       </ul>
		</div>
		<!-- dropdown hover END -->	
	    
	</div>
</div>