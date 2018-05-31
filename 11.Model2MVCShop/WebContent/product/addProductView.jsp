<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<!DOCTYPE html>
<html>
<head>
<title>��ǰ���</title>

<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link rel="shortcut icon" href="/images/common/favicon.ico">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

<!-- Ķ���� -->
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<style>
	body > div.container{
		margin-top : 50px;
	}
</style>

<script type="text/javascript">
	function fncAddProduct(){
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
	
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			$("input[name='prodName']").focus();
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			$("input[name='prodDetail']").focus();
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			$("input[name='manuDate']").focus();
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			$("input[name='price']").focus();
			return;
		}
	
		$("form").attr("method", "POST").attr("action", "/product/addProduct").submit();
	}
	
	$(function(){
		$("button.btn.btn-primary:contains('���')").on("click", function(){
			$("form")[0].reset();
		})
		
		$("button.btn.btn-primary:contains('���')").on("click", function(){
			fncAddProduct();
		})
	    
        $("#manuDate").datepicker();
        $("#manuDate").datepicker("option", "dateFormat", "yymmdd");
		
	 	//$("input[name='price']").on("keyup", function(){
		//$("input[name='price']").val( FormatNumber3($("input[name='price']").val()) );
		//})
	})
	
	//���ݿ� �����޸� ��� ��ũ��Ʈ
	//��ó : https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=1040205&docId=68405952
	/* function FormatNumber2(num){
		fl=""
		if(isNaN(num)) { alert("���ڴ� ����� �� �����ϴ�.");return 0}
		if(num==0) return num
	
		if(num<0){ 
			num=num*(-1)
			fl="-"
		}else{
			num=num*1 //ó�� �Է°��� 0���� �����Ҷ� �̰��� �����Ѵ�.
		}
		num = new String(num)
		temp=""
		co=3
		num_len=num.length
		while (num_len>0){
			num_len=num_len-co
			if(num_len<0){co=num_len+co;num_len=0}
			temp=","+num.substr(num_len,co)+temp
		}
		return fl+temp.substr(1)
	}
	
	function FormatNumber3(num){
		num=new String(num)
		num=num.replace(/,/gi,"")
		return FormatNumber2(num)
	} */
</script>
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
	<!-- ToolBar End /////////////////////////////////////-->
	
	<div class="container">
	
		<div class="page-header">
			<h3 class="text-info">��ǰ���</h3>
		</div>
		
		<form class="form-horizontal" enctype="multipart/form-data">
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��ǰ��</strong></div>
				<div class="col-xs-8 col-md-4">
					<input type="text" class="form-control" id="prodName" name="prodName" placeholder="��ǰ��">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��ǰ������</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="��ǰ������">
				</div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��������</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input type="text" class="form-control" id="manuDate" readonly="readonly" name="manuDate">
			    </div>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>����</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input type="text" class="form-control" id="price" name="price" placeholder="����">
			    </div>
			    <h5 class="text-left">��</h5>
			</div><hr>
			
			<div class="form-group">
				<div class="col-xs-4 col-md-2"><strong>��ǰ�̹���</strong></div>
			    <div class="col-xs-8 col-md-4">
			      <input multiple="multiple" type="file" class="form-control" id="file" name="file">
			    </div>
			</div><hr>
			
			<div class="form-group">
		    	<div class="col-sm-offset-4  col-sm-4 text-center">
		      		<button type="button" class="btn btn-primary">���</button>
			  		<button type="button" class="btn btn-primary">���</button>
		    	</div>
		  </div>
			
		</form>
	</div>
	
</body>
</html>