<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>���� �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
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
		
		$(".ct_list_pop td:nth-child(5)").on("click", function(){
			self.location = "/purchase/getPurchase?tranNo="+$(this).text().trim();
		})
		
		$(".ct_list_pop td:nth-child(7)").on("click", function(){
			self.location = "/product/updateProduct?prodNo="+$(this).text().trim()+"&menu=search";
		})
		
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
		
		$(".ct_list_pop td:nth-child(5)" ).css("color" , "red");
		$(".ct_list_pop:nth-child(4n)" ).css("background-color" , "whitesmoke");
		
	})

</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">

		<form name="detailForm">

			<table width="100%" height="37" border="0" cellpadding="0" cellspacing="0">
				<tr>
					<td width="15" height="37"><img src="/images/ct_ttl_img01.gif" width="15" height="37"></td>
					<td background="/images/ct_ttl_img02.gif" width="100%" style="padding-left: 10px;">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="93%" class="ct_ttl01">���� �����ȸ</td>
							</tr>
						</table>
					</td>
					<td width="12" height="37"><img src="/images/ct_ttl_img03.gif" width="12" height="37"></td>
				</tr>
			</table>

			<!-- 0413 �˻����� �߰�  -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<!-- ��ġ�� ������ �Է°��� �����ϴ� ��� -->
					<c:if test="${!empty search.searchCondition}">
						<td align="right">
							<select name="searchCondition" class="ct_input_g" style="width: 80px">
								<option value="0" selected>��ǰ��</option>
							</select>
							<input type="text" name="searchKeyword" onkeypress="javascript:if(event.keyCode==13) fncGetList('1');"
									class="ct_input_g" style="width: 200px; height: 19px" value="${param.searchKeyword}">
						</td>
					</c:if>

					<!-- ��ġ�� ������ �Է°��� �������� �ʴ� ��� -->
					<c:if test="${empty search.searchCondition }">
						<td align="right">
							<select name="searchCondition" class="ct_input_g" style="width: 80px">
								<option value="0">��ǰ��</option>
							</select>
							<input type="text" name="searchKeyword" class="ct_input_g" style="width: 200px; height: 19px"></td>
					</c:if>

					<td align="right" width="70">
						<table border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="17" height="23"><img src="/images/ct_btnbg01.gif" width="17" height="23"></td>
								<td background="/images/ct_btnbg02.gif" class="ct_btn01" style="padding-top: 3px;">
									<a href="javascript:fncGetList('1');">�˻�</a></td>
								<td width="14" height="23"><img src="/images/ct_btnbg03.gif" width="14" height="23"></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
			<!-- 0413 �˻����� �߰� �� -->


			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td colspan="17">��ü ${resultPage.totalCount} �Ǽ�, ���� ${resultPage.currentPage} ������</td>
				</tr>
				<tr>
					<td class="ct_list_b" width="50">No</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="100">�ֹ�����
						<!-- �ֹ����� ���� ���ñ�� �߰� -->
						<c:choose>
							<c:when test="${requestScope.sort=='asc'}">
								<span id="under">��</span>
							</c:when>
							<c:otherwise>
								<span id="high">��</span>
							</c:otherwise>
						</c:choose>
						<!-- �ֹ����� ���� ���ñ�� �� -->

					</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">�ֹ���ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">���Ż�ǰ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">�޴� ��</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">����� �ּ�</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b" width="150">��ȭ��ȣ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">�����Ȳ</td>
					<td class="ct_line02"></td>
					<td class="ct_list_b">��������</td>
				</tr>
				<tr>
					<td colspan="17" bgcolor="808285" height="1"></td>
				</tr>

				<c:set var="i" value="0" />
				<c:forEach var="purchase" items="${list}">
					<c:set var="i" value="${i+1}" />

					<tr class="ct_list_pop">
						<td align="center">${i}</td>
						<td></td>

						<!-- 0413 �ֹ�����, �ֹ���ȣ, �������� �����Ű�� -->
						<td align="center">${purchase.orderDate}</td>
						<td></td>
						<td align="center">${purchase.tranNo}</td>
						<td></td>
						<td align="center">${purchase.purchaseProd.prodName}</td>
						<td></td>
						<td align="left">${purchase.receiverName}</td>
						<td></td>
						<td align="left">${purchase.divyAddr}</td>
						<td></td>
						<td align="left">${purchase.receiverPhone}</td>
						<td></td>
						<!-- �߰��Ϸ� -->

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
						<td></td>
						<td align="left"></td>
					</tr>
					<tr>
						<td colspan="17" bgcolor="D6D7D6" height="1"></td>
					</tr>
				</c:forEach>
			</table>

			<!-- PageNavigation Start... -->
			<table width="100%" border="0" cellspacing="0" cellpadding="0" style="margin-top: 10px;">
				<tr>
					<td align="center">
						<input type="hidden" id="currentPage" name="currentPage" value="" />
						<jsp:include page="../common/pageNavigator.jsp" /></td>
				</tr>
			</table>
			<!-- PageNavigation End... -->

		</form>

	</div>
</body>
</html>