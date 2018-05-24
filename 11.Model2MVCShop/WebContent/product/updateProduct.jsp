<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>��ǰ����</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script type="text/javascript" src="../javascript/calendar.js"></script>

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncAddProduct(){
		
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
	
		if(name == null || name.length<1){
			alert("��ǰ���� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("��ǰ�������� �ݵ�� �Է��Ͽ��� �մϴ�.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("�������ڴ� �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		if(price == null || price.length<1){
			alert("������ �ݵ�� �Է��ϼž� �մϴ�.");
			return;
		}
		
		$("form").attr("method", "POST").attr("action", "/product/updateProduct").submit();
	}
	
	$(function(){
		$("td.ct_btn01:contains('���')").on("click", function(){
			history.go(-1);
		})
		
		$("td.ct_btn01:contains('����')").on("click", function(){
			fncAddProduct();
		})
		
		/*
 		$("input[name='price']").on("keyup", function(){
			$("input[name='price']").val( FormatNumber3($("input[name='price']").val()) );
		})
		*/
	})
	
	/*���ݿ� �����޸� ��� ��ũ��Ʈ
	//��ó : https://kin.naver.com/qna/detail.nhn?d1id=1&dirId=1040205&docId=68405952
	function FormatNumber2(num){
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
	}
	*/

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<form name="detailForm" enctype="multipart/form-data">

		<input type="hidden" name="prodNo" value="${product.prodNo}"/>

		<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37" /></td>
				<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01">��ǰ����</td>
							<td width="20%" align="right">&nbsp;</td>
						</tr>
					</table>
				</td>
				<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37" /></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 13px;">
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write"> ��ǰ�� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" /> </td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="105">
								<input type="text" name="prodName" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20" value="${product.prodName}">
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">��ǰ������ <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" />
				</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<input type="text" name="prodDetail" value="${product.prodDetail}" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6">
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">�������� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" /> </td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<input type="text" readonly="readonly" name="manuDate" value="${product.manuDate}" class="ct_input_g" style="width: 100px; height: 19px" maxLength="10" minLength="6">
					&nbsp;
					<img src="../images/ct_icon_date.gif" width="15" height="15" onclick="show_calendar('document.detailForm.manuDate', document.detailForm.manuDate.value)" />
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">���� <img src="/images/ct_icon_red.gif" width="3" height="3" align="absmiddle" /> </td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<input type="text" name="price" value="${product.price}" class="ct_input_g" style="width: 100px; height: 19px" maxLength="50" />&nbsp;��
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
			<tr>
				<td width="104" class="ct_write">��ǰ�̹���</td>
				<td bgcolor="D6D6D6" width="1"></td>
				<td class="ct_write01">
					<!-- ���ϸ� Ȯ�� <c:out value="*${product.fileName}*"/> -->
					<c:choose>
								
						<c:when test="${!empty product.fileName && product.fileName!=' '}">
							<!-- �������� ó�� -->
							<c:if test="${product.fileName.contains(',')}">
								<img src = "/images/uploadFiles/${product.fileName.split(',')[0]}"><br>
								<img src = "/images/uploadFiles/${product.fileName.split(',')[1]}">
							</c:if>
							<c:if test="${!product.fileName.contains(',')}">
								<img src = "/images/uploadFiles/${product.fileName}">
							</c:if>
						</c:when>
						
						<c:otherwise>
							<img src = "/images/empty.GIF">
						</c:otherwise>
					
					</c:choose><br>
					<input type="hidden" name="fileName" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13" value="${product.fileName}" />
					<input multiple="multiple" type="file" name="file" class="ct_input_g" style="width: 200px; height: 19px" maxLength="13" value="${product.fileName}" />
				</td>
			</tr>
			<tr>
				<td height="1" colspan="3" bgcolor="D6D6D6"></td>
			</tr>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
			<tr>
				<td width="53%"></td>
				<td align="right">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>

							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								����
							</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23" /></td>
							<td width="30"></td>

							<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23" /></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
								���
							</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23" /></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>

</body>
</html>
