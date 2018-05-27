<%@ page contentType="text/html; charset=euc-kr"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<title>ȸ��Ż��</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
<link rel="stylesheet" href="/css/admin.css" type="text/css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>

<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

<style>
	body {
		margin-top : 10px;
	}
</style>

<script type="text/javascript">
	$(function(){
		//$("input:nth-of-type(3)") //$("input:radio:last)")
		$("[name=reason][value='��Ÿ']").on("click",function(){
			$("input:text[name=reasonText]").focus();
		});
		
		$("#close").on("click", function(){
			window.close();
		});
		
		$("#submit").on("click", function(){
			var chkValue = $("input:checked").val();
			
			if( chkValue==null || (chkValue=="��Ÿ" && $("input:text[name=reasonText]").val()=="") ){
				alert("������ �ݵ�� �Է����ֽñ� �ٶ��ϴ�.");
			}else{
				if(chkValue=="��Ÿ"){ chkValue = $("input:text[name=reasonText]").val(); }

				$("form").attr("method", "POST").attr("action", "/user/quitUser?userId=${user.userId}&reason="+chkValue).submit();
				top.opener.location="/user/logout";
				//top.opener.location="/user/loginView.jsp";
				window.close();
			}
		});
	});
</script>
</head>

<body>
	<form>
 		<h4>���� Ż���Ͻðڽ��ϱ�?</h4>
			Ż����� : <br>
			<input type="radio" name="reason" value="�������� ������"><font size="2">�������� ������</font><br>
			<input type="radio" name="reason" value="������ ��� ��ǰ�� ���"><font size="2">������ ��� ��ǰ�� ���</font><br>
			<input type="radio" name="reason" value="��Ÿ"><font size="2">��Ÿ</font>&nbsp;<input type="text" name="reasonText"><br>
			<br>
			
			<button id="submit" value="Ȯ��">Ȯ��</button>
			<button id="close" value="���">���</button>
	</form>

</body>
</html>